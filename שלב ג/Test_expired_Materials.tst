PL/SQL Developer Test script 3.0
35
DECLARE
    v_expired_materials SYS_REFCURSOR;
    v_material_id Material.Material_ID%TYPE;
    v_material_name Material.Name%TYPE;
    v_material_type Material.Type%TYPE;
    v_expiry_date Material.ExpiryDate%TYPE;
    v_used_in_dishes NUMBER;
    v_total_quantity NUMBER;
    v_status VARCHAR2(20);
    v_usage_level VARCHAR2(10);
BEGIN
    v_expired_materials := get_expired_materials(7);

    DBMS_OUTPUT.PUT_LINE('Expired and Expiring Materials (including those expiring in 7 days):');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    LOOP
        FETCH v_expired_materials INTO 
            v_material_id, v_material_name, v_material_type, v_expiry_date, 
            v_used_in_dishes, v_total_quantity, v_status, v_usage_level;
        EXIT WHEN v_expired_materials%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_material_id || 
                             ' - Name: ' || v_material_name || 
                             ' (' || v_material_type || ')' ||
                             ' - Expiry Date: ' || TO_CHAR(v_expiry_date, 'YYYY-MM-DD') ||
                             ' - Used in ' || v_used_in_dishes || ' dishes' ||
                             ' - Total Quantity: ' || v_total_quantity ||
                             ' - Status: ' || v_status ||
                             ' - Usage Level: ' || v_usage_level);
    END LOOP;
    CLOSE v_expired_materials;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
2
result
1
<Cursor>
-116
p_days_threshold
1
4
-4
0
