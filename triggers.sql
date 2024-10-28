Skip to main content
Google Classroom
Classroom
Database- II (ITM)
Home
Calendar
Enrolled
To-do
O
Object Oriented Programming
ITM Fall 2024
D
Database- II (ITM)
I
ITM-DB
I
Introduction to Software Eng
A
I
ITM- BNU
A
Archived classes
Settings
Lecture on Triggers  Material details
Lecture on Triggers 
Nimra Abbas
•
9:10 AM

Triggers.sql
SQL

Triggers.docx
Word

Lecture 10.pptx
PowerPoint

Labsolution.sql
SQL

Schema.sql
SQL

Lab Task.docx
Word
Class comments

Add class comment…

CREATE DATABASE triggers11;
USE triggers11;

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

-- Before insert trigger

DELIMITER //
CREATE TRIGGER Age_Verify
BEFORE INSERT ON customer
FOR EACH ROW
BEGIN
    IF NEW.age < 0 THEN
        SET NEW.age = 0;
    END IF;
END //
DELIMITER ;

INSERT INTO customer (name, age)
VALUES 
    ('John Doe', 30),
    ('Jane Smith', -25),
    ('Alice Johnson', 35),
    ('Bob Brown', -40),
    ('Eve Davis', 28);

SELECT * FROM customer;

-- After insert trigger

CREATE TABLE customer1 (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(30),
    birthdate date
);

CREATE TABLE message (
    id INT AUTO_INCREMENT,
    messageid INT,
    message VARCHAR(300) NOT NULL,
    PRIMARY KEY (id, messageid));
    
DELIMITER //
CREATE TRIGGER Check_Null_DOB
AFTER INSERT ON customer1
FOR EACH ROW
BEGIN
    IF NEW.birthdate IS NULL THEN
        INSERT INTO message(messageid, message) VALUES (new.customer_id, concat('Hi', new.name,'Please update your date of birth'));
    END IF;
END //
DELIMITER ;

INSERT INTO customer1 (name, email, birthdate) VALUES 
("Nimra", "nimra@gmail.com", NULL),
("Ali", "ali@gmail.com", "1998-11-23"),
("Haris", "haris@gmail.com", NULL),
("Afia", "afia@gmail.com", "1999-12-21");

SELECT * FROM message;
Triggers.sql
Displaying Triggers.sql.