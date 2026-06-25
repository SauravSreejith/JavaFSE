SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION HasSufficientBalance(
    p_account_id IN NUMBER,
    p_amount     IN NUMBER
) RETURN BOOLEAN IS
    v_balance NUMBER;
BEGIN
    IF p_amount IS NULL OR p_amount <= 0 THEN
        RETURN FALSE;
    END IF;

    BEGIN
        SELECT Balance INTO v_balance
        FROM Accounts
        WHERE AccountID = p_account_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
    END;

    RETURN (v_balance >= p_amount);
END HasSufficientBalance;
/

PROMPT === Testing HasSufficientBalance ===

DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := HasSufficientBalance(1, 500);
    DBMS_OUTPUT.PUT_LINE('Account 1 has $500? ' || CASE WHEN v_result THEN 'YES' ELSE 'NO' END);

    v_result := HasSufficientBalance(2, 20000);
    DBMS_OUTPUT.PUT_LINE('Account 2 has $20,000? ' || CASE WHEN v_result THEN 'YES' ELSE 'NO' END);

    v_result := HasSufficientBalance(999, 100);
    DBMS_OUTPUT.PUT_LINE('Account 999 has $100? ' || CASE WHEN v_result THEN 'YES' ELSE 'NO' END);

    IF HasSufficientBalance(3, 1000) THEN
        DBMS_OUTPUT.PUT_LINE('Account 3 can afford $1000 withdrawal.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account 3 does NOT have enough for $1000.');
    END IF;
END;
/

SELECT AccountID, Balance FROM Accounts ORDER BY AccountID;
