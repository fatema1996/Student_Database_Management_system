--Project- student_result_management.sql

------------------STUDENT_LOGIN TABLE----------------

CREATE TABLE STUDENT_LOGIN (
USERNAME VARCHAR (15),
PASSWORD VARCHAR (15),
);
DROP TABLE STUDENT_LOGIN;

insert into STUDENT_LOGIN VALUES('Shoshi',12345); 
insert into STUDENT_LOGIN VALUES('Fatema',54321); 
insert into STUDENT_LOGIN VALUES('Humayun',12346); 
insert into STUDENT_LOGIN VALUES('Raju',12347); 

SELECT * FROM STUDENT_LOGIN;


-----------STUDENT TABLE---------------------------------

CREATE TABLE Students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50),
    date_of_birth DATE,
    gender NVARCHAR(10),
    enrollment_year INT,
    department NVARCHAR(50)
);

DROP TABLE Students;
------------------------SUBJECT TABLE--------------------------

CREATE TABLE Subjects (
    subject_id INT IDENTITY(1,1) PRIMARY KEY,
    subject_name NVARCHAR(100) NOT NULL,
    subject_code NVARCHAR(10) NOT NULL UNIQUE
);
 
DROP TABLE Subjects;
---------------------- STUDENT_MARKS TABLE-----------------------
CREATE TABLE Marks (
    Student_id INT PRIMARY KEY,
    subject_id INT NOT NULL,
    marks_obtained DECIMAL(5, 2),
    exam_year INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);


DROP TABLE Marks;


-----------------------RESULT TABLE-----------------------------------
CREATE TABLE Results (
    result_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT,
    total_marks DECIMAL(5, 2),
    percentage DECIMAL(5, 2),
    grade NVARCHAR(2),
    exam_year INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);


DROP TABLE Results;
----------------------INSERT STUDENT INFORMATION---------------------------

INSERT INTO Students (first_name, last_name, date_of_birth, gender, enrollment_year, department)
VALUES
(N'SHOSHI',N'CHOWDHURY', '2000-04-15', N'Female', 2021, N'Computer Science'), ----N prefix for NVARCHAR data types to denote unicode string
(N'FATEMA TUJ', N'JOHURA', '1996-04-03', N'Female', 2021, N'DATA SCIENCE'),
(N'HUMAYUN', 'AHMAD', '1993-03-03', N'male', 2022, N'BUSINESS MANAGEMENT SYSTEM');

SELECT * FROM Students;



INSERT INTO Subjects (subject_name, subject_code)VALUES
(N'Mathematics', N'MATH101'),
(N'Business management', N'B_MAN101'),
(N'Computer Programming', N'COMP101');

SELECT * FROM Subjects;




INSERT INTO Marks VALUES ( 1, 85.5, 2022);
INSERT INTO Marks VALUES ( 2, 80.5, 2022);


SELECT * FROM marks;




INSERT INTO Results (student_id, total_marks, percentage, grade, exam_year)
SELECT 
    m.student_id,
    SUM(m.marks_obtained) AS total_marks,
    (SUM(m.marks_obtained) / (COUNT(m.subject_id) * 100)) * 100 AS percentage,
    CASE 
        WHEN (SUM(m.marks_obtained) / (COUNT(m.subject_id) * 100)) * 100 >= 90 THEN 'A'
        WHEN (SUM(m.marks_obtained) / (COUNT(m.subject_id) * 100)) * 100 >= 80 THEN 'B'
        
        ELSE 'F'
    END AS grade,
    m.exam_year
FROM Marks m
GROUP BY m.student_id, m.exam_year;


-------------------join operation------------------------------------------------------

SELECT s.first_name, s.last_name, sub.subject_name, m.marks_obtained, m.exam_year
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
JOIN Subjects sub ON m.subject_id = sub.subject_id
WHERE s.student_id = 1;


SELECT s.first_name, s.last_name, r.total_marks, r.percentage, r.grade, r.exam_year
FROM Students s
JOIN Results r ON s.student_id = r.student_id
WHERE r.exam_year = 2022;


SELECT s.first_name, s.last_name, r.total_marks, r.percentage, r.grade
FROM Students s
JOIN Results r ON s.student_id = r.student_id
ORDER BY r.percentage DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

SELECT * FROM Results;





















