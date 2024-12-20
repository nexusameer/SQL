CREATE DATABASE XYZ;

USE XYZ;

CREATE TABLE STUDENT(
ID INT,
NAME VARCHAR(50)
);

CREATE TABLE COURSE(
ID INT,
COURSE VARCHAR(50)
);


INSERT INTO STUDENT
VALUES
(101, "ADAM"),
(102, "BOB"),
(103, "CASEY");

INSERT INTO COURSE
VALUES
(102, "ENGLISH"),
(105, "MATH"),
(103, "SCIENCE"),
(107, "CS");

ALTER TABLE COURSE
RENAME COLUMN COURSE TO NAME;

SELECT STUDENT.ID, COURSE.NAME FROM STUDENT
INNER JOIN COURSE
ON STUDENT.ID = COURSE.ID;

SELECT * FROM STUDENT AS S
INNER JOIN COURSE AS C
ON S.ID = C.ID;

SELECT * FROM STUDENT AS S
LEFT JOIN COURSE AS C
ON S.ID = C.ID
UNION
SELECT * FROM STUDENT AS S
RIGHT JOIN COURSE AS C
ON S.ID = C.ID;

SELECT * FROM STUDENT AS S
JOIN COURSE;