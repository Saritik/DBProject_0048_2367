create or replace procedure update_worker_salary(p_worker_id IN Worker.Worker_ID%TYPE,
    p_salary_increase IN NUMBER) is 
    v_current_salary Worker.Salary%TYPE;
    v_new_salary Worker.Salary%TYPE;
    e_invalid_increase EXCEPTION;
begin
    SELECT Salary INTO v_current_salary
    FROM Worker
    WHERE Worker_ID = p_worker_id;

    IF p_salary_increase < 0 THEN
        RAISE e_invalid_increase;
    END IF;

    v_new_salary := v_current_salary + p_salary_increase;

    UPDATE Worker
    SET Salary = v_new_salary
    WHERE Worker_ID = p_worker_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Salary updated successfully. Old salary: ' || v_current_salary || ', New salary: ' || v_new_salary);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Worker not found.');
    WHEN e_invalid_increase THEN
        DBMS_OUTPUT.PUT_LINE('Invalid salary increase amount.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK;
end update_worker_salary;
/
