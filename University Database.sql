--1: Create University Database
CREATE DATABASE MGKVP
USE MGKVP

--2. Under this University Create four tables
CREATE TABLE College_Table (
College_ID INT PRIMARY KEY NOT NULL,
College_Name VARCHAR(255) NOT NULL,
College_Area VARCHAR(255) NOT NULL
);

INSERT INTO College_Table (College_ID, College_Name, College_Area)
VALUES
(1, 'Santushti College of Medical & Higher Studies', 'Chunar, Uttar Pradesh'),
(2, 'Heritage Institute of Medical Sciences - [HIMS]', 'Varanasi, Uttar Pradesh'),
(3, 'Sunbeam College for Women', 'Varanasi, Uttar Pradesh'),
(4, 'K B Postgraduate College', 'Mirzapur, Uttar Pradesh'),
(5, 'Shri Ram Karan PG College - [SRKPGC]', 'Ballia, Uttar Pradesh'),
(6, 'Awadhoot Bhagwan Ram PG College - [ABRPGC]', 'Sonbhadra, Uttar Pradesh'),
(7, 'Hari Shanker Prasad Law College', 'Ballia, Uttar Pradesh'),
(8, 'Mathura College of Law', 'Mirzapur, Uttar Pradesh'),
(9, 'Babu Ram Singh Mahavidyalaya', 'Sonbhadra, Uttar Pradesh'),
(10, 'Udai Pratap College', 'Varanasi, Uttar Pradesh');



CREATE TABLE Department_Table (
Dept_ID INT PRIMARY KEY NOT NULL,
Dept_Name VARCHAR(255) NOT NULL,
Dept_Facility VARCHAR(255) NOT NULL,
College_ID INT,
FOREIGN KEY (College_ID) REFERENCES College_Table(College_ID)
);

INSERT INTO Department_Table (Dept_ID, Dept_Name, Dept_Facility, College_ID)
VALUES
(1, 'BAMS', 'BAMS Labs', 1),
(2, 'MBBS', 'MBBS Labs', 2),
(3, 'B.COM', 'B.COM Labs', 3),
(4, 'BA', 'BA Labs', 4),
(5, 'BA', 'BA Labs', 5),
(6, 'B.SC', 'B.SC Labs', 6),
(7, 'LLB', 'LLB Labs', 7),
(8, 'LLB', 'LLB Labs', 8),
(9, 'B.COM', 'B.COM Labs', 9),
(10, 'B.SC', 'B.SC Labs', 10);


CREATE TABLE Professor_Table (
Professor_ID INT PRIMARY KEY NOT NULL,
Professor_Name VARCHAR(255) NOT NULL,
Professor_Subject VARCHAR(255) NOT NULL
);

INSERT INTO Professor_Table (Professor_ID, Professor_Name, Professor_Subject)
VALUES
(1, 'Dr. Arvind Kumar', 'Chemistry'),
(2, 'Prof. Sandeep Mishra', 'Physics'),
(3, 'Dr. Neelam Yadav', 'Mathematics'),
(4, 'Prof. Rajesh Sharma', 'Organic Chemistry'),
(5, 'Dr. Deepa Reddy', 'Biochemical Studies'),
(6, 'Dr. Ravi Verma', 'Applied Mathematics'),
(7, 'Prof. Meera Singh', 'Accounts'),
(8, 'Dr. Shankar Iyer', 'Social Justice and Policy'),
(9, 'Prof. Anjali Desai', 'Law and Governance'),
(10, 'Dr. Vikram Rao', 'Commerce');


CREATE TABLE Student_Table (
Student_ID INT PRIMARY KEY NOT NULL,
Student_Name VARCHAR(255) NOT NULL,
Student_Stream VARCHAR(255) NOT NULL,
Professor_ID INT,
FOREIGN KEY (Professor_ID) REFERENCES Professor_Table(Professor_ID)
);

INSERT INTO Student_Table (Student_ID, Student_Name, Student_Stream, Professor_ID)
VALUES
(1, 'Amit Patel', 'Chemistry', 1),
(2, 'Neha Gupta', 'Physics', 2),
(3, 'Rajesh Kumar', 'Mathematics', 3),
(4, 'Pooja Sharma', 'Chemistry', 4),
(5, 'Ravi Reddy', 'Biotechnology', 5),
(6, 'Shivani Jain', 'Mathematics', 6),
(7, 'Ankit Soni', 'Accounts', 7),
(8, 'Sneha Rani', 'Sociology', 8),
(9, 'Nikhil Gupta', 'Law', 9),
(10, 'Priya Verma', 'commerce', 10);



-------------------------------------------Task 2:------------------------------------------


--1. Give the information of College_ID and College_name from College_Table
SELECT College_id, college_name
FROM College_Table

--2. Show Top 5 rows from Student table
SELECT TOP 5 *
FROM Student_Table

--3. What is the name of professor whose ID is 5
SELECT Professor_Name
FROM Professor_Table
WHERE Professor_ID = 5

--4. Convert the name of the Professor into Upper case
SELECT UPPER(Professor_Name) AS Professor_Uppercase
FROM Professor_Table

--5. Show me the names of those students whose name is start with a
SELECT Student_Name
FROM Student_Table
WHERE Student_Name LIKE 'A%'

--6. Give the name of those colleges whose end with a
SELECT College_Name
FROM College_Table
WHERE College_Name LIKE '%a'

--7. Add one Salary Column in Professor_Table
ALTER TABLE Professor_Table
ADD Salary DECIMAL(10, 2)

--8. Add one Contact Column in Student_table
ALTER TABLE Student_Table
ADD Contact VARCHAR(15)

--9. Find the total Salary of Professor 
SELECT SUM(Salary) AS Total_Salary
FROM Professor_Table

--10. Change datatype of any one column of any one Table
ALTER TABLE Student_Table
ALTER COLUMN Contact VARCHAR(20)



---------------------------------------------Task 3:-----------------------------------------


--1. Show first 5 records from Students table and Professor table Combine
SELECT TOP 5 Student_ID, Student_Name, Student_Stream
FROM Student_Table
UNION ALL                                                
SELECT TOP 5 Professor_ID, Professor_Name, Professor_Subject
FROM Professor_Table

--2. Apply Inner join on all 4 tables together(Syntax is mandatory)
SELECT ct.College_Name, dt.Dept_Name, pt.Professor_Name, st.Student_Name
FROM College_Table ct
INNER JOIN Department_Table dt ON ct.College_ID = dt.College_ID
INNER JOIN Professor_Table pt ON dt.Dept_ID = pt.Professor_ID
INNER JOIN Student_Table st ON pt.Professor_ID = st.Professor_ID

--3. Show Some null values from Department table and Professor table.
SELECT *
FROM Department_Table
WHERE Dept_Facility IS NULL

SELECT *
FROM Professor_Table
WHERE Professor_Name IS NULL

--4. Create a View from College Table and give those records whose college name starts with CCREATE VIEW College_View 
AS
SELECT College_ID, College_Name
FROM College_Table
WHERE College_Name LIKE 'C%'

-- To see the data in the view:
SELECT * FROM College_View

--5. Create Stored Procedure of Professor table whatever Professor ID will be given by user it should show whole records of it.
CREATE PROCEDURE GetProfessorDetails
@Professor_id int
AS 
Begin
SELECT *
FROM Professor_Table
WHERE Professor_ID=@Professor_id
END

EXEC GetProfessorDetails @Professor_ID = 1

--6. Rename the College_Table to College_Tables_Data .
EXEC sp_rename 'College_Table', 'College_Tables_Data'








