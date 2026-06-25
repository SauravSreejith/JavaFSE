SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE TransferFunds(
    p_from_account IN NUMBER,
    p_to_account   IN NUMBER,
    p_amount       IN NUMBER
) AS
    v_from_balance NUMBER;
BEGIN
    IF p_amount IS NULL OR p_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20020, 'Transfer amount must be greater than zero.');
    END IF;

    BEGIN
        SELECT Balance INTO v_from_balance
        FROM Accounts
        WHERE AccountID = p_from_account
        FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20021, 'Source account does not exist.');
    END;

    DECLARE
        v_dummy NUMBER;
    BEGIN
        SELECT 1 INTO v_dummy FROM Accounts WHERE AccountID = p_to_account;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20022, 'Destination account does not exist.');
    END;

    IF v_from_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20023, 'Insufficient balance in source account. Available: ' || v_from_balance);
    END IF;

    UPDATE Accounts
    SET Balance = Balance - p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_from_account;

    UPDATE Accounts
    SET Balance = Balance + p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_to_account;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('=== Transfer Completed Successfully ===');
    DBMS_OUTPUT.PUT_LINE('From Account: ' || p_from_account ||
                         '  |  To Account: ' || p_to_account);
    DBMS_OUTPUT.PUT_LINE('Amount: $' || TO_CHAR(p_amount, 'FM999,999,990.00'));

    FOR rec IN (
        SELECT AccountID, Balance
        FROM Accounts
        WHERE AccountID IN (p_from_account, p_to_account)
        ORDER BY AccountID
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Account ' || rec.AccountID || ' new balance: $' ||
                             TO_CHAR(rec.Balance, 'FM999,999,990.00'));
    END LOOP;

END TransferFunds;
/

PROMPT
EXEC TransferFunds(5, 1, 200);

PROMPT
SELECT AccountID, CustomerID, Balance FROM Accounts WHERE AccountID IN (1, 5);
