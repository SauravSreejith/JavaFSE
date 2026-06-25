SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (
        LogID,
        TransactionID,
        AccountID,
        TransactionDate,
        Amount,
        TransactionType
    ) VALUES (
        AuditLog_Seq.NEXTVAL,
        :NEW.TransactionID,
        :NEW.AccountID,
        :NEW.TransactionDate,
        :NEW.Amount,
        :NEW.TransactionType
    );
END;
/

PROMPT Trigger LogTransaction created successfully.

PROMPT
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (100, 1, SYSDATE, 75.50, 'Deposit');

COMMIT;

SELECT * FROM AuditLog ORDER BY LogTimestamp DESC FETCH FIRST 3 ROWS ONLY;

SELECT * FROM Transactions WHERE TransactionID = 100;
