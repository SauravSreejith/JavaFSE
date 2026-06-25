SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_customers IS
        SELECT CustomerID, Name, DOB
        FROM Customers;

    v_age NUMBER;
    v_discount_applied BOOLEAN := FALSE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Applying 1% Loan Interest Discount for Customers Over 60 ===');

    FOR rec IN c_customers LOOP
        v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, rec.DOB) / 12);

        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate * 0.99
            WHERE CustomerID = rec.CustomerID;

            IF SQL%ROWCOUNT > 0 THEN
                DBMS_OUTPUT.PUT_LINE('Discount applied for Customer: ' || rec.Name ||
                                     ' (Age: ' || v_age || ') - ' || SQL%ROWCOUNT || ' loan(s) updated.');
                v_discount_applied := TRUE;
            END IF;
        END IF;
    END LOOP;

    COMMIT;

    IF NOT v_discount_applied THEN
        DBMS_OUTPUT.PUT_LINE('No customers over 60 years old with active loans found.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('=== Loan Discount Processing Complete ===');
END;
/
