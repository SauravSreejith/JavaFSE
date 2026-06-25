SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_monthly_txns IS
        SELECT
            c.CustomerID,
            c.Name AS CustomerName,
            a.AccountID,
            t.TransactionID,
            t.TransactionDate,
            t.Amount,
            t.TransactionType
        FROM Transactions t
        JOIN Accounts a ON t.AccountID = a.AccountID
        JOIN Customers c ON a.CustomerID = c.CustomerID
        WHERE EXTRACT(MONTH FROM t.TransactionDate) = EXTRACT(MONTH FROM SYSDATE)
          AND EXTRACT(YEAR FROM t.TransactionDate) = EXTRACT(YEAR FROM SYSDATE)
        ORDER BY c.CustomerID, t.TransactionDate;

    v_current_customer NUMBER := -1;
    v_has_txns BOOLEAN := FALSE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('==================================================');
    DBMS_OUTPUT.PUT_LINE('   MONTHLY STATEMENT - ' || TO_CHAR(SYSDATE, 'MONTH YYYY'));
    DBMS_OUTPUT.PUT_LINE('==================================================');

    FOR rec IN c_monthly_txns LOOP
        v_has_txns := TRUE;

        IF rec.CustomerID != v_current_customer THEN
            IF v_current_customer != -1 THEN
                DBMS_OUTPUT.PUT_LINE('');
            END IF;

            v_current_customer := rec.CustomerID;
            DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.CustomerName || ' (ID: ' || rec.CustomerID || ')');
            DBMS_OUTPUT.PUT_LINE(RPAD('-', 50, '-'));
        END IF;

        DBMS_OUTPUT.PUT_LINE(
            '  ' || TO_CHAR(rec.TransactionDate, 'YYYY-MM-DD') ||
            ' | Acct: ' || rec.AccountID ||
            ' | ' || RPAD(rec.TransactionType, 10) ||
            ' | $' || TO_CHAR(rec.Amount, 'FM999,999,990.00')
        );
    END LOOP;

    IF NOT v_has_txns THEN
        DBMS_OUTPUT.PUT_LINE('No transactions found for the current month.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('==================================================');
    DBMS_OUTPUT.PUT_LINE('             End of Monthly Statements');
    DBMS_OUTPUT.PUT_LINE('==================================================');
END;
/
