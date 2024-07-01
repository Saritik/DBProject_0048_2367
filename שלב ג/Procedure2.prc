create or replace procedure add_special_dish(p_ID IN Dishs.Dishs_Id%TYPE,
    p_name IN Dishs.Name%TYPE,
    p_price IN Dishs.Price%TYPE,
    p_cosher_type IN Dishs.CosherType%TYPE,
    p_catering_id IN Dishs.Catering_ID%TYPE,
    p_materials IN SYS_REFCURSOR) is
    v_dish_id Dishs.Dishs_ID%TYPE;
    
    TYPE r_material IS RECORD (
        material_id Material.Material_ID%TYPE,
        quantity Contain.Quantity%TYPE
    );
    v_material r_material;
begin
  INSERT INTO Dishs (Dishs_Id, Name, Price, CosherType, Catering_ID, IsSpecial)
    VALUES (p_ID, p_name, p_price, p_cosher_type, p_catering_id, 1)
    RETURNING Dishs_ID INTO v_dish_id;

    LOOP
        FETCH p_materials INTO v_material;
        EXIT WHEN p_materials%NOTFOUND;
        
        INSERT INTO Contain (Quantity, Dishs_ID, Material_ID)
        VALUES (v_material.quantity, v_dish_id, v_material.material_id);
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Special dish added successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK;
end add_special_dish;
/
