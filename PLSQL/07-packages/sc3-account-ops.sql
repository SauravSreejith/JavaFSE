SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE AccountOperations AS
    PROCEDURE OpenNewAccount(
        p_account_id  IN NUMBER,
        p_customer_id IN NUMBER,
        p_account_type IN VARCHAR2,
        p_initial_balance IN NUMBER DEFAULT 0
    );

    PROCEDURE CloseAccount(p_account_id IN NUMBER);

    FUNCTION GetCustomerTotalBalance(p_customer_id IN NUMBER) RETURN NUMBER;
END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations AS

    PROCEDURE OpenNewAccount(
        p_account_id   IN NUMBER,
        p_customer_id  IN NUMBER,
        p_account_type IN VARCHAR2,
        p_initial_balance IN NUMBER DEFAULT 0
    ) IS
        v_cust_count NUMBER;
        v_acct_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_cust_count FROM Customers WHERE CustomerID = p_customer_id;
        IF v_cust_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Customer ' || p_customer_id || ' does not exist.');
            RETURN;
        END IF;

        SELECT COUNT(*) INTO v_acct_count FROM Accounts WHERE AccountID = p_account_id;
        IF v_acct_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Account ' || p_account_id || ' already exists.');
            RETURN;
        END IF;

        INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
        VALUES (p_account_id, p_customer_id, p_account_type, p_initial_balance, SYSDATE);

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Account ' || p_account_id || ' opened for Customer ' || p_customer_id ||
                             ' (' || p_account_type || ') with balance $' ||
                             TO_CHAR(p_initial_balance, 'FM999,999,990.00'));
    END OpenNewAccount;

    PROCEDURE CloseAccount(p_account_id IN NUMBER) IS
        v_balance NUMBER;
    BEGIN
        SELECT Balance INTO v_balance FROM Accounts WHERE AccountID = p_account_id;

        IF v_balance > 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Cannot close account ' || p_account_id ||
                                 '. Balance is $' || TO_CHAR(v_balance, 'FM999,999,990.00') ||
                                 '. Please transfer funds first.');
            RETURN;
        END IF;

        DELETE FROM Accounts WHERE AccountID = p_account_id;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Account ' || p_account_id || ' closed.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Account ' || p_account_id || ' not found.');
    END CloseAccount;

    FUNCTION GetCustomerTotalBalance(p_customer_id IN NUMBER) RETURN NUMBER IS
        v_total NUMBER := 0;
    BEGIN
        SELECT NVL(SUM(Balance), 0) INTO v_total
        FROM Accounts
        WHERE CustomerID = p_customer_id;

        RETURN v_total;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END GetCustomerTotalBalance;

END AccountOperations;
/

PROMPT === Testing AccountOperations Package ===

EXEC AccountOperations.OpenNewAccount(6, 2, 'Savings', 5000);

BEGIN
    DBMS_OUTPUT.PUT_LINE('Total balance for Customer 2: $' ||
        TO_CHAR(AccountOperations.GetCustomerTotalBalance(2), 'FM999,999,990.00'));
END;
/

EXEC AccountOperations.CloseAccount(6);

SELECT * FROM Accounts ORDER BY AccountID;
