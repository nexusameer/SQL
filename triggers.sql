Create DATABASE Lab7;
USE Lab7;
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

-- Lab Questions --
-- Q1: 1.Find the maximum marks from the students of Lahore.
SELECT student_id, MAX(marks) AS max_marks
FROM marks
WHERE student_id IN (SELECT student_id FROM students WHERE city = 'Lahore');

-- In order to add one more column with this (discuss this in case students ask)
SELECT student_id, marks AS max_marks
FROM marks
WHERE marks = (
    SELECT MAX(marks)
    FROM marks
    WHERE student_id IN (SELECT student_id FROM students WHERE city = 'Lahore')
)
AND student_id IN (SELECT student_id FROM students WHERE city = 'Lahore');

-- Q2: List the names of students who scored above the average marks in Mathematics.
SELECT name 
FROM students 
WHERE student_id IN (
    SELECT student_id 
    FROM marks 
    WHERE course_id = 101 
    AND marks > (SELECT AVG(marks) FROM marks WHERE course_id = 101)
);

-- Q3: Find the course with the highest average marks.
SELECT course_name 
FROM courses 
WHERE course_id = (
    SELECT course_id 
    FROM marks 
    GROUP BY course_id 
    ORDER BY AVG(marks) DESC 
);

-- Q4: List all students who have never taken a Physics course.
SELECT name 
FROM students 
WHERE student_id NOT IN (
    SELECT DISTINCT student_id 
    FROM marks 
    WHERE course_id = 102
);

-- Q5: Find the students who scored the highest in any course.
SELECT name 
FROM students 
WHERE student_id IN (
    SELECT student_id 
    FROM marks 
    WHERE (course_id, marks) IN (
        SELECT course_id, MAX(marks) 
        FROM marks 
        GROUP BY course_id
    )
);
