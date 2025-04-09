-- Create a database

USE hr_analytics;

-- Employee table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    birth_date DATE,
    hire_date DATE,
    department_id INT,
    job_title VARCHAR(50),
    salary DECIMAL(10,2),
    performance_score INT
);

-- Department table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Attrition table
CREATE TABLE attrition (
    emp_id INT,
    attrition_date DATE,
    reason VARCHAR(100),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
-- Departments
INSERT INTO departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Sales'),
(4, 'Finance');

-- Employees
INSERT INTO employees VALUES
(101, 'Alice', 'Smith', 'Female', '1990-05-20', '2018-04-10', 1, 'HR Manager', 60000, 4),
(102, 'Bob', 'Johnson', 'Male', '1985-03-15', '2016-07-18', 2, 'Software Engineer', 80000, 3),
(103, 'Carol', 'Davis', 'Female', '1992-08-09', '2019-11-25', 3, 'Sales Executive', 50000, 2),
(104, 'David', 'Lee', 'Male', '1988-01-30', '2017-02-20', 4, 'Accountant', 55000, 5),
(105, 'Eva', 'Brown', 'Female', '1995-12-12', '2020-06-15', 2, 'Data Analyst', 70000, 4);

-- Attrition
INSERT INTO attrition VALUES
(103, '2022-01-10', 'Personal Reasons');
SELECT COUNT(*) AS total_employees FROM employees;
SELECT gender, COUNT(*) AS count
FROM employees
GROUP BY gender;
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;
SELECT 
    (SELECT COUNT(*) FROM attrition) * 100.0 / (SELECT COUNT(*) FROM employees) AS attrition_rate_percent;
SELECT emp_id, first_name, last_name, performance_score
FROM employees
WHERE performance_score >= 4;
SELECT 
    emp_id, 
    first_name, 
    last_name,
    ROUND(DATEDIFF(CURDATE(), hire_date) / 365.0, 1) AS tenure_years
FROM employees;

CREATE VIEW hr_dashboard AS
SELECT 
    e.emp_id,
    e.first_name,
    e.last_name,
    d.department_name,
    e.job_title,
    e.salary,
    e.performance_score,
    CASE 
        WHEN a.emp_id IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS has_left
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN attrition a ON e.emp_id = a.emp_id;
SELECT * FROM hr_dashboard;




