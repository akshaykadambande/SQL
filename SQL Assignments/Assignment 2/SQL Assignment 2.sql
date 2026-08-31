-- 1. Create a database named UniversityDB.

CREATE DATABASE university_db;
USE university_db;

-- 2. Design three tables with proper relationships:
-- Students (StudentID, Name, Age, DepartmentID)
-- Departments (DepartmentID, DepartmentName)
-- Courses (CourseID, CourseName, StudentID)
-- 3. Establish the relationships:

CREATE TABLE departments (
    department_id varchar(5) PRIMARY KEY NOT NULL,
    department_name VARCHAR(30) NOT NULL);
CREATE TABLE students (
    student_id varchar(5) PRIMARY KEY NOT NULL,
    name VARCHAR(30) not null,
    age INT NOT NULL,
    department_id varchar(5) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments (department_id) );
CREATE TABLE courses (
    course_id varchar(5)  NOT NULL,
    course_name VARCHAR(30) NOT NULL,
    student_id varchar(5) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students (student_id) );
    
-- 4. Insert at least 5 records in each table.    
insert into departments (department_id,department_name) values
('d01','Artificial Intelliugence'),
('d02', 'Computer Science'),
('d03', 'Electronics'),
('d04','Psychology'),
('d05', 'Information Technology'); 

insert into students values
('s1001','Alison Norman',25,'d04'),
('s1002', 'Michael Jack',24,'d01'),
('s1003', 'Morris Hatson',26,'d03'),
('s1004','Stuart Braga',26,'d05'),
('s1005', 'Alice Johnson',24,'d01'),
('s1006','Park  Depp',25,'d04'),
('s1007', 'Chris Jackel',24,'d02'),
('s1008', 'Steve Potter',26,'d03'),
('s1009','Neil Lion',26,'d05'),
('s1010', 'Verronica Johnson',25,'d02');    

INSERT INTO courses VALUES
('c1', 'Database Management', 's1001'),
('c2', 'Data Analytics', 's1002'),
('c3', 'Cloud Computing', 's1003'),
('c4', 'Web Development', 's1004'),
('c1', 'Database Management', 's1005'),
('c2', 'Data Analytics', 's1006'),
('c3', 'Cloud Computing', 's1007'),
('c4', 'Web Development', 's1008'),
('c3', 'DOCS', 's1009'),
('c4', 'Web Development', 's1005'),
('c4', 'Web Development', 's1010');

select * from courses;
select * from departments;
select * from students;

-- 5. Query-Based Questions
-- a. Retrieve all student details along with their department names.
SELECT  name, department_name
FROM students JOIN departments 
ON students.department_id = departments.department_id;

-- b. Find the names of all students who are enrolled in 'Artificial Intelligence'.
SELECT  name department_name
FROM students JOIN departments 
ON students.department_id = departments.department_id
WHERE department_name ='Artificial Intelligence'; 


-- c. Count how many students are in each department.
select department_name, (count(student_id)) as students
from students join departments on students.department_id=departments.department_id
group by department_name;

-- d. List the courses taken by 'Alice Johnson'. (assuming Alice Johnson is a student)

SELECT  name, course_name
FROM students JOIN courses 
ON students.student_id = courses.student_id
where name='Alice Johnson';

-- e. Find students who are enrolled in more than one course.
SELECT  name, COUNT(course_id) as totalcourses
FROM students JOIN
    courses ON students.student_id = courses.student_id
GROUP BY name HAVING COUNT(course_name) > 1;

-- f. Get the average age of students in each department.
SELECT  department_name ,avg(age) as agerageage
FROM students JOIN departments 
ON students.department_id = departments.department_id
group by department_name;

-- g. Find the department with the most students.
SELECT department_name, COUNT(student_id) AS students
FROM students JOIN departments 
ON students.department_id = departments.department_id
GROUP BY department_name;

-- h. List all students who are NOT enrolled in any course.
SELECT  name, COUNT(course_id) as totalcourses
FROM students JOIN
    courses ON students.student_id = courses.student_id
GROUP BY name HAVING COUNT(course_name) = 0;

-- i. Retrieve students along with the total number of courses they are enrolled in.
SELECT  name, (course_id) as totalcourses
FROM students  JOIN courses ON students.student_id = courses.student_id;

-- j. Find students who belong to 'Computer Science' and are taking a course with 'Data' in its name.
SELECT name, department_name, course_name
FROM students JOIN departments 
ON students.department_id = departments.department_id
JOIN courses 
ON students.student_id = courses.student_id
WHERE department_name = 'Computer Science' AND course_name LIKE '%Data%';



