CREATE DATABASE CompanyDB;


USE CompanyDB;


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT
);


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);


INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing');


INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID)
VALUES
(101, 'Alice', 1),
(102, 'Bob', 2),
(103, 'Charlie', 3),
(104, 'David', 4),
(105, 'Eve', NULL); 

-- 1st question
-- Q1: Display the employee details along with their department names using an INNER
-- JOIN.

SELECT Employees.EmployeeID, Employees.EmployeeName, Departments.DepartmentName
FROM Employees
INNER JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID;


-- 2nd question
-- Q2: Display all employees, including those without a department, using a LEFT JOIN.

SELECT Employees.EmployeeID, Employees.EmployeeName, Departments.DepartmentName
FROM Employees
LEFT JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID;

-- 3rd question
-- Q3: Display all departments, including those without any employees, using a RIGHT JOIN.
SELECT Employees.EmployeeID, Employees.EmployeeName, Departments.DepartmentName
FROM Employees
RIGHT JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID;


-- 4th question
-- Q4: Display all possible combinations of employees and departments using
-- Cross Join (Also menttion in comment about how cross join works)

SELECT Employees.EmployeeID, Employees.EmployeeName, Departments.DepartmentName
FROM Employees
CROSS JOIN Departments;


-- 5th quesiton
-- Q5: Display pairs of employees who work in the same department. Identify the
-- join type and apply it.-- 
SELECT e1.EmployeeID, e1.EmployeeName, e2.EmployeeID AS ColleagueID, e2.EmployeeName AS ColleagueName
FROM Employees e1
INNER JOIN Employees e2
ON e1.DepartmentID = e2.DepartmentID
WHERE e1.EmployeeID <> e2.EmployeeID;
