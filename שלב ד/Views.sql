--first view
CREATE OR REPLACE VIEW worker_catering_view AS
SELECT 
    w.Worker_ID,
    w.Name AS Worker_Name,
    w.WorkHoures,
    w.Salary,
    c.Catering_ID,
    c.Name AS Catering_Name,
    c.Cosher AS Is_Kosher,
    d.Dishs_ID,
    d.Name AS Dish_Name,
    d.Price AS Dish_Price,
    d.CosherType
FROM 
    Worker w
JOIN WorkingIn wi ON w.Worker_ID = wi.Worker_ID
JOIN Catering c ON wi.Catering_ID = c.Catering_ID
JOIN Dishs d ON c.Catering_ID = d.Catering_ID;
--first query
SELECT 
    Worker_Name,
    Catering_Name,
    Dish_Name,
    Dish_Price
FROM 
    worker_catering_view
WHERE 
    Is_Kosher = 'Y'
    AND CosherType = 'Meat'
ORDER BY 
    Worker_Name, Dish_Price DESC;

--second query    
UPDATE Worker w
SET w.Salary = w.Salary * 1.10
WHERE w.Worker_ID IN (
    SELECT DISTINCT Worker_ID
    FROM worker_catering_view
    WHERE WorkHoures > 6
    AND Dish_Price > 50
);

--secondview
CREATE OR REPLACE VIEW child_kindergarten_view AS
SELECT 
    c.ChildId,
    c.first_name || ' ' || c.last_name AS child_full_name,
    c.dateOfBirth,
    c.allergies,
    r.registrationId_,
    r.registrationDate,
    r.r_language,
    r.status,
    kt.type_name AS kindergarten_type,
    kt.age_groupe,
    k.kindergartenId,
    k.k_language AS kindergarten_language,
    k.capacity,
    b.address AS kindergarten_address,
    b.accesible AS building_accessible,
    t.teacher_Id,
    t.t_name AS teacher_name,
    t.t_role AS teacher_role
FROM 
    Child c
JOIN Registration r ON c.ChildId = r.registrationId_
JOIN K_Type kt ON r.k_type_id = kt.k_type_Id
JOIN Kindergarten k ON r.kindergartenId = k.kindergartenId
JOIN Buildings b ON k.b_num = b.b_num
LEFT JOIN Teacher t ON k.kindergartenId = t.kindergartenId;

--first query
SELECT 
    child_full_name,
    dateOfBirth,
    kindergarten_type,
    kindergarten_language,
    kindergarten_address,
    teacher_name,
    teacher_role
FROM 
    child_kindergarten_view
WHERE 
    building_accessible = 'yes'
    AND status = 'Accepted'
ORDER BY 
    age_groupe, child_full_name;
    
--second query
UPDATE Registration r
SET r.status = 'notAccepted'
WHERE r.registrationId_ IN (
    SELECT ChildId
    FROM child_kindergarten_view
    WHERE allergies IS NOT NULL
    AND capacity = (
        SELECT COUNT(*)
        FROM child_kindergarten_view cv2
        WHERE cv2.kindergartenId = child_kindergarten_view.kindergartenId
        AND cv2.status = 'Accepted'
    )
);

