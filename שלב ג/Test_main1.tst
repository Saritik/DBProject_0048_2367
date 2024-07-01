PL/SQL Developer Test script 3.0
33
DECLARE
    v_worker_id Worker.Worker_ID%TYPE;
    v_salary_increase NUMBER := 500;
    v_catering_id Catering.Catering_ID%TYPE;
    v_start_date DATE;
    v_end_date DATE;
    v_kosher_revenue NUMBER := 0;
    
    -- Cursor for workers working more than 9 hours
    CURSOR c_workers IS
        SELECT Worker_ID
        FROM Worker
        WHERE WorkHoures > 11;
BEGIN
    -- Update worker salaries for those working more than 9 hours
    FOR worker_rec IN c_workers LOOP
        update_worker_salary(worker_rec.Worker_ID, v_salary_increase);
    END LOOP;

    -- Get kosher catering revenue
    v_start_date := TO_DATE('2022-01-01', 'YYYY-MM-DD');
    v_end_date := TO_DATE('2023-03-31', 'YYYY-MM-DD');
    
    -- Cursor for kosher caterings
    FOR catering_rec IN (SELECT Catering_ID FROM Catering WHERE Cosher = 'Y') LOOP
        v_kosher_revenue := v_kosher_revenue + get_catering_revenue(catering_rec.Catering_ID, v_start_date, v_end_date);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total Kosher Catering revenue: $' || v_kosher_revenue);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
0
0
