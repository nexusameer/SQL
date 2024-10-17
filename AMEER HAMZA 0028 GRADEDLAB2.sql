-- Q1: Create a database named SchoolDB.--
CREATE DATABASE SCHOOLDB; 

USE SCHOOLDB;
-- Q2: Create Tables: Create two tables, Students and Courses. The Students table should
-- have columns StudentID, FirstName, LastName, Age, and Marks. The Courses table
-- should have columns CourseID, CourseName, and StudentID.

CREATE TABLE STUDENT(
STUDENTID INT NOT NULL, 
FIRSTNAME VARCHAR(50) NOT NULL,
LASTNAME VARCHAR(50) NOT NULL, 
AGE INT NOT NULL, 
MARKS INT NOT NULL);

CREATE TABLE COURSE(
COURSEID INT NOT NULL,
COURSENAME VARCHAR(50) NOT NULL,
STUDENTID INT NOT NULL);

-- PRIMARY AND FORIEGN KEY SET MANUALLY JUST FOR PRACTICE-- 
ALTER TABLE STUDENT
ADD PRIMARY KEY (STUDENTID);

ALTER TABLE COURSE
ADD PRIMARY KEY (COURSEID);

ALTER TABLE COURSE
ADD CONSTRAINT FK_STUDENT
FOREIGN KEY (STUDENTID) REFERENCES STUDENT(STUDENTID);

-- Q3: Insert sample data into the Students and Courses tables.--
INSERT INTO STUDENT(STUDENTID, FIRSTNAME, LASTNAME, AGE, MARKS)
VALUES
(1, "AMEER", "HAMZA", 23, 100),
(2, "ALI", "KHALID", 24, 90),
(3, "KHURRAM", "SHAHZAD", 22, 80);

INSERT INTO COURSE(COURSEID, COURSENAME, STUDENTID)
VALUES
(1,"DATABASE", 1),
(2,"DATA STRUCTURE",1),
(3,"PF", 1),
(4,"DATABASE", 2),
(5,"DATA STRUCTURE",2),
(6,"PF", 2),
(7, "SQL", 3);

-- Q4: Update the Marks of the student with StudentID = 3 to 65.-- 
UPDATE STUDENT
SET MARKS=65 WHERE STUDENTID=3;

SELECT * FROM STUDENT WHERE STUDENTID=3;

-- Q5: Use the ALTER Command and Add a new column Gender to the Students table
-- and set the gender for each student.
-- ADD TABLE HERE
ALTER TABLE STUDENT
ADD GENDER VARCHAR(50) DEFAULT "MALE";

SELECT * FROM STUDENT;
-- INSERT A NEW ROW-- 
INSERT INTO STUDENT
VALUES
(4,"NOOR", "AHMAD", 12,23,"FEMALE");

-- Q6: Arithmetic Operators : Display the StudentID, FirstName, and the marks
-- increased by 10%.-- 

SELECT STUDENTID, FIRSTNAME, MARKS, (MARKS*1.1) AS INCREASED FROM STUDENT;

-- Q7: Concatenate FirstName and LastName into a single column called FullName.
SELECT CONCAT(FIRSTNAME," ",LASTNAME) AS FULLNAME FROM STUDENT;

-- ADD FULLNAME COLUMN
ALTER TABLE STUDENT
ADD FULLNAME VARCHAR(50);

-- ADD VALUE IN FULLNAME-- 
UPDATE STUDENT
SET FULLNAME = CONCAT(FIRSTNAME, ' ', LASTNAME);

-- Q8: Display the students whose marks are between 70 and 90.-- 
SELECT * FROM STUDENT 
WHERE MARKS BETWEEN 70 AND 90;

-- Q9: Display all students sorted by Marks in descending order.-- 
SELECT * FROM STUDENT 
ORDER BY MARKS DESC;

-- Q10: Group the students by Gender and calculate the average marks for each
-- gro-- up.-- 
SELECT GENDER, SUM(MARKS)/COUNT(*) AS AVERAGE FROM STUDENT
GROUP BY GENDER;

-- Q11: Show the groups of students where the average marks are greater than
-- 70.
INSERT INTO STUDENT(STUDENTID, FIRSTNAME, LASTNAME, AGE,MARKS,GENDER,FULLNAME)
VALUES
-- INSERT DATA TO PERFORM OPERATIONS
(7,"NIMRA", "ABBAS",24,99,"FEMALE","NIMRA ABBAS"),
(6,"SHAFAQ", "LIAQAT",22,99,"FEMALE","SHAFAQ LIAQAT"),
(8,"RAFAQ", "HANNAS",24,100,"FEMALE","RAFAQ HANNAS");

SELECT GENDER, AVG(MARKS) FROM STUDENT
GROUP BY GENDER 
HAVING AVG(MARKS)>70; 

-- Q12: Find the total marks, average marks, maximum marks, and minimum
-- marks.

SELECT  SUM(MARKS) AS TotalMarks, 
    AVG(MARKS) AS AverageMarks, 
    MAX(MARKS) AS MaximumMarks, 
    MIN(MARKS) AS MinimumMarks FROM STUDENT;

-- Q13: Group the data by Gender and Age, then find the sum of marks for each
-- group.
SELECT GENDER,AGE, SUM(MARKS) FROM STUDENT
GROUP BY GENDER,AGE;
