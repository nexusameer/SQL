CREATE DATABASE CUSTOMERSALESMAN;

USE CUSTOMERSALESMAN;

-- 1ST Question-- 

CREATE TABLE SALESMAN(
SALEMAN_ID INT,
SNAME VARCHAR(100),
CITY VARCHAR(100),
COMMISSION FLOAT
);

INSERT INTO SALESMAN(SALEMAN_ID, SNAME, CITY, COMMISSION)
VALUES
('5001', 'James Hoog', 'New York', '0.15');

INSERT INTO SALESMAN(SALEMAN_ID, SNAME, CITY, COMMISSION)
VALUES
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London' , 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007,	'Paul Adam','San Jose',	0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12);

CREATE TABLE ORDERS(
ORDER_NO INT,
PURC_AMT FLOAT,
ORD_DATE DATE,
CUSTOMER_ID INT,
SALESMAN_ID INT
);

INSERT INTO ORDERS(ORDER_NO, PURC_AMT,ORD_DATE,CUSTOMER_ID,SALESMAN_ID)
VALUES
-- (70001,150.5,'2012-10-05',3005,5006);-- 
(70009,270.65,'2011-09-10',3001,5005),
(70002,65.26,'2014-10-05',3002,5001),
(70004,110.5,'2011-08-17',3009,5003),
(70007,948.5,'2012-09-10',3005,5006),
(70005,2400.6,'2010-07-27',3007,5001),
(70008,5760,'2013-09-10',3002,5001),
(70010,1983.43,'2010-10-10',3004,5005),
(70003,2480.4,'2013-10-10',3009,5003),
(70012,250.45,'2010-06-27',3008,5002),
(70011,75.29,'2014-08-17',3003,NULL),
(70013,3045.6,'2010-04-25',3002,NULL);

CREATE TABLE CUSTOMERS(
customer_id INT,
cust_name VARCHAR(100),
city VARCHAR(100),
grade INT,
salesman_id  INT
);

INSERT INTO CUSTOMERS(customer_id, cust_name,city, grade, salesman_id)
VALUES
(3002,'Nick Rimando','New York',100,5001),
(3007,'John Brad Davis','New York',200,5001),
(3005,'Graham Zusi','California',200,5002),
(3008,'Julian Green','London',300,5002),
(3004,'Fabian Johnson','Paris',300,5006),
(3009,'Geoff Cameron','Berlin',100,5003),
(3003,'Jozy Altidor','Moscow',200,5007),
(3001,'John Brad Guzan','London',Null,5005);


-- QUESTION 2-- 

ALTER TABLE CUSTOMERS
MODIFY COLUMN RollNum INT NOT NULL;

ALTER TABLE CUSTOMERS ADD CONSTRAINT PK_CUSTOMER primary key (CUSTOMER_ID);
ALTER TABLE ORDERS ADD CONSTRAINT PK_ORDER primary key (ORDER_NO);
ALTER TABLE SALESMAN ADD CONSTRAINT PK_SALESMAN primary key (SALEMAN_ID);

ALTER TABLE CUSTOMERS
ADD CONSTRAINT FK_CUSTOMERS 
FOREIGN KEY (CUSTOMER_ID) 
REFERENCES SALESMAN(SALEMAN_ID) 
ON DELETE NO ACTION 
ON UPDATE CASCADE;




-- QUESTION 3-- 
SELECT DISTINCT SALEMAN_ID, CITY FROM SALESMAN;

-- QUESTION 4-- 
SELECT DISTINCT SNAME, CITY FROM SALESMAN WHERE CITY LIKE 'PARIS';

-- QUESTION 5-- 
SELECT * FROM CUSTOMERS WHERE GRADE>200;

-- QUESTION 6--
ALTER TABLE SALESMAN
MODIFY COLUMN SNAME INTO FULLNAME;

-- QUESTION 7--
SELECT * FROM CUSTOMERS WHERE cust_name LIKE 'john' OR city = 'London' OR city = 'Paris' OR city = 'New York';

-- QUESTION 8--
SELECT DISTINCT SNAME FROM SALESMAN WHERE SNAME LIKE 'N__I%';

-- QUESTION 9--
SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE ORD_DATE LIKE '%2012%' OR ORD_DATE LIKE '%2012%';

-- QUESTION 10--
SELECT * FROM SALESMAN WHERE COMMISSION>0.12 AND COMMISSION<0.14;














