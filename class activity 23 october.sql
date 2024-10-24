-- Create the students table
Create DATABASE Lab;
USE Lab;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

-- Create the courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);

-- Create the marks table
CREATE TABLE marks (
    student_id INT,
    course_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert sample data into students
INSERT INTO students (student_id, name, city) VALUES
(1, 'Ali', 'Lahore'),
(2, 'Sara', 'Karachi'),
(3, 'Ahmed', 'Lahore'),
(4, 'Zara', 'Islamabad'),
(5, 'Usman', 'Lahore'),
(6, 'Fatima', 'Karachi');

-- Insert sample data into courses
INSERT INTO courses (course_id, course_name) VALUES
(101, 'Mathematics'),
(102, 'Physics'),
(103, 'Computer Science');

-- Insert sample data into marks
INSERT INTO marks (student_id, course_id, marks) VALUES
(1, 101, 85),
(1, 102, 78),
(2, 101, 88),
(3, 103, 92),
(3, 101, 79),
(4, 102, 65),
(5, 103, 94),
(5, 101, 81),
(6, 102, 73);

-- 1. Find the maximum marks from the students of Lahore.

SELECT MAX(MARKS) AS MARKS FROM (SELECT * FROM STUDENT WHERE CITY="LAHORE");

-- 2-List the names of students who scored above the average marks
-- in Mathematics. 

-- 3Find the course with the highest average marks.

-- 4. List all students who have never taken a Physics course.

-- 5. Find the students who scored the highest in any course. 