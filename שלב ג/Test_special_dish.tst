PL/SQL Developer Test script 3.0
40
DECLARE
    v_materials SYS_REFCURSOR;
    v_dish_ID Dishs.Dishs_Id%TYPE := '1';
    v_dish_name Dishs.Name%TYPE := 'Bolonez';
    v_dish_price Dishs.Price%TYPE := 89.99;
    v_cosher_type Dishs.CosherType%TYPE := 'Meat';
    v_catering_id Dishs.Catering_ID%TYPE := 58; 
BEGIN
    OPEN v_materials FOR
        SELECT 1233 AS material_id, 2 AS quantity FROM DUAL UNION ALL
        SELECT 8191 AS material_id, 3 AS quantity FROM DUAL UNION ALL
        SELECT 7363 AS material_id, 1 AS quantity FROM DUAL;

    add_special_dish(
        p_ID => v_dish_ID,
        p_name => v_dish_name,
        p_price => v_dish_price,
        p_cosher_type => v_cosher_type,
        p_catering_id => v_catering_id,
        p_materials => v_materials
    );

    DBMS_OUTPUT.PUT_LINE('Verifying dish insertion:');
    FOR dish_rec IN (SELECT * FROM Dishs WHERE Name = v_dish_name) LOOP
        DBMS_OUTPUT.PUT_LINE('Dish added: ' || dish_rec.Name || ', Price: ' || dish_rec.Price || ', Special: ' || dish_rec.IsSpecial);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Verifying materials:');
    FOR material_rec IN (SELECT c.Quantity, m.Name 
                         FROM Contain c
                         JOIN Dishs d ON c.Dishs_ID = d.Dishs_ID
                         JOIN Material m ON c.Material_ID = m.Material_ID
                         WHERE d.Name = v_dish_name) LOOP
        DBMS_OUTPUT.PUT_LINE('Material: ' || material_rec.Name || ', Quantity: ' || material_rec.Quantity);
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
0
0
