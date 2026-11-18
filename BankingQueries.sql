SHOW databases;

create database banking_db;
use banking_db;

create table customers (
customerID INT,
firstname varchar(50),
lastname varchar(50),
email varchar(100),
phone varchar(10)
);

desc accountbranches;

ALTER TABLE customers
ADD CONSTRAINT pk_customer_id PRIMARY KEY (customerID); 

select * from customers;

ALTER table customers
ADD AccountCreationDate Date;


CREATE TABLE Transactions (
    TransactionID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20)
);

CREATE TABLE Branches (
    BranchID  INT,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(200),
    BranchPhone VARCHAR(15)
);



ALTER TABLE branches
ADD CONSTRAINT pk_branch_id PRIMARY KEY (branchID); 



CREATE TABLE AccountBranches ( 
		AssignmentDate DATE
);
desc accountbranches;

CREATE TABLE Accounts (
    AccountID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2)
);

desc accounts;

CREATE TABLE Loans (
    LoanID INT,
    LoanAmount DECIMAL(10,2),
    InterestRate DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE
);

desc loans;

ALTER TABLE Customers
ADD DateOfBirth DATE;

desc customers;

ALTER TABLE Customers
MODIFY Phone VARCHAR(20);

desc accounts;

ALTER TABLE Accounts
ADD CONSTRAINT chk_MinBalance
CHECK (Balance >= 1000);

DROP TABLE AccountBranches;


ALTER TABLE accounts
ADD CONSTRAINT pk_account_id PRIMARY KEY (accountID); 

ALTER TABLE transactions
ADD CONSTRAINT pk_transaction_id PRIMARY KEY (transactionID); 

desc transactions;

ALTER TABLE loans
ADD CONSTRAINT pk_loan_id PRIMARY KEY (loanID); 

desc loans;


ALTER TABLE Accounts
ADD CustomerID INT;

ALTER TABLE Accounts
ADD CONSTRAINT FK_Accounts_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE Customers
MODIFY FirstName VARCHAR(50) NOT NULL;

desc customers;

ALTER TABLE Customers
ADD CONSTRAINT uq_Email UNIQUE (Email);

ALTER TABLE customers 
ALTER COLUMN lastname set default "NA";



ALTER TABLE Accounts
ADD BranchID INT;

ALTER TABLE Accounts
ADD CONSTRAINT FK_Accounts_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);


desc accounts;

ALTER TABLE Transactions
ADD AccountID INT;

ALTER TABLE Transactions
ADD CONSTRAINT FK_Accounts_Transactions
FOREIGN KEY (AccountID)
REFERENCES Accounts(AccountID);

desc loans;

ALTER TABLE Loans
ADD CustomerID INT;


ALTER TABLE Loans
ADD CONSTRAINT FK_Customers_Loans
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);


create table kyc(
kycid int primary key,
aadhaarNo varchar(12) not null,
panNo varchar(10) not null,
customerid INT not null,
constraint fk_customer
foreign key (customerid) references customers(customerid)
);

SHOW CREATE TABLE accounts; -- you can change table name as per your requirement 

-- You can get information about constraints applied on a specific table
-- by the query written below 
SELECT
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'banking_db'
  AND TABLE_NAME = 'kyc';
  
select * from customers;
  
INSERT INTO Customers
VALUES
(101,'Amit','Sharma','amit@gmail.com','9876543210','2024-01-15','1998-05-10');

INSERT INTO Customers 
(customerid,firstname,lastname,email,phone,accountcreationdate,dateofbirth)
VALUES (102,'Priya','Patil','priya@gmail.com','9876543211','2024-02-10','1999-08-22');

INSERT INTO Customers 
(phone,email,lastname,firstname,accountcreationdate,dateofbirth,customerid)
values ('9876543212','rahul@gmail.com','Verma','Rahul','2024-03-12','1997-11-14',103);

INSERT INTO Customers
VALUES
(104,'Sneha','Joshi','sneha@gmail.com','9876543213','2024-04-18','2000-01-05'),
(105,'Karan','Mehta','karan@gmail.com','9876543214','2024-05-25','1996-12-30');

INSERT INTO Branches
VALUES
(1,'Nagpur Branch','Sitabuldi, Nagpur','0712-123456'),
(2,'Pune Branch','Shivaji Nagar, Pune','020-223344'),
(3,'Mumbai Branch','Andheri, Mumbai','022-334455');

 select * from branches; 
  
INSERT INTO Accounts
VALUES
(1001,'Savings',25000,101,1),
(1002,'Current',45000,102,2),
(1003,'Savings',18000,103,1),
(1004,'Current',72000,104,3),
(1005,'Savings',15000,105,2);

select * from accounts;

INSERT INTO Transactions
VALUES
(1,'2025-01-10',5000,'Deposit',1001),
(2,'2025-01-12',2000,'Withdrawal',1001),
(3,'2025-01-13',7000,'Deposit',1002),
(4,'2025-01-15',3000,'Withdrawal',1003),
(5,'2025-01-16',10000,'Deposit',1004);

select * from transactions;

INSERT INTO Loans
VALUES
(501,500000,8.5,'2024-01-01','2029-01-01',101),
(502,250000,9.0,'2024-03-15','2028-03-15',103),
(503,700000,7.8,'2024-06-20','2031-06-20',104);

select * from loans;

UPDATE customers
set email = 'amit2026@yahoo.com'
where customerid = 101;

UPDATE customers
set lastname = 'Joshi'
where customerid = 102;
  
select * from customers;
select * from branches;

update branches
set branchaddress = 'Civil Lines,Nagpur',
branchphone = '0712-562692'
where branchid = 1;

select * from kyc;

Insert into kyc
values (701,'654694838492','HGKUY8585U',101),
(702,'986939664829','RHJDJ3958H',103),
(703,'875852868775','YTGYT5876W',105);

DELETE from kyc where kycid = 702;

select * from kyc;

DELETE from kyc;
-- Get all data for all customers
select * from customers;
-- Get data for selected fields or attributes of the customers
select firstname,email,phone from customers;

select * from accounts;
-- Find all customers having balance greater than 40000
select * from accounts
where balance > 40000;

select balance,customerid from accounts
where balance > 40000;

-- Find all customers having account type as Savings
select accountid,accounttype,balance from accounts
where accounttype = 'Savings';

-- Find details of customer id 104 
select * from customers
where customerid = 104;

-- Find all customers whose accounttype is Savings and balance greater than
-- 20000
SELECT 
    *
FROM
    accounts
WHERE
    accounttype = 'Savings'
        AND balance > 20000;
        
SELECT 
    *
FROM
    accounts
WHERE
    accounttype = 'Current'
        OR balance > 20000;
-- Find all accounts where account type is not savings
select * from accounts
where NOT accounttype = 'Savings' ; 

select * from accounts
where accounttype != 'Savings' ; 

select * from accounts
where accounttype <> 'Savings' ; 

select * from loans;

select * from loans
where interestrate = 8.5 or interestrate = 9.0;

select * from loans
where interestrate in (8.5,9.0);

select * from transactions
where TransactionType not in ("deposit","withdrawal");

select * from loans
where interestrate between 7.5 and 8.5;

-- find all customers having balance between 20k to 60k
select * from accounts
where balance between 20000 and 60000; 

-- find all customers having balance between 20k to 60k
-- and account type should be current
select * from accounts
where balance between 20000 and 60000 AND AccountType ='Current'; 

select * from customers;

-- LIKE operator

select * from customers
where lastname LIKE 'J%';

select * from customers
where firstname LIKE '%ya';

select * from customers
where firstname LIKE 'A___';


select * from accounts;

-- Sort accounts table as per balance in descending order
select * from accounts
order by balance;

select * from accounts
order by balance desc;

select * from accounts
order by accounttype, balance desc;


s


INSERT INTO branches (BranchID, BranchName, BranchAddress, BranchPhone) VALUES
(4, 'Nashik Branch',      'College Road, Nashik',      NULL),
(5, 'Chandrapur Branch',  NULL,'07172-250100'),
(6, 'Aurangabad Branch',  'Station Road, Aurangabad',  '0240-334455');


INSERT INTO customers (customerID, FirstName, lastname, email, Phone, AccountCreationDate, DateOfBirth) VALUES
(106, 'Neha',   'Kulkarni', 'neha.k@gmail.com',       '9876543215', '2024-06-10', '1995-03-18'),
(107, 'Vikram', 'Singh',    NULL,                     '9876543216', '2024-07-01', '1994-07-07'),
(108, 'Anjali', NULL,       'anjali@outlook.com',     NULL,         '2024-08-14', '2001-09-12'),
(109, 'Rohan',  'Deshmukh', 'rohan.d@yahoo.com',      '9876543218', NULL,         '1993-02-25'),
(110, 'Pooja',  'Joshi',    'pooja@gmail.com',        '9876543219', '2024-09-30', NULL),
(111, 'Suresh', 'Patil',    NULL,                     NULL,         '2024-10-05', '1990-06-15'),
(112, 'Meera',  'Nair',     'meera.nair@gmail.com',   '9876543221', '2025-01-20', '1999-12-01'),
(113, 'Amit',   'Verma',    'amitv@rediffmail.com',   '9876543222', '2025-02-11', '1998-05-10'),
(115, 'Sanjay', 'Mehta',    'sanjay.m@gmail.com',     NULL,         '2025-04-09', '1988-10-28');

INSERT INTO customers (customerID, FirstName, email, Phone, AccountCreationDate, DateOfBirth) VALUES
(114, 'Kavita', 'kavita@gmail.com', '9876543223', '2025-03-03', '2002-04-17');


INSERT INTO accounts (AccountID, AccountType, Balance, CustomerID, BranchID) VALUES
(1006, 'Savings', 32000.00,  106,  1),
(1007, 'Current', 150000.00, 107,  3),
(1008, 'Savings', NULL,      108,  2),
(1009, NULL,      5000.00,   109,  4),
(1010, 'Savings', 1000.00,   110,  4),
(1011, 'Current', 98000.00,  111,  5),
(1012, 'Savings', 12000.00,  112,  NULL),
(1013, 'Current', 27500.50,  101,  3),
(1014, 'Savings', 60000.00,  NULL, 1),
(1015, 'Savings', 8500.00,   113,  2);


INSERT INTO kyc (kycid, aadhaarNo, panNo, customerid) VALUES
(1, '234567890123', 'ABCPS1234A', 101),
(2, '345678901234', 'BCDPJ2345B', 102),
(3, '456789012345', 'CDEPV3456C', 103),
(4, '567890123456', 'DEFPJ4567D', 104),
(5, '678901234567', 'EFGPM5678E', 105),
(6, '789012345678', 'FGHPK6789F', 106),
(7, '890123456789', 'GHIPS7890G', 107),
(8, '901234567890', 'HIJPD8901H', 109),
(9, '112233445566', 'IJKPN9012I', 112);



INSERT INTO loans (LoanID, LoanAmount, InterestRate, StartDate, EndDate, CustomerID) VALUES
(504, 400000.00, 8.25, '2025-01-10', '2030-01-10', 105),
(505, 150000.00, NULL, '2025-02-01', '2027-02-01', 106),
(506, 900000.00, 7.50, '2025-03-05', NULL,         107),
(507, NULL,      9.50, '2025-04-01', '2029-04-01', 109),
(508, 300000.00, 8.50, '2025-05-15', '2030-05-15', 101),
(509, 120000.00, 10.00,'2025-06-01', '2026-06-01', NULL);


INSERT INTO transactions (TransactionID, TransactionDate, Amount, TransactionType, AccountID) VALUES
(6,  '2025-01-18', 1500.00,  'Deposit',    1005),
(7,  '2025-01-20', NULL,     'Deposit',    1006),
(8,  '2025-02-02', 4500.00,  'Withdrawal', 1006),
(9,  '2025-02-05', 20000.00, 'Deposit',    1007),
(10, '2025-02-10', 2500.00,  NULL,         1007),
(11, '2025-02-14', 800.00,   'Transfer',   1001),
(12, '2025-02-20', 12000.00, 'Transfer',   1004),
(13, '2025-03-01', 6000.00,  'Deposit',    NULL),
(14, '2025-03-05', 3500.00,  'Withdrawal', 1010),
(15, NULL,         9000.00,  'Deposit',    1011),
(16, '2025-03-15', 500.00,   'Withdrawal', 1002),
(17, '2025-03-18', 15000.00, 'Deposit',    1013),
(18, '2025-04-01', 2200.00,  'Withdrawal', 1013),
(19, '2025-04-10', 7500.00,  'Deposit',    1001),
(20, '2025-04-12', 1000.00,  'Transfer',   1015);


select * from branches;
select * from customers;
select * from accounts;
select * from transactions;
select * from loans;
select * from kyc;

-- DISTINCT clause
select DISTINCT accounttype from accounts;
select DISTINCT transactiontype from transactions;
select DISTINCT customerid,loanid  from loans;

-- LIMIT clause
select * from transactions
LIMIT 2;

select * from transactions
order by amount desc
limit 3;

-- Find top 2 transactions having highest withhdrawal amount
select * from transactions
where TransactionType = "Withdrawal"
order by Amount desc
limit 2;

-- OFFSET clause
select * from customers;
select * from customers
LIMIT 2 OFFSET 5;
-- Find the customer having 3rd highest loan amount.
select * from loans
order by loanamount desc
limit 1 offset 2;

-- NULL
select customerID,firstname,lastname,email from customers
where email IS NULL; 

select customerID,firstname,lastname from customers
where lastname IS NULL; 

select customerID,firstname,lastname,email,phone from customers
where email IS NULL AND phone IS NULL; 

-- CASE statements
select * from loans;

select loanid,loanamount,customerid,
case
when loanamount >= 500000 THEN "High value loan"
when loanamount >=200000 THEN "Medium value loan"
ELSE "Low value loan"
END AS LoanCategory
from loans;

-- Categorize the deposits in the transactions table as per conditions given
-- if above 10000(included) High amount
-- if 5000(included) to 10000 Medium amount
-- if upto 5000 Low Amount
-- For Transaction type Withdrawal "Not Applicable"

select Transactionid,amount,transactiontype,
case
when transactiontype = "deposit" and amount >= 10000 THEN "High amount"
when transactiontype = "deposit" and amount >= 5000 THEN "Medium amount"
when transactiontype = "deposit" and amount >= 0 THEN "Low amount"
ELSE "Not Applicable" END AS "DepositCategory"
from transactions;

-- String Functions
-- upper() function
select upper("hello");

select upper(firstname) AS FirstName , phone, email from customers;

-- lower() function 
select * from customers;
select lower(firstname) AS FirsName, lower(lastname) LastName from customers;

-- length() function
select length("NAGPUR") AS "NoOfCharacters"; -- gives o/p in number of bytes
select length("नागपूर");-- gives o/p in number of bytes
select char_length("NAGPUR");-- gives o/p in number of characters
select char_length("नागपूर");-- gives o/p in number of characters

-- concat() functions

select concat("Hello"," ","World") as ConcatenatedString;
select concat(firstname," ",lastname) as fullname, phone,email from customers;

-- substring() or substr() function
select substr("Hello World India",7,5) as extractedstring; 

select customerid, concat(substr(firstname,1,1),".",lastname) as fullname, 
phone,email from customers;

-- trim() function

select  length("  Hello World  ");
select  length(trim("  Hello World  "));
select length(trim(substring("Hello World",6)));

-- replace() function

select replace("Mat mat Mat","M","C");

-- Mathematical functions

-- round() function
select * from accounts;

select avg(Balance) from accounts
where accounttype = "Savings";

select round(avg(Balance),2) as AvgBalance from accounts
where accounttype = "Savings";

select round(3.6);
select round(3.3);
select round(3.5);

-- Ceil() or Ceiling() function
select ceiling(avg(Balance)) from accounts
where accounttype = "Savings";

-- floor() function
select floor(avg(Balance)) from accounts
where accounttype = "Savings";


-- Absolute() function......It removes the sign
select abs(-3656);
select abs(-1.34);
select abs(6.464);

-- mod() function
select  (7/3);
select mod(7,3);

-- Power()
select power(2,3);
select power(1.5,3);

-- SQRT()
select sqrt(123);
select sqrt(144);


-- Date functions
select * from customers;

select now();
select current_date();
select curdate();
select current_time();
select curtime();

select customerid,FirstName,dateofbirth,
year(dateofbirth),month(dateofbirth),day(dateofbirth) 
from customers where customerid = 104;

select customerid,FirstName,dateofbirth,
year(curdate()) - year(dateofbirth) as age
from customers;

select firstname, dateofbirth, 
round(datediff(curdate(),dateofbirth) / 365,1) as age
from customers;

select firstname, dateofbirth, 
concat(firstname," age is ",round(datediff(curdate(),dateofbirth) / 365,1)) as age
from customers;

 select concat(firstname," ",lastname) as fullname,
 accountcreationdate,
 date_add(accountcreationdate, interval 5 year) as KYCRenewal
 from customers;
 
 
 SELECT DATE_SUB(CURDATE(), INTERVAL 7 DAY);
 
-- Aggregate functions

-- Calculate the total balance maintained across all customer accounts
select * from accounts;
select sum(balance) totalBalance from accounts;

-- Calculate the average balance maintained across all customer accounts

select avg(balance) averageBalance from accounts;

-- Identify the highest balance maintained in any customer account
SELECT MAX(Balance) AS highest_balance
FROM Accounts;

-- Identify the lowest balance maintained in any customer account
SELECT MIN(Balance) AS highest_balance
FROM Accounts;

-- Determine the total number of customer accounts 
-- available in the system.
Select count(*) as NoOfAccounts from accounts;

-- Group By
select accounttype, count(*) as NoOfAccounts
from accounts
group by accounttype;

select accounttype, sum(balance) as NoOfAccounts
from accounts
group by accounttype;

-- Find total amount by transaction type
select * from transactions;

select transactiontype, sum(amount) AS TotalAmount
from transactions
group by TransactionType;

-- Find total accounts for branch and accounttype;
select * from accounts;

select branchid, accounttype, count(*) as noOfAccounts
from accounts
group by branchid,accounttype
order by noOfAccounts desc;

-- HAVING clause
 -- Find transaction type where total amount for that transaction type 
 -- exceeds 20000. 
select transactiontype, sum(amount) AS TotalAmount
from transactions
group by TransactionType
having TotalAmount > 10000;

select transactiontype, sum(amount) AS TotalAmount
from transactions
group by TransactionType
having TotalAmount > 10000 and transactiontype = "deposit";

select transactiontype, amount from transactions
where amount > 10000;

-- Find number of customers joined according to year from customers table
select * from customers;

select year(accountcreationdate) as years, count(*) as totalCustomers
from customers
group by years
order  by totalcustomers desc;

-- Find total loan amount for all the customers.
Select * from loans;

select customerid, sum(loanamount) as totalLoanAmount
from loans
group by customerid
order by customerid;

-- Display distinct BranchIDs from Accounts 
-- where balance is greater than ₹30,000.
select * from accounts;
select branchid,balance from accounts
where balance > 30000;

-- Display all Savings accounts belonging to Branch 1 or Branch 3.
select * from accounts
where AccountType = "Savings" AND Branchid = 1 OR BranchID = 3 ;

-- Find the average balance of Current accounts for each branch.
-- Display only branches where the average balance exceeds ₹40,000.

select * from accounts;
select branchid,accounttype, avg(balance) as avgBalance from accounts
where accounttype = "Current"
group by branchid;

select * from customers;
select * from accounts;

-- JOINS
-- A JOIN combines related rows from different 
-- tables based on a common column 

-- 1. INNER JOIN
-- Matches rows that exist in both tables

-- Find all customers who have accounts and show their balance.

select c.CustomerID,c.firstname,c.lastname,a.accounttype,a.balance 
from customers
inner join accounts
on c.customerID = a.CustomerID;

select *
from customers c
inner join accounts a
on c.customerID = a.CustomerID;

-- Find all the customers who have loans. 
-- output should contain customerid,firstname,lastname,phone, loanamount
select * from loans;

select c.customerid,c.firstname,c.lastname,c.phone,l.loanamount
from customers c
join loans l  # by default mysql uses inner join if join type is not mentioned in query
on c.customerid = l.customerid;





























