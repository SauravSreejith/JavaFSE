SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_loans IS
        SELECT LoanID, CustomerID, LoanAmount, InterestRate
        FROM Loans
        FOR UPDATE;

    v_new_rate NUMBER;
    v_count    NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Updating Loan Interest Rates (New Policy) ===');
    DBMS_OUTPUT.PUT_LINE('Policy: Reduce rate by 0.5% if Loan > $10,000, otherwise by 0.25%');
    DBMS_OUTPUT.PUT_LINE('');

    FOR rec IN c_loans LOOP
        IF rec.LoanAmount > 10000 THEN
            v_new_rate := rec.InterestRate - 0.5;
        ELSE
            v_new_rate := rec.InterestRate - 0.25;
        END IF;

        IF v_new_rate < 0 THEN
            v_new_rate := 0;
        END IF;

        UPDATE Loans
        SET InterestRate = v_new_rate
        WHERE CURRENT OF c_loans;

        v_count := v_count + 1;

        DBMS_OUTPUT.PUT_LINE('Loan ' || rec.LoanID ||
                             ' | Amount: $' || TO_CHAR(rec.LoanAmount, 'FM999,999,990.00') ||
                             ' | Old Rate: ' || rec.InterestRate || '%' ||
                             ' | New Rate: ' || v_new_rate || '%');
    END LOOP;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Interest rates updated for ' || v_count || ' loan(s).');
    DBMS_OUTPUT.PUT_LINE('=== Loan Interest Update Complete ===');
END;
/

SELECT LoanID, LoanAmount, InterestRate FROM Loans ORDER BY LoanID;
