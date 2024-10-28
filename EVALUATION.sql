-- =======================================
-- Table Operations
-- =======================================

-- CREATE TABLE
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    PRIMARY KEY (column1)
);

-- ALTER TABLE
-- Add Column
ALTER TABLE table_name ADD COLUMN column_name datatype;

-- Drop Column
ALTER TABLE table_name DROP COLUMN column_name;

-- Modify Column
ALTER TABLE table_name MODIFY COLUMN column_name new_datatype;

-- Rename Table
ALTER TABLE old_name RENAME TO new_name;

-- Add Primary Key
ALTER TABLE table_name ADD PRIMARY KEY (column_name);

-- Add Foreign Key
ALTER TABLE table_name ADD FOREIGN KEY (column_name) REFERENCES other_table(column_name);

-- =======================================
-- DROP & TRUNCATE
-- =======================================

-- Drop Table (removes table structure and data)
DROP TABLE table_name;

-- Clear Data (removes all rows, but keeps table structure)
TRUNCATE TABLE table_name;

-- =======================================
-- Data Manipulation
-- =======================================

-- INSERT
INSERT INTO table_name (column1, column2) 
VALUES (value1, value2);

-- UPDATE
UPDATE table_name 
SET column1 = value1, column2 = value2
WHERE condition;

-- DELETE
DELETE FROM table_name 
WHERE condition;

-- =======================================
-- Querying Data
-- =======================================

-- SELECT Statements
-- Basic Select
SELECT * FROM table_name;

-- Select Specific Columns
SELECT column1, column2 FROM table_name;

-- With Condition
SELECT * FROM table_name WHERE condition;

-- Distinct Values
SELECT DISTINCT column FROM table_name;

-- =======================================
-- JOIN Operations
-- =======================================

-- Inner Join
SELECT * FROM table1
INNER JOIN table2
ON table1.id = table2.id;

-- Left Join (keeps all records from table1)
SELECT * FROM table1
LEFT JOIN table2
ON table1.id = table2.id;

-- Right Join (keeps all records from table2)
SELECT * FROM table1
RIGHT JOIN table2
ON table1.id = table2.id;

-- =======================================
-- WHERE Clause Conditions
-- =======================================

-- Equals
WHERE column = value

-- Greater/Less Than
WHERE column > value

-- Between a Range
WHERE column BETWEEN value1 AND value2

-- Pattern Matching
WHERE column LIKE 'pattern%'

-- In a List of Values
WHERE column IN (value1, value2);

-- =======================================
-- GROUP BY & HAVING
-- =======================================

-- Group data by a column and filter groups using HAVING
SELECT column1, COUNT(*)
FROM table_name
GROUP BY column1
HAVING COUNT(*) > value;

-- =======================================
-- ORDER BY
-- =======================================

-- Order results in Ascending or Descending order
SELECT * FROM table_name
ORDER BY column1 ASC; -- or DESC

-- =======================================
-- Functions
-- =======================================

-- Aggregate Functions
SELECT COUNT(*) FROM table_name;
SELECT SUM(column) FROM table_name;
SELECT AVG(column) FROM table_name;
SELECT MAX(column) FROM table_name;
SELECT MIN(column) FROM table_name;

-- String Functions
SELECT CONCAT(column1, ' ', column2) AS full_name FROM table_name;
SELECT UPPER(column) FROM table_name;
SELECT LOWER(column) FROM table_name;

-- =======================================
-- Stored Procedures
-- =======================================

DELIMITER //
CREATE PROCEDURE procedure_name(parameter1 datatype, parameter2 datatype)
BEGIN
    -- SQL statements
END //
DELIMITER ;

-- Calling the Procedure
CALL procedure_name(value1, value2);

-- =======================================
-- Triggers
-- =======================================

DELIMITER //
CREATE TRIGGER trigger_name
BEFORE/AFTER INSERT/UPDATE/DELETE ON table_name
FOR EACH ROW
BEGIN
    -- trigger logic
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Trigger error message';
    
END //
DELIMITER ;

-- =======================================
-- Common Constraints
-- =======================================

-- NOT NULL
-- Ensures a column cannot store NULL value

-- UNIQUE
-- Ensures all values in a column are different

-- PRIMARY KEY
-- A combination of NOT NULL and UNIQUE

-- FOREIGN KEY
-- Ensures referential integrity of data

-- CHECK
-- Ensures that all values in a column satisfy a specific condition

-- DEFAULT
-- Sets a default value for a column when no value is specified


-- SIMPLE
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;



-- JOIN VIEW

CREATE VIEW EmployeeDepartment AS
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, 
       Departments.DepartmentName, Employees.Salary
FROM Employees 
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;


-- AGGREGRATED VIEW

CREATE VIEW DepartmentSalaryTotals AS
SELECT DepartmentID, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID;

PRIMARY AND FOREIGN KEY EXAMPLE
CREATE TABLE Managers (
    ManagerID INT NOT NULL,
    EmployeeID INT,
    ManagerName VARCHAR(60) NOT NULL,
    PRIMARY KEY (ManagerID),  -- Setting primary key
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)  -- Setting foreign key
);

-- PRIMARY

ALTER TABLE Employees
ADD CONSTRAINT PK_EmployeeID PRIMARY KEY (EmployeeID);

-- FOREIGN KEY

ALTER TABLE Managers
ADD CONSTRAINT FK_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);


