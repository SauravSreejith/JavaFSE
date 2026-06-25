SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE UpdateSalary(
    p_employee_id IN NUMBER,
    p_percentage  IN NUMBER
) AS
    v_old_salary NUMBER;
    v_new_salary NUMBER;
    employee_not_found EXCEPTION;
BEGIN
    IF p_percentage <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Percentage increase must be positive.');
    END IF;

    BEGIN
        SELECT Salary INTO v_old_salary
        FROM Employees
        WHERE EmployeeID = p_employee_id
        FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE employee_not_found;
    END;

    v_new_salary := v_old_salary * (1 + p_percentage / 100);

    UPDATE Employees
    SET Salary = v_new_salary
    WHERE EmployeeID = p_employee_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Salary update successful for EmployeeID: ' || p_employee_id);
    DBMS_OUTPUT.PUT_LINE('Old Salary: $' || TO_CHAR(v_old_salary, 'FM999,999,990.00'));
    DBMS_OUTPUT.PUT_LINE('New Salary: $' || TO_CHAR(v_new_salary, 'FM999,999,990.00') ||
                         ' (Increase: ' || p_percentage || '%)');

EXCEPTION
    WHEN employee_not_found THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Employee with ID ' || p_employee_id || ' does not exist.');
        DBMS_OUTPUT.PUT_LINE('Salary update failed.');

    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Unexpected error while updating salary - ' || SQLERRM);
END UpdateSalary;
/

PROMPT
EXEC UpdateSalary(2, 10);

PROMPT
EXEC UpdateSalary(999, 5);

PROMPT
SELECT EmployeeID, Name, Salary FROM Employees ORDER BY EmployeeID;
