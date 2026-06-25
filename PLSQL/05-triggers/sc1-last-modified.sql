SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    :NEW.LastModified := SYSDATE;
END;
/

PROMPT Trigger UpdateCustomerLastModified created successfully.

PROMPT
UPDATE Customers
SET Balance = Balance + 100
WHERE CustomerID = 1;

COMMIT;

SELECT CustomerID, Name, Balance, LastModified
FROM Customers
WHERE CustomerID = 1;
