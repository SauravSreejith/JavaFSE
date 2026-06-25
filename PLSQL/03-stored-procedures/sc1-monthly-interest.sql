SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
    v_updated_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Processing Monthly Interest (1%) for Savings Accounts ===');

    UPDATE Accounts
    SET Balance = Balance * 1.01,
        LastModified = SYSDATE
    WHERE AccountType = 'Savings';

    v_updated_count := SQL%ROWCOUNT;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Interest applied successfully.');
    DBMS_OUTPUT.PUT_LINE('Number of Savings accounts updated: ' || v_updated_count);

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Updated Savings Account Balances:');
    FOR rec IN (SELECT AccountID, AccountType, Balance
                FROM Accounts
                WHERE AccountType = 'Savings'
                ORDER BY AccountID) LOOP
        DBMS_OUTPUT.PUT_LINE('  Account ' || rec.AccountID || ': $' ||
                             TO_CHAR(rec.Balance, 'FM999,999,990.00'));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('=== Monthly Interest Processing Complete ===');
END ProcessMonthlyInterest;
/

EXEC ProcessMonthlyInterest;
