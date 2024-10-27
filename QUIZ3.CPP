CREATE DATABASE COMPANY;
USE COMPANY;

QNO1

CREATE TABLE employees 
(id INT, 
name VARCHAR(255), 
position VARCHAR(255), 
salary DECIMAL(10,2));



CREATE TABLE departments 
(id INT, 
dept_name VARCHAR(255), 
location VARCHAR(255));

insert INTO employees VALUES 
(1, "Alice", "Developer", 75000.00),
(2, "Bob", "Manager", 85000.00),
(3, "Charlie", "Designer", 60000.00),
(4, "John", "Developer", 60000.00);


INSERT INTO departments
VALUES
(1, "IT", "New York"),
(2, "HR", "San Francisco");


QNO 2
CALL ALLEMPLOYEE;
QNO3
CALL EMPLOYEE_ID(4);
QNO4

CALL CountEmployeesByPosition("Developer");
QNO 5
CALL AddEmployeeWithChecks(3,"JOHN","MANAGER",100000)


CREATE DEFINER=`root`@`localhost` PROCEDURE `ALLEMPLOYEE`()
BEGIN
SELECT * FROM EMPLOYEES;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `EMPLOYEE_ID`(IN A INT)
BEGIN
SELECT * FROM EMPLOYEES WHERE ID=A;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `CountEmployeesByPosition`(IN POSITION VARCHAR(50))
BEGIN        
select COUNT(*) FROM EMPLOYEES WHERE position = POSITION;    
END


CREATE PROCEDURE AddEmployeeWithChecks(
    IN SID INT, IN SNAME VARCHAR(50), IN SPOSITION VARCHAR(50), IN SSALARY INT
)
BEGIN
    -- Check if the salary is within the valid range
    IF SSALARY <= 0 OR SSALARY > 200000
    THEN
        SET MESSAGE_TEXT = 'Salary must be greater than 0 and less than or equal to 200,000';
    END IF;

    -- Check if the position is not empty
    IF SPOSITION IS NULL
    THEN
        SET MESSAGE_TEXT = 'Position cannot be empty';
    END IF;

    -- If all conditions are satisfied, insert the new employee
    INSERT INTO EMPLOYEES
    VALUES 
    (SID, SNAME, SPOSITION, SSALARY);
END