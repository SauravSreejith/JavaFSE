SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
DECLARE
    v_current_balance NUMBER;
BEGIN
    BEGIN
        SELECT Balance INTO v_current_balance
        FROM Accounts
        WHERE AccountID = :NEW.AccountID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20040, 'Account ID ' || :NEW.AccountID || ' does not exist.');
    END;

    IF UPPER(:NEW.TransactionType) = 'DEPOSIT' THEN
        IF :NEW.Amount IS NULL OR :NEW.Amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20041, 'Deposit amount must be greater than zero.');
        END IF;

    ELSIF UPPER(:NEW.TransactionType) = 'WITHDRAWAL' THEN
        IF :NEW.Amount IS NULL OR :NEW.Amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20042, 'Withdrawal amount must be greater than zero.');
        END IF;

        IF :NEW.Amount > v_current_balance THEN
            RAISE_APPLICATION_ERROR(-20043,
                'Insufficient balance. Current balance: $' || v_current_balance ||
                '. Attempted withdrawal: $' || :NEW.Amount);
        END IF;
    ELSE
        RAISE_APPLICATION_ERROR(-20044, 'Invalid TransactionType. Must be DEPOSIT or WITHDRAWAL.');
    END IF;

    IF :NEW.TransactionDate IS NULL THEN
        :NEW.TransactionDate := SYSDATE;
    END IF;
END;
/

PROMPT Trigger CheckTransactionRules created successfully.

PROMPT === Testing Transaction Rules Trigger ===

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (101, 1, SYSDATE, 250, 'Deposit');

COMMIT;
DBMS_OUTPUT.PUT_LINE('Test 1 PASSED: Valid deposit inserted.');

BEGIN
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (102, 1, SYSDATE, -100, 'Deposit');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test 2 PASSED (Expected): ' || SQLERRM);
END;

BEGIN
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (103, 1, SYSDATE, 999999, 'Withdrawal');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test 3 PASSED (Expected): ' || SQLERRM);
END;

SELECT AccountID, Balance FROM Accounts WHERE AccountID = 1;
SELECT * FROM Transactions WHERE TransactionID IN (101) ORDER BY TransactionID;
