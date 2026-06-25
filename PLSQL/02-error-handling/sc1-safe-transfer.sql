SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    p_from_account IN NUMBER,
    p_to_account   IN NUMBER,
    p_amount       IN NUMBER
) AS
    v_from_balance NUMBER;
    v_to_balance   NUMBER;
    v_from_exists  NUMBER;
    v_to_exists    NUMBER;

    insufficient_funds EXCEPTION;
    invalid_account    EXCEPTION;
BEGIN
    IF p_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Transfer amount must be greater than zero.');
    END IF;

    SELECT COUNT(*) INTO v_from_exists FROM Accounts WHERE AccountID = p_from_account;
    SELECT COUNT(*) INTO v_to_exists FROM Accounts WHERE AccountID = p_to_account;

    IF v_from_exists = 0 OR v_to_exists = 0 THEN
        RAISE invalid_account;
    END IF;

    SELECT Balance INTO v_from_balance
    FROM Accounts
    WHERE AccountID = p_from_account
    FOR UPDATE;

    SELECT Balance INTO v_to_balance
    FROM Accounts
    WHERE AccountID = p_to_account
    FOR UPDATE;

    IF v_from_balance < p_amount THEN
        RAISE insufficient_funds;
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

    DBMS_OUTPUT.PUT_LINE('Transfer successful: $' || TO_CHAR(p_amount, 'FM999,999,990.00') ||
                         ' moved from Account ' || p_from_account ||
                         ' to Account ' || p_to_account || '.');

EXCEPTION
    WHEN insufficient_funds THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Insufficient funds in Account ' || p_from_account ||
                             '. Current balance: $' || TO_CHAR(v_from_balance, 'FM999,999,990.00') ||
                             '. Transfer of $' || TO_CHAR(p_amount, 'FM999,999,990.00') || ' failed.');
        DBMS_OUTPUT.PUT_LINE('Transaction rolled back.');

    WHEN invalid_account THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: One or both accounts do not exist. Transfer aborted.');

    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Unexpected error during transfer - ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Transaction rolled back.');
END SafeTransferFunds;
/

PROMPT
EXEC SafeTransferFunds(1, 5, 100);

PROMPT
EXEC SafeTransferFunds(1, 5, 999999);

PROMPT
EXEC SafeTransferFunds(999, 1, 50);

PROMPT
SELECT AccountID, Balance FROM Accounts WHERE AccountID IN (1, 5) ORDER BY AccountID;
