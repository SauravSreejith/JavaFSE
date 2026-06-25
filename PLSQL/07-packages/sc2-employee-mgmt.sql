SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE EmployeeManagement AS
    PROCEDURE HireNewEmployee(
        p_employee_id IN NUMBER,
        p_name        IN VARCHAR2,
        p_position    IN VARCHAR2,
        p_salary      IN NUMBER,
        p_department  IN VARCHAR2,
        p_hire_date   IN DATE DEFAULT SYSDATE
    );

    PROCEDURE UpdateEmployeeDetails(
        p_employee_id IN NUMBER,
        p_name        IN VARCHAR2 DEFAULT NULL,
        p_position    IN VARCHAR2 DEFAULT NULL,
        p_salary      IN NUMBER DEFAULT NULL,
        p_department  IN VARCHAR2 DEFAULT NULL
    );

    FUNCTION CalculateAnnualSalary(p_employee_id IN NUMBER) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS

    PROCEDURE HireNewEmployee(
        p_employee_id IN NUMBER,
        p_name        IN VARCHAR2,
        p_position    IN VARCHAR2,
        p_salary      IN NUMBER,
        p_department  IN VARCHAR2,
        p_hire_date   IN DATE DEFAULT SYSDATE
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Employees WHERE EmployeeID = p_employee_id;

        IF v_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Employee ID ' || p_employee_id || ' already exists.');
            RETURN;
        END IF;

        INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
        VALUES (p_employee_id, p_name, p_position, p_salary, p_department, p_hire_date);

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Employee ' || p_name || ' hired (ID: ' || p_employee_id || ').');
    END HireNewEmployee;

    PROCEDURE UpdateEmployeeDetails(
        p_employee_id IN NUMBER,
        p_name        IN VARCHAR2 DEFAULT NULL,
        p_position    IN VARCHAR2 DEFAULT NULL,
        p_salary      IN NUMBER DEFAULT NULL,
        p_department  IN VARCHAR2 DEFAULT NULL
    ) IS
    BEGIN
        UPDATE Employees
        SET Name       = NVL(p_name, Name),
            Position   = NVL(p_position, Position),
            Salary     = NVL(p_salary, Salary),
            Department = NVL(p_department, Department)
        WHERE EmployeeID = p_employee_id;

        IF SQL%ROWCOUNT > 0 THEN
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('SUCCESS: Employee ' || p_employee_id || ' updated.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('ERROR: Employee ' || p_employee_id || ' not found.');
        END IF;
    END UpdateEmployeeDetails;

    FUNCTION CalculateAnnualSalary(p_employee_id IN NUMBER) RETURN NUMBER IS
        v_salary NUMBER;
    BEGIN
        SELECT Salary INTO v_salary FROM Employees WHERE EmployeeID = p_employee_id;
        RETURN v_salary * 12;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END CalculateAnnualSalary;

END EmployeeManagement;
/

PROMPT === Testing EmployeeManagement Package ===

EXEC EmployeeManagement.HireNewEmployee(4, 'Diana Prince', 'Analyst', 62000, 'Finance');

BEGIN
    DBMS_OUTPUT.PUT_LINE('Annual salary for Emp 2: $' ||
        TO_CHAR(EmployeeManagement.CalculateAnnualSalary(2), 'FM999,999,990.00'));
END;
/

EXEC EmployeeManagement.UpdateEmployeeDetails(4, p_salary => 65000);

SELECT * FROM Employees WHERE EmployeeID = 4;
