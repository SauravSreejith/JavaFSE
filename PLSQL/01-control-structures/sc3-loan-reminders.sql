SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_loans_due IS
        SELECT
            l.LoanID,
            l.LoanAmount,
            l.EndDate,
            c.CustomerID,
            c.Name
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
        ORDER BY l.EndDate;

    v_days_remaining NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Loan Payment Reminders (Due in Next 30 Days) ===');
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 70, '-'));

    FOR rec IN c_loans_due LOOP
        v_days_remaining := TRUNC(rec.EndDate - SYSDATE);

        DBMS_OUTPUT.PUT_LINE('Reminder: Customer ' || rec.Name ||
                             ' (CustomerID: ' || rec.CustomerID || ')');
        DBMS_OUTPUT.PUT_LINE('   LoanID: ' || rec.LoanID ||
                             ' | Amount: $' || TO_CHAR(rec.LoanAmount, 'FM999,999,990.00') ||
                             ' | Due Date: ' || TO_CHAR(rec.EndDate, 'YYYY-MM-DD') ||
                             ' (' || v_days_remaining || ' days remaining)');
        DBMS_OUTPUT.PUT_LINE('   Please ensure timely repayment to avoid penalties.');
        DBMS_OUTPUT.PUT_LINE(RPAD('-', 70, '-'));
    END LOOP;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No loans are due within the next 30 days.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('=== End of Loan Reminders ===');
END;
/
