SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_accounts IS
        SELECT AccountID, CustomerID, AccountType, Balance
        FROM Accounts
        FOR UPDATE;
    v_annual_fee CONSTANT NUMBER := 25.00;
    v_fee_applied  NUMBER := 0;
    v_new_balance  NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Applying Annual Maintenance Fee ===');
    DBMS_OUTPUT.PUT_LINE('Fee per account: $' || TO_CHAR(v_annual_fee, 'FM999,999,990.00'));
    DBMS_OUTPUT.PUT_LINE('');

    FOR rec IN c_accounts LOOP
        v_new_balance := rec.Balance - v_annual_fee;

        IF v_new_balance < 0 THEN
            v_new_balance := 0;
        END IF;

        UPDATE Accounts
        SET Balance = v_new_balance,
            LastModified = SYSDATE
        WHERE CURRENT OF c_accounts;

        v_fee_applied := v_fee_applied + 1;

        DBMS_OUTPUT.PUT_LINE('Account ' || rec.AccountID ||
                             ' (' || rec.AccountType || ') - Fee applied. ' ||
                             'Old: $' || TO_CHAR(rec.Balance, 'FM999,999,990.00') ||
                             ' -> New: $' || TO_CHAR(v_new_balance, 'FM999,999,990.00'));
    END LOOP;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Annual fee applied to ' || v_fee_applied || ' accounts.');
    DBMS_OUTPUT.PUT_LINE('=== Annual Fee Processing Complete ===');
END;
/

SELECT AccountID, AccountType, Balance FROM Accounts ORDER BY AccountID;
