SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE AddNewCustomer(
    p_customer_id IN NUMBER,
    p_name        IN VARCHAR2,
    p_dob         IN DATE,
    p_balance     IN NUMBER
) AS
    customer_exists EXCEPTION;
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Customers
    WHERE CustomerID = p_customer_id;

    IF v_count > 0 THEN
        RAISE customer_exists;
    END IF;

    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
    VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE, 'N');

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('SUCCESS: Customer added successfully.');
    DBMS_OUTPUT.PUT_LINE('  CustomerID : ' || p_customer_id);
    DBMS_OUTPUT.PUT_LINE('  Name       : ' || p_name);
    DBMS_OUTPUT.PUT_LINE('  DOB        : ' || TO_CHAR(p_dob, 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('  Balance    : $' || TO_CHAR(p_balance, 'FM999,999,990.00'));

EXCEPTION
    WHEN customer_exists THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Customer with ID ' || p_customer_id ||
                             ' already exists. Insertion aborted.');

    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Failed to add customer - ' || SQLERRM);
END AddNewCustomer;
/

PROMPT
EXEC AddNewCustomer(5, 'Michael Scott', TO_DATE('1982-03-15','YYYY-MM-DD'), 3200.00);

PROMPT
EXEC AddNewCustomer(1, 'Duplicate John', TO_DATE('1995-01-01','YYYY-MM-DD'), 100.00);

PROMPT
SELECT CustomerID, Name, Balance, IsVIP FROM Customers ORDER BY CustomerID;
