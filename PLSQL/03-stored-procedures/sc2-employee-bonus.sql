SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_department   IN VARCHAR2,
    p_bonus_percent IN NUMBER
) AS
    v_updated_count NUMBER := 0;
    v_dept_upper    VARCHAR2(50);
BEGIN
    v_dept_upper := UPPER(p_department);

    IF p_bonus_percent <= 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Bonus percentage must be greater than zero.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('=== Updating Employee Salaries with Bonus ===');
    DBMS_OUTPUT.PUT_LINE('Department: ' || v_dept_upper);
    DBMS_OUTPUT.PUT_LINE('Bonus Percentage: ' || p_bonus_percent || '%');

    UPDATE Employees
    SET Salary = Salary * (1 + p_bonus_percent / 100)
    WHERE UPPER(Department) = v_dept_upper;

    v_updated_count := SQL%ROWCOUNT;

    COMMIT;

    IF v_updated_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Bonus applied to ' || v_updated_count || ' employee(s).');

        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('Updated employees in ' || v_dept_upper || ':');
        FOR rec IN (
            SELECT EmployeeID, Name, Salary
            FROM Employees
            WHERE UPPER(Department) = v_dept_upper
            ORDER BY EmployeeID
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('  ' || rec.EmployeeID || ' - ' || rec.Name ||
                                 ': $' || TO_CHAR(rec.Salary, 'FM999,999,990.00'));
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('No employees found in department: ' || v_dept_upper);
    END IF;

    DBMS_OUTPUT.PUT_LINE('=== Employee Bonus Update Complete ===');
END UpdateEmployeeBonus;
/

PROMPT
EXEC UpdateEmployeeBonus('IT', 5);

PROMPT
EXEC UpdateEmployeeBonus('Marketing', 10);
