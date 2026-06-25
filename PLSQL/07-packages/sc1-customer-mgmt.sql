SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE CustomerManagement AS
    PROCEDURE AddNewCustomer(
        p_customer_id IN NUMBER,
        p_name        IN VARCHAR2,
        p_dob         IN DATE,
        p_balance     IN NUMBER
    );

    PROCEDURE UpdateCustomerDetails(
        p_customer_id IN NUMBER,
        p_name        IN VARCHAR2 DEFAULT NULL,
        p_dob         IN DATE DEFAULT NULL
    );

    FUNCTION GetCustomerBalance(p_customer_id IN NUMBER) RETURN NUMBER;
END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement AS

    PROCEDURE AddNewCustomer(
        p_customer_id IN NUMBER,
        p_name        IN VARCHAR2,
        p_dob         IN DATE,
        p_balance     IN NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Customers WHERE CustomerID = p_customer_id;

        IF v_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Customer ID ' || p_customer_id || ' already exists.');
            RETURN;
        END IF;

        INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
        VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE, 'N');

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Customer ' || p_name || ' (ID: ' || p_customer_id || ') added.');
    END AddNewCustomer;

    PROCEDURE UpdateCustomerDetails(
        p_customer_id IN NUMBER,
        p_name        IN VARCHAR2 DEFAULT NULL,
        p_dob         IN DATE DEFAULT NULL
    ) IS
    BEGIN
        UPDATE Customers
        SET Name = NVL(p_name, Name),
            DOB  = NVL(p_dob, DOB),
            LastModified = SYSDATE
        WHERE CustomerID = p_customer_id;

        IF SQL%ROWCOUNT > 0 THEN
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('SUCCESS: Customer ' || p_customer_id || ' details updated.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('ERROR: Customer ' || p_customer_id || ' not found.');
        END IF;
    END UpdateCustomerDetails;

    FUNCTION GetCustomerBalance(p_customer_id IN NUMBER) RETURN NUMBER IS
        v_balance NUMBER;
    BEGIN
        SELECT Balance INTO v_balance
        FROM Customers
        WHERE CustomerID = p_customer_id;

        RETURN v_balance;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END GetCustomerBalance;

END CustomerManagement;
/

PROMPT === Testing CustomerManagement Package ===

EXEC CustomerManagement.AddNewCustomer(6, 'David Wilson', TO_DATE('1988-09-12','YYYY-MM-DD'), 8750);

BEGIN
    DBMS_OUTPUT.PUT_LINE('Balance for Customer 6: $' ||
        TO_CHAR(CustomerManagement.GetCustomerBalance(6), 'FM999,999,990.00'));
END;
/

EXEC CustomerManagement.UpdateCustomerDetails(6, p_name => 'David K. Wilson');

SELECT CustomerID, Name, Balance, IsVIP FROM Customers WHERE CustomerID = 6;
