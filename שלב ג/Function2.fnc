create or replace function get_expired_materials(p_days_threshold IN NUMBER DEFAULT 0) return SYS_REFCURSOR is
  v_result SYS_REFCURSOR;
  v_total_expired NUMBER := 0;
  v_total_expiring_soon NUMBER := 0;
begin
 OPEN v_result FOR
        WITH material_usage AS (
            SELECT m.Material_ID, m.Name, m.Type, m.ExpiryDate,
                   COUNT(DISTINCT c.Dishs_ID) AS used_in_dishes,
                   NVL(SUM(c.Quantity), 0) AS total_quantity
            FROM Material m
            LEFT JOIN Contain c ON m.Material_ID = c.Material_ID
            GROUP BY m.Material_ID, m.Name, m.Type, m.ExpiryDate
        )
        SELECT mu.Material_ID, 
               mu.Name, 
               mu.Type, 
               mu.ExpiryDate,
               mu.used_in_dishes,
               mu.total_quantity,
               CASE 
                   WHEN mu.ExpiryDate <= SYSDATE THEN 'Expired'
                   WHEN mu.ExpiryDate <= SYSDATE + p_days_threshold THEN 'Expiring Soon'
                   ELSE 'Valid'
               END AS status,
               CASE 
                   WHEN mu.used_in_dishes > 5 THEN 'High'
                   WHEN mu.used_in_dishes > 2 THEN 'Medium'
                   ELSE 'Low'
               END AS usage_level
        FROM material_usage mu
        WHERE mu.ExpiryDate <= SYSDATE + p_days_threshold
        ORDER BY mu.ExpiryDate, mu.used_in_dishes DESC;

    SELECT COUNT(CASE WHEN ExpiryDate <= SYSDATE THEN 1 END),
           COUNT(CASE WHEN ExpiryDate > SYSDATE AND ExpiryDate <= SYSDATE + p_days_threshold THEN 1 END)
    INTO v_total_expired, v_total_expiring_soon
    FROM Material
    WHERE ExpiryDate <= SYSDATE + p_days_threshold;

    DBMS_OUTPUT.PUT_LINE('Total expired materials: ' || v_total_expired);
    DBMS_OUTPUT.PUT_LINE('Total materials expiring soon: ' || v_total_expiring_soon);

    RETURN v_result;
EXCEPTION
    WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
       RETURN NULL;
end get_expired_materials;
/
