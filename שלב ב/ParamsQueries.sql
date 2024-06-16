SELECT M.Name AS MaterialName, M.Type, M.ExpiryDate, COUNT(DISTINCT C.Dishs_ID) AS DishCount
FROM Material M
LEFT JOIN Contain C ON M.Material_ID = C.Material_ID
WHERE M.ExpiryDate BETWEEN TO_DATE(&start_date, 'DD/MM/YYYY') AND TO_dATE(&end_date, 'DD/MM/YYYY')
GROUP BY M.Name, M.Type, M.ExpiryDate
HAVING COUNT(DISTINCT C.Dishs_ID) > 0
ORDER BY M.ExpiryDate DESC;


SELECT C.Name AS CateringName, C.Cosher, COUNT(WI.Worker_ID) AS TotalWorkers
FROM Catering C
LEFT JOIN WorkingIn WI ON C.Catering_ID = WI.Catering_ID
WHERE C.Cosher = &<name="cosher" list="Y,N" type="string">
GROUP BY C.Name, C.Cosher
HAVING COUNT(WI.Worker_ID) >= 3
ORDER BY TotalWorkers DESC;


SELECT
    O.Order_ID,
    O.TotalPrice,
    O.Order_Date,
    COUNT(B.Dishs_ID) AS DishCount,
    AVG(O.TotalPrice) OVER () AS AvgOrderPrice,
    (SELECT COUNT(*) FROM The_Order WHERE Customer_ID = O.Customer_ID) AS TotalOrdersByCustomer
FROM
    The_Order O
LEFT JOIN
    Belong B ON O.Order_ID = B.Order_ID
WHERE
    O.Order_ID IN (&<name="order_ID" list="SELECT Order_ID FROM The_Order" multiselect="yes"> )
GROUP BY
    O.Order_ID, O.TotalPrice, O.Order_Date, O.Customer_ID
ORDER BY
    O.Order_Date DESC;
    

SELECT DISTINCT D.Dishs_ID, D.Name AS DishName, D.Price, D.CosherType, AVG(D.Price) OVER () AS AvgDishPrice
FROM Dishs D
LEFT JOIN Contain C ON D.Dishs_ID = C.Dishs_ID
WHERE C.Material_ID IN (&<name="Materials" list="SELECT Material_ID FROM Material" multiselect="yes" >)
GROUP BY D.Dishs_ID, D.Name, D.Price, D.CosherType
ORDER BY D.Price DESC;
