SELECT C.Name AS CateringName, COALESCE(SUM(W.Salary), 0) AS TotalSalary
FROM Catering C
LEFT JOIN WorkingIn WI ON C.Catering_ID = WI.Catering_ID
LEFT JOIN Worker W ON WI.Worker_ID = W.Worker_ID
GROUP BY C.Name
ORDER BY TotalSalary DESC;


SELECT CateringName, AvgSalary
FROM (
    SELECT C.Name AS CateringName, AVG(W.Salary) AS AvgSalary,
           ROW_NUMBER() OVER (ORDER BY AVG(W.Salary) DESC) AS rn
    FROM Catering C
    JOIN WorkingIn WI ON C.Catering_ID = WI.Catering_ID
    JOIN Worker W ON WI.Worker_ID = W.Worker_ID
    WHERE C.Cosher = 'Y'
    GROUP BY C.Name
) 
WHERE rn <= 2;


SELECT M.Name AS MaterialName, COUNT(DISTINCT C.Dishs_ID) AS DishCount
FROM Material M
JOIN Contain C ON M.Material_ID = C.Material_ID
GROUP BY M.Name
HAVING COUNT(DISTINCT C.Dishs_ID) > 1
ORDER BY DishCount DESC;


SELECT Customer_ID, Name, Email, Address, PhoneNumber
FROM Customer
WHERE Customer_ID IN (
    SELECT Customer_ID
    FROM The_Order
    GROUP BY Customer_ID
    HAVING COUNT(Order_ID) > 1
)
UNION
SELECT Customer_ID, Name, Email, Address, PhoneNumber
FROM Customer
WHERE Customer_ID IN (
    SELECT Customer_ID
    FROM The_Order
    GROUP BY Customer_ID
    HAVING SUM(TotalPrice) > 500
);


UPDATE Dishs D
SET D.CosherType = 'Dairy'
WHERE D.Dishs_ID IN (
    SELECT DISTINCT C.Dishs_ID
    FROM Contain C
    RIGHT JOIN Material M ON C.Material_ID = M.Material_ID
    WHERE M.Type = 'dairy'
);


UPDATE Worker W
SET W.Salary = 3500
WHERE W.Worker_ID IN (
    SELECT WI.Worker_ID
    FROM WorkingIn WI
    LEFT JOIN Catering C ON WI.Catering_ID = C.Catering_ID
    WHERE C.Catering_ID IN (
        SELECT D.Catering_ID
        FROM Dishs D
        GROUP BY D.Catering_ID
        HAVING COUNT(D.Dishs_ID) >= 2
    )
);


DELETE FROM Customer C
WHERE C.Customer_ID IN (
    SELECT C.Customer_ID
    FROM Customer C
    LEFT JOIN The_Order O ON C.Customer_ID = O.Customer_ID
    WHERE O.Order_ID IS NULL
);


DELETE FROM Belong B
WHERE B.Order_ID IN (
    SELECT O.Order_ID
    FROM The_Order O
    WHERE NOT EXISTS (
        SELECT 1
        FROM Belong BL
        JOIN Contain C ON BL.Dishs_ID = C.Dishs_ID
        JOIN Material M ON C.Material_ID = M.Material_ID
        WHERE BL.Order_ID = O.Order_ID
        AND M.ExpiryDate >= SYSDATE
    )
);
DELETE FROM The_Order O
WHERE O.Order_ID IN (
    SELECT O.Order_ID
    FROM The_Order O
    LEFT JOIN Belong B ON O.Order_ID = B.Order_ID
    WHERE B.Order_ID IS NULL
);
