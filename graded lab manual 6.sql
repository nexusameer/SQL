CREATE DATABASE UNIVERSITY;
USE UNIVERSITY;

-- CREATING TABLES --
CREATE TABLE DEPARTMENTS(
    DID INT PRIMARY KEY, 
    DNAME VARCHAR(50), 
    DHEAD VARCHAR(50)
);

CREATE TABLE STUDENTS(
    SID INT PRIMARY KEY, 
    SNAME VARCHAR(50), 
    DID INT, 
    FOREIGN KEY (DID) REFERENCES DEPARTMENTS(DID), 
    EYEAR INT
);

CREATE TABLE COURSES(
    CID INT PRIMARY KEY, 
    CNAME VARCHAR(50), 
    DID INT, 
    FOREIGN KEY (DID) REFERENCES DEPARTMENTS(DID), 
    CREDITS INT
);

CREATE TABLE ENROLLMENTS(
    EID INT PRIMARY KEY, 
    SID INT, 
    FOREIGN KEY (SID) REFERENCES STUDENTS(SID), 
    CID INT, 
    FOREIGN KEY (CID) REFERENCES COURSES(CID), 
    SEMESTER VARCHAR(50), 
    GRADE VARCHAR(50)
);

-- INSERTING VALUES --
INSERT INTO DEPARTMENTS VALUES
(1, 'COMPUTER SCIENCE', 'DR. ALICE JOHNSON'),
(2, 'MATHEMATICS', 'DR. BOB SMITH'),
(3, 'PHYSICS', 'DR. CAROL WHITE'),
(4, 'LITERATURE', 'DR. DAVID GREEN');

INSERT INTO STUDENTS VALUES
(101, 'JOHN DOE', 1, 2021),
(102, 'JANE SMITH', 2, 2020),
(103, 'EMILY DAVIS', 3, 2022),
(104, 'MICHAEL BROWN', 1, 2019),
(105, 'SARAH WILSON', 4, 2023);

INSERT INTO COURSES VALUES
(201, 'INTRODUCTION TO CS', 1, 4),
(202, 'DATA STRUCTURES', 1, 3),
(203, 'CALCULUS', 2, 4),
(204, 'QUANTUM MECHANICS', 3, 5),
(205, 'ENGLISH LITERATURE', 4, 3),
(206, 'ALGORITHMS', 1, 4);

INSERT INTO ENROLLMENTS VALUES
(301, 101, 201, 'FALL', 'A'),
(302, 101, 202, 'SPRING', 'B'),
(303, 102, 203, 'FALL', 'A-'),
(304, 103, 204, 'SPRING', 'B+'),
(305, 104, 206, 'FALL', 'A'),
(306, 105, 205, 'SPRING', 'B'),
(307, 101, 203, 'SPRING', 'B-'),
(308, 102, 201, 'FALL', 'C+');

-- Q1: LIST ALL STUDENTS ALONG WITH THE COURSES THEY HAVE ENROLLED IN --
SELECT S.SNAME, S.EYEAR, E.SEMESTER, C.CNAME 
FROM STUDENTS AS S
LEFT JOIN ENROLLMENTS AS E ON E.SID = S.SID 
LEFT JOIN COURSES AS C ON C.CID = E.CID;

-- Q2: FIND THE NAMES OF STUDENTS WHO HAVE TAKEN COURSES OFFERED BY THE COMPUTER SCIENCE DEPARTMENT --
SELECT S.SNAME, D.DID 
FROM STUDENTS AS S
LEFT JOIN DEPARTMENTS AS D ON S.DID = D.DID
WHERE D.DNAME = 'COMPUTER SCIENCE';

-- Q3: SHOW THE GRADES OBTAINED BY EACH STUDENT FOR EACH COURSE IN THE FALL SEMESTER --
SELECT S.SNAME, E.GRADE, E.SEMESTER, C.CID, C.CNAME 
FROM STUDENTS AS S
LEFT JOIN ENROLLMENTS AS E ON S.SID = E.SID 
LEFT JOIN COURSES AS C ON C.CID = E.CID
WHERE E.SEMESTER = 'FALL';

-- Q4: LIST ALL STUDENTS AND THE COURSES THEY HAVE TAKEN, INCLUDING STUDENTS WHO HAVE NOT ENROLLED IN ANY COURSES --
SELECT S.SID, S.SNAME, E.EID, E.CID, C.CNAME 
FROM STUDENTS AS S
LEFT JOIN ENROLLMENTS AS E ON E.SID = S.SID 
LEFT JOIN COURSES AS C ON C.CID = E.CID;

-- Q5: DISPLAY ALL COURSES ALONG WITH THE NAMES OF STUDENTS ENROLLED IN THEM, EVEN IF A COURSE HAS NO STUDENTS ENROLLED --
SELECT C.CNAME, C.CID, S.SNAME, E.EID 
FROM COURSES AS C
LEFT JOIN ENROLLMENTS AS E ON E.CID = C.CID 
LEFT JOIN STUDENTS AS S ON E.SID = S.SID;

-- Q6: LIST ALL ENROLLMENTS, INCLUDING DETAILS ABOUT STUDENTS EVEN IF THE COURSE INFORMATION IS NOT AVAILABLE --
SELECT E.EID, S.SID, S.SNAME, S.EYEAR, C.CID 
FROM ENROLLMENTS AS E
LEFT JOIN STUDENTS AS S ON E.SID = S.SID 
LEFT JOIN COURSES AS C ON E.CID = C.CID;

-- Q7: GENERATE A LIST OF ALL POSSIBLE STUDENT-COURSE PAIRS, EVEN IF A STUDENT IS NOT ENROLLED IN THE COURSE --
SELECT C.CNAME, C.CID, S.SNAME, S.SID 
FROM STUDENTS CROSS JOIN COURSES;

-- Q8: FIND PAIRS OF STUDENTS WHO ARE IN THE SAME DEPARTMENT --
SELECT S1.SNAME AS STUDENT1, S2.SNAME AS STUDENT2, D.DNAME 
FROM STUDENTS S1
JOIN STUDENTS S2 ON S1.DID = S2.DID AND S1.SID != S2.SID
JOIN DEPARTMENTS D ON S1.DID = D.DID;

-- Q9: IDENTIFY DEPARTMENTS WHERE MULTIPLE STUDENTS ENROLLED IN THE SAME YEAR --
SELECT D.DNAME, S.EYEAR, COUNT(S.SID) AS STUDENT_COUNT 
FROM STUDENTS AS S
JOIN DEPARTMENTS AS D ON S.DID = D.DID
GROUP BY D.DNAME, S.EYEAR
HAVING COUNT(S.SID) > 1;

-- Q10: LIST THE STUDENTS WHO HAVE TAKEN COURSES OUTSIDE THEIR DEPARTMENT AND THE GRADES THEY OBTAINED --
SELECT S.SNAME, C.CNAME, E.GRADE 
FROM ENROLLMENTS AS E
JOIN STUDENTS AS S ON E.SID = S.SID 
JOIN COURSES AS C ON E.CID = C.CID
WHERE S.DID != C.DID;

-- Q11: FIND THE DEPARTMENT HEADS WHOSE DEPARTMENTS HAVE THE MOST STUDENTS ENROLLED IN COURSES FOR THE FALL SEMESTER --
SELECT D.DHEAD, D.DNAME, COUNT(DISTINCT S.SID) AS STUDENT_COUNT 
FROM DEPARTMENTS AS D
JOIN STUDENTS AS S ON D.DID = S.DID 
JOIN ENROLLMENTS AS E ON E.SID = S.SID 
JOIN COURSES AS C ON E.CID = C.CID
WHERE E.SEMESTER = 'FALL'
GROUP BY D.DHEAD, D.DNAME
HAVING COUNT(DISTINCT S.SID) = (
    SELECT MAX(STUDENT_COUNT) 
    FROM (
        SELECT COUNT(DISTINCT S2.SID) AS STUDENT_COUNT 
        FROM DEPARTMENTS AS D2
        JOIN STUDENTS AS S2 ON D2.DID = S2.DID 
        JOIN ENROLLMENTS AS E2 ON E2.SID = S2.SID 
        JOIN COURSES AS C2 ON E2.CID = C2.CID
        WHERE E2.SEMESTER = 'FALL'
        GROUP BY D2.DHEAD, D2.DNAME
    ) AS DEPT_COUNTS
)
ORDER BY D.DHEAD;

-- Q12: SHOW THE AVERAGE GRADE PER COURSE FOR EACH DEPARTMENT --
SELECT D.DNAME, C.CNAME, AVG(E.GRADE) AS AVG_GRADE 
FROM DEPARTMENTS AS D
JOIN COURSES AS C ON D.DID = C.DID
JOIN ENROLLMENTS AS E ON C.CID = E.CID
GROUP BY D.DNAME, C.CNAME;