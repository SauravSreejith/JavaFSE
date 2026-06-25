SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION CalculateAge(p_dob IN DATE)
RETURN NUMBER IS
    v_age NUMBER;
BEGIN
    IF p_dob IS NULL THEN
        RETURN NULL;
    END IF;

    v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
    RETURN v_age;
END CalculateAge;
/

PROMPT === Testing CalculateAge Function ===

SELECT
    CustomerID,
    Name,
    DOB,
    CalculateAge(DOB) AS Age
FROM Customers
ORDER BY CustomerID;

PROMPT
BEGIN
    DBMS_OUTPUT.PUT_LINE('Age of John Doe (ID=1): ' || CalculateAge(TO_DATE('1985-05-15','YYYY-MM-DD')));
    DBMS_OUTPUT.PUT_LINE('Age of Robert Brown (ID=3): ' || CalculateAge(TO_DATE('1960-03-10','YYYY-MM-DD')));
END;
/
