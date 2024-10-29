-- NAME : MUHAMMAD AMEER HAMZA
-- ROLL NO SUM24-0028






-- ______________________________________________________SCHEMAS_________________


Create Database Finalexam1;
USE Finalexam1;

-- Schema
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    enrollment_year YEAR
);

CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    hire_date DATE
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT CHECK (credits > 0)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade DECIMAL(5,2) CHECK (grade BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert Data
INSERT INTO Students (student_id, first_name, last_name, email, enrollment_year) VALUES
(1, 'Alice', 'Smith', 'alice@example.com', 2021),
(2, 'Bob', 'Johnson', 'bob@example.com', 2020),
(3, 'Charlie', 'Williams', 'charlie@example.com', 2022),
(4, 'David', 'Miller', 'david@example.com', 2019),
(5, 'Eva', 'Martinez', 'eva@example.com', 2021),
(6, 'Frank', 'Garcia', 'frank@example.com', 2020);

INSERT INTO Teachers (teacher_id, first_name, last_name, email, hire_date) VALUES
(1, 'Dr. James', 'Brown', 'james@example.com', '2020-01-15'),
(2, 'Prof. Linda', 'Davis', 'linda@example.com', '2019-08-20'),
(3, 'Dr. Carol', 'Martinez', 'carol@university.edu', '2016-02-10'),
(4, 'Prof. Henry', 'Lopez', 'henry@university.edu', '2013-05-14');

INSERT INTO Courses (course_id, course_name, credits) VALUES
(1, 'Database Systems', 3),
(2, 'Web Development', 4),
(3, 'Artificial Intelligence', 3),
(4, 'Machine Learning', 3),
(5, 'Computer Networks', 3);

INSERT INTO COURSES
VALUES 
(6, 'BLAW', 4);



INSERT INTO Enrollments (enrollment_id, student_id, course_id, grade) VALUES
(1, 1, 1, 88.50),
(2, 1, 2, 92.00),
(3, 2, 1, 75.00),
(4, 3, 3, 81.00),
(5, 2, 2, 83.00),
(6, 3, 1, 67.50),
(7, 4, 3, 85.25),
(8, 5, 1, 92.50),
(9, 5, 2, 88.00),
(10, 6, 3, 74.00),
(11, 6, 1, 65.00),
(12, 1, 3, 78.00),
(13, 4, 2, 59.50),
(14, 5, 3, 68.25);

INSERT INTO ENROLLMENTS
VALUES
(15, 1,6, 68.00);

INSERT INTO ENROLLMENTS
VALUES
(16, 4,1,90);

SELECT * FROM Students;
SELECT * FROM Teachers;
SELECT * FROM Courses;
SELECT * FROM Enrollments;






________________________________________________________________________________________________

-- QUSETION no 1:

-- 1: RETRIEVE ALL STUDENTS 
SELECT S.STUDENT_ID, S.FIRST_NAME, S.LAST_NAME, C.COURSE_NAME
FROM STUDENTS S
LEFT JOIN ENROLLMENTS S ON S.STUDENT_ID = E.STUDENT_ID
LEFT JOIN COURSES C ON e.course_id = c.course_id;


-- 2: FIND ALL TEACHERS WHOSE EMAIL AND THEIR YEAR OF EXPERIENVE BETWEEN 5 AND 10 YEARS
-- ASSUME FROM TODAY DATE

SELECT T.teacher_id, T.first_name, T.last_name, T.email, T.hire_date
FROM TEACHERS T
WHERE T.email LIKE '%@university.edu' AND T.hire_date BETWEEN '2010-01-01' AND '2020-12-31';

-- 3: COUNT NUMBER OF STUDENT ENROLLED IN COURSE SHOW THE COURSE NAME AND THE COUNT FILTER THE RESULT TO INCLUDE ONLY THOSE COURSES WITH MORE THAN 3 STUDENTS


SELECT C.course_name, COUNT(E.student_id) AS student_count
FROM Courses C
JOIN Enrollments E ON C.course_id = E.course_id
GROUP BY C.course_name
HAVING COUNT(E.student_id) > 3;


-- 4: FIND ALL STUDENTS WHO HAVE ENROLLED IN MORE THAN TWO COURSES BUT ONLY LIST THEIR FIRST AND LAST NAME ONCE

SELECT S.first_name, S.last_name
FROM Students S
JOIN Enrollments E ON S.student_id = E.student_id
GROUP BY S.first_name, S.last_name
HAVING COUNT(E.course_id) > 2;

-- 5 FIND SECOND HIGHEST GRADE IN ENROLLEMENTS TABLE

SELECT MAX(grade) AS second_highest_grade
FROM Enrollments
WHERE grade < (SELECT MAX(grade) FROM Enrollments);


-- 6:FIND NUMBER OF SUTDENTS ENROLLED IN EACH COURSE ONLY RETURN THE COURSES THAT HAVE MORE THAN 5 STUDENTS ENROLLED


SELECT C.course_name, COUNT(E.student_id) AS student_count
FROM Courses C
JOIN Enrollments E ON C.course_id = E.course_id
GROUP BY C.course_name
HAVING COUNT(E.student_id) > 5;

______________________________________________________________________________________________________________________________


-- QUESTION NO 2:


-- SCENARIO 1:
ALTER TABLE STUDENTS ADD COLUMN MAJORS VARCHAR(50);

UPDATE STUDENTS
SET MAJORS = 'Computer Science'
WHERE STUDENT_ID = 1;

UPDATE STUDENTS
SET MAJORS = 'IT'
WHERE STUDENT_ID > 3;

UPDATE STUDENTS
SET MAJORS = 'FORMANIGHTS'
WHERE STUDENT_ID = 2;

UPDATE STUDENTS
SET MAJORS = 'COMPUTER SCIENCE'
WHERE STUDENT_ID = 3;

SELECT * FROM STUDENTS;

-- TASK 1:
CREATE VIEW StudentMajorView AS
SELECT first_name, last_name, MAJORS
FROM Students;

SELECT * FROM STUDENTMAJORVIEW;

-- SCENARIO 2:
-- TASK 2:
CREATE VIEW StudentCourseGrades AS
SELECT S.first_name, S.last_name, C.course_name, E.grade,
CASE WHEN E.grade >= 60 THEN 'Pass'
     ELSE 'Fail'
END AS pass_fail
FROM Students S
JOIN Enrollments E ON S.student_id = E.student_id
JOIN Courses C ON E.course_id = C.course_id;

SELECT * FROM STUDENTCOURSEGRADES;


__________________________________________________________________________________________________________________________


-- QUESTION NO 3:

-- 1: 
SELECT S.first_name, S.last_name, SUM(E.grade) AS total_grades
FROM students S
JOIN enrollments E ON S.student_id = E.student_id
GROUP BY S.student_id
HAVING total_grades > 150;


-- 2:

ALTER TABLE ENROLLMENTS 
ADD COLUMN ENROLLMENT_DATE DATE DEFAULT '2020-01-15';


DELIMITER //
CREATE TRIGGER SET_ENROLLMENT_DATE
BEFORE INSERT ON Enrollments
FOR EACH ROW
BEGIN
    IF NEW.enrollment_date IS NULL THEN
        SET NEW.enrollment_date = CURDATE();
    END IF;
END //
DELIMITER ;

SELECT * FROM ENROLLMENTS;

INSERT INTO ENROLLMENTS
VALUES
(17,2,6,98, '2020-12-12');

INSERT INTO ENROLLMENTS
VALUES
(17,2,6,98);

-- 3: 

CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_STUDENT_GRADE`(IN PSTUDENTID INT, IN PCOURSEID INT, IN PNEWGRADE DECIMAL(5,2))
BEGIN
    UPDATE ENROLLMENTS
    SET grade = PNEWGRADE
    WHERE student_id = PSTUDENTID AND course_id = PCOURSEID;
END

CALL UPDATE_STUDENT_GRADE(1,2,95.0);

SELECT * FROM ENROLLMENTS;

-- 4:
SELECT S.FIRST_NAME, S.LAST_NAME, AVG(E.GRADE) AS AVERAGE_GRADE
FROM STUDENTS AS S
JOIN ENROLLMENTS AS E ON S.STUDENT_ID = E.STUDENT_ID
GROUP BY S.FIRST_NAME, S.LAST_NAME
HAVING AVG(E.GRADE) > (SELECT AVG(GRADE) FROM ENROLLMENTS);











