create or replace function get_catering_revenue(p_catering_id IN Catering.Catering_ID%TYPE,
    p_start_date IN DATE,
    p_end_date IN DATE) return number is
  v_revenue NUMBER := 0;
  
  CURSOR c_orders IS
        SELECT o.TotalPrice
        FROM The_Order o
        JOIN Belong b ON o.Order_ID = b.Order_ID
        JOIN Dishs d ON b.Dishs_ID = d.Dishs_ID
        WHERE d.Catering_ID = p_catering_id
        AND o.Order_Date BETWEEN p_start_date AND p_end_date;
    
    v_order_price The_Order.TotalPrice%TYPE;
begin
  OPEN c_orders;
    LOOP
        FETCH c_orders INTO v_order_price;
        EXIT WHEN c_orders%NOTFOUND;
        v_revenue := v_revenue + v_order_price;
    END LOOP;
    CLOSE c_orders;
    
    RETURN v_revenue;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        RETURN NULL;
end get_catering_revenue;
/
