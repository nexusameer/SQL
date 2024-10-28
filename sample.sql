Q1: Write a SQL statement to create a view called HighEarners that
selects EmployeeID, FirstName, LastName, and Salaryfor employees whose salary is
greater than 60000.
Q2: Display all employees, including those without a department, using a LEFT JOIN.
Create a view called UniqueDepartments that returns only unique department names
from the Departments table. How would you query this view?
Q3: Create a view called DepartmentAverageSalaries that calculates the average salary
for each department. Explain whether this view can be updated.
Q4: Write a SQL statement to create a view called EngineeringEmployees that includes
only employees from the Engineering department. Then, query this view to find all
employees with salaries above 70000.
Q5: Assume there’s a Managers table with ManagerID and EmployeeID. Create a view
called ManagerEmployees that shows EmployeeID, FirstName, LastName,
and ManagerName by joining Employees with Managers on EmployeeID.

Advanced Questions
Compound Views
Q1: Create a view called EmployeeSalaryGrowth that shows
the EmployeeID, FirstName, LastName, and the difference between their current salary
and a previous salary stored in the PreviousSalaries table. Explain how this view could be
useful for salary analysis.

View with Multiple Joins
Q1: Create a view called EmployeeProjectAssignments that
includes EmployeeID, FirstName, LastName, ProjectName, and StartDate by joining
the Employees, Projects, and Assignments tables.
View with Subqueries
Q1: Create a view called TopPerformers that shows EmployeeID, FirstName, LastName,
and Salary for employees