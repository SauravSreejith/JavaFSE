BEGIN
    FOR rec IN (SELECT table_name FROM user_tables
                WHERE table_name IN ('AUDITLOG', 'TRANSACTIONS', 'LOANS', 'ACCOUNTS', 'EMPLOYEES', 'CUSTOMERS')) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER(15,2),
    LastModified DATE,
    IsVIP CHAR(1) DEFAULT 'N' CHECK (IsVIP IN ('Y', 'N'))
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER(15,2),
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER(15,2),
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER(15,2),
    InterestRate NUMBER(5,2),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER(15,2),
    Department VARCHAR2(50),
    HireDate DATE
);

CREATE TABLE AuditLog (
    LogID NUMBER PRIMARY KEY,
    TransactionID NUMBER,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER(15,2),
    TransactionType VARCHAR2(10),
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE AuditLog_Seq START WITH 1 INCREMENT BY 1;

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
VALUES (1, 'John Doe', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 1000.00, SYSDATE, 'N');

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 15000.00, SYSDATE, 'N');

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
VALUES (3, 'Robert Brown', TO_DATE('1960-03-10', 'YYYY-MM-DD'), 25000.50, SYSDATE, 'N');

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
VALUES (4, 'Emily Davis', TO_DATE('1975-11-25', 'YYYY-MM-DD'), 5500.75, SYSDATE, 'N');

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 1000.00, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 2, 'Checking', 15000.00, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (3, 3, 'Savings', 25000.50, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (4, 4, 'Savings', 5500.75, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (5, 1, 'Checking', 2500.00, SYSDATE);

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (1, 1, SYSDATE - 10, 200.00, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2, 2, SYSDATE - 5, 300.00, 'Withdrawal');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (3, 3, SYSDATE - 2, 5000.00, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (4, 1, SYSDATE - 1, 150.00, 'Withdrawal');

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 5000.00, 7.5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 3, 12000.00, 6.0, SYSDATE - 365, ADD_MONTHS(SYSDATE, 15));
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (3, 4, 8000.00, 8.0, SYSDATE, ADD_MONTHS(SYSDATE, 20));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000.00, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000.00, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (3, 'Carol White', 'Analyst', 55000.00, 'Finance', TO_DATE('2020-01-10', 'YYYY-MM-DD'));

COMMIT;

SELECT 'Customers' AS TableName, COUNT(*) AS RowCount FROM Customers
UNION ALL
SELECT 'Accounts', COUNT(*) FROM Accounts
UNION ALL
SELECT 'Transactions', COUNT(*) FROM Transactions
UNION ALL
SELECT 'Loans', COUNT(*) FROM Loans
UNION ALL
SELECT 'Employees', COUNT(*) FROM Employees;

PROMPT Schema and sample data created successfully.
