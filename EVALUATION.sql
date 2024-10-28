SQL Commands Cheatsheet
Table Operations
CREATE TABLE
sqlCopyCREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    PRIMARY KEY (column1)
);
ALTER TABLE

Add Column: ALTER TABLE table_name ADD COLUMN column_name datatype;
Drop Column: ALTER TABLE table_name DROP COLUMN column_name;
Modify Column: ALTER TABLE table_name MODIFY COLUMN column_name new_datatype;
Rename Table: ALTER TABLE old_name RENAME TO new_name;
Add Primary Key: ALTER TABLE table_name ADD PRIMARY KEY (column_name);
Add Foreign Key: ALTER TABLE table_name ADD FOREIGN KEY (column_name) REFERENCES other_table(column_name);

DROP & TRUNCATE

Drop Table: DROP TABLE table_name;
Clear Data: TRUNCATE TABLE table_name;

Data Manipulation
INSERT
sqlCopyINSERT INTO table_name (column1, column2) 
VALUES (value1, value2);
UPDATE
sqlCopyUPDATE table_name 
SET column1 = value1, column2 = value2
WHERE condition;
DELETE
sqlCopyDELETE FROM table_name 
WHERE condition;
Querying Data
SELECT

Basic Select: SELECT * FROM table_name;
Specific Columns: SELECT column1, column2 FROM table_name;
With Condition: SELECT * FROM table_name WHERE condition;
Distinct Values: SELECT DISTINCT column FROM table_name;

JOIN Operations
sqlCopy-- Inner Join
SELECT * FROM table1
INNER JOIN table2
ON table1.id = table2.id;

-- Left Join
SELECT * FROM table1
LEFT JOIN table2
ON table1.id = table2.id;

-- Right Join
SELECT * FROM table1
RIGHT JOIN table2
ON table1.id = table2.id;
WHERE Clause

Equals: WHERE column = value
Greater/Less Than: WHERE column > value
Between: WHERE column BETWEEN value1 AND value2
Like: WHERE column LIKE 'pattern%'
In: WHERE column IN (value1, value2)

GROUP BY & HAVING
sqlCopySELECT column1, COUNT(*)
FROM table_name
GROUP BY column1
HAVING COUNT(*) > value;
ORDER BY
sqlCopySELECT * FROM table_name
ORDER BY column1 ASC/DESC;
Functions
Aggregate Functions

COUNT(): SELECT COUNT(*) FROM table_name;
SUM(): SELECT SUM(column) FROM table_name;
AVG(): SELECT AVG(column) FROM table_name;
MAX(): SELECT MAX(column) FROM table_name;
MIN(): SELECT MIN(column) FROM table_name;

String Functions

CONCAT(): SELECT CONCAT(column1, ' ', column2) AS full_name
UPPER(): SELECT UPPER(column) FROM table_name
LOWER(): SELECT LOWER(column) FROM table_name

Stored Procedures
sqlCopyDELIMITER //
CREATE PROCEDURE procedure_name(parameter1 datatype, parameter2 datatype)
BEGIN
    -- SQL statements
END //
DELIMITER ;

-- Call procedure
CALL procedure_name(value1, value2);
Triggers
sqlCopyDELIMITER //
CREATE TRIGGER trigger_name
BEFORE/AFTER INSERT/UPDATE/DELETE ON table_name
FOR EACH ROW
BEGIN
    -- trigger logic
END //
DELIMITER ;
Common Constraints

NOT NULL
UNIQUE
PRIMARY KEY
FOREIGN KEY
CHECK
DEFAULT