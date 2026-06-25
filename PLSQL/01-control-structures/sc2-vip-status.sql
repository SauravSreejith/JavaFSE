SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_customers IS
        SELECT CustomerID, Name, Balance, IsVIP
        FROM Customers;

    v_vip_updated BOOLEAN := FALSE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Promoting Customers to VIP Status (Balance > $10,000) ===');

    FOR rec IN c_customers LOOP
        IF rec.Balance > 10000 THEN
            IF rec.IsVIP != 'Y' THEN
                UPDATE Customers
                SET IsVIP = 'Y'
                WHERE CustomerID = rec.CustomerID;

                DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.Name ||
                                     ' (Balance: $' || TO_CHAR(rec.Balance, 'FM999,999,990.00') ||
                                     ') promoted to VIP.');
                v_vip_updated := TRUE;
            ELSE
                DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.Name || ' is already a VIP.');
            END IF;
        END IF;
    END LOOP;

    COMMIT;

    IF NOT v_vip_updated THEN
        DBMS_OUTPUT.PUT_LINE('No customers eligible for VIP promotion at this time.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('=== VIP Status Update Complete ===');
END;
/
