CREATE DATABASE SchoolDB;

USE SchoolDB;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Age INT,
    Gender ENUM('Male', 'Female'),
    EnrollmentDate DATE
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Insert Sample Data
INSERT INTO Students (StudentID, StudentName, Age, Gender, EnrollmentDate) VALUES
(1, 'Alice', 20, 'Female', '2022-09-01'),
(2, 'Bob', 22, 'Male', '2021-09-01'),
(3, 'Charlie', 21, 'Male', '2022-09-01'),
(4, 'Diana', 19, 'Female', '2023-09-01');

INSERT INTO Courses (CourseID, CourseName, Credits) VALUES
(101, 'Mathematics', 3),
(102, 'Science', 4),
(103, 'History', 3);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID) VALUES
(1, 1, 101),
(2, 1, 102),
(3, 2, 101),
(4, 3, 103),
(5, 4, 102);

-- Write a SQL query to retrieve the names of all students along with
-- their enrollment dates.

SELECT STUDENTNAME, EnrollmentDate FROM STUDENTS;


-- 2. Write a SQL query to list all courses along with the total number of
-- students enrolled in each course.
SELECT C.COURSENAME, COUNT(E.STUDENTID) AS TOTALSTUDENTS FROM COURSES C
LEFT JOIN 
ENROLLMENTS E ON C.COURSEID = E.COURSEID
GROUP BY C.COURSENAME;

-- 3. Write a SQL query to get the names of students enrolled in the
-- Mathematics course.

SELECT S.STUDENTNAME FROM STUDENTS S
JOIN 
ENROLLMENTS E ON S.STUDENTID = E.STUDENTID
JOIN 
COURSES C ON E.COURSEID = C.COURSEID
WHERE 
 C.COURSENAME = "Mathematics";

-- 4 Write a SQL query to find students who are not enrolled in any
-- courses.

INSERT INTO STUDENTS
VALUES
(5, "HAMZA", 23 , "MALE", "2023-09-01");

SELECT S.STUDENTNAME FROM STUDENTS S
LEFT JOIN 
ENROLLMENTS E ON S.STUDENTID = E.STUDENTID
WHERE
E.COURSEID IS NULL;

-- 5. Write a SQL query to list the names of all students along with their
-- corresponding course names (showing only students who are
 -- enrolled in a course).
 
 SELECT STUDENTNAME FROM STUDENTS S 
 LEFT JOIN
 ENROLLMENTS E ON S.STUDENTID = E.STUDENTID
 WHERE 
 E.COURSEID IS NOT NULL;
 
 
