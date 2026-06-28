CREATE DATABASE company_db;
USE company_db;

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO Employee VALUES
(101,'Rahul','IT',50000,'2026-01-15'),
(102,'Amit','IT',60000,'2025-12-10'),
(103,'Priya','HR',55000,'2026-03-20'),
(104,'Sneha','Finance',70000,'2025-11-01'),
(105,'Rohit','IT',65000,'2026-04-10'),
(106,'Priya','HR',55000,'2026-03-20');

-- Query 1: Top 5 Highest Salary Employees
SELECT *
FROM Employee
ORDER BY salary DESC
LIMIT 5;

-- Query 2: Department Wise Employee Count
SELECT department, COUNT(*) AS employee_count
FROM Employee
GROUP BY department;

-- Query 3: Second Highest Salary
SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);

-- Query 4: Employees Whose Salary > Department Average Salary
SELECT emp_name, department, salary
FROM Employee e
WHERE salary >
(
    SELECT AVG(salary)
    FROM Employee
    WHERE department = e.department
);

-- Query 5: Inner Join (Self Join)
SELECT e1.emp_name, e2.department
FROM Employee e1
INNER JOIN Employee e2
ON e1.department = e2.department
AND e1.emp_id <> e2.emp_id;

-- Query 6: Left Join (Self Join)
SELECT e1.emp_name, e2.department
FROM Employee e1
LEFT JOIN Employee e2
ON e1.department = e2.department
AND e1.emp_id <> e2.emp_id;

-- Query 7: Group By with Having
SELECT department, COUNT(*) AS total_employees
FROM Employee
GROUP BY department
HAVING COUNT(*) > 2;

-- Query 8: Employees Hired in Last 6 Months
SELECT *
FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- Query 9: Find Duplicate Records
SELECT emp_name, COUNT(*) AS duplicate_count
FROM Employee
GROUP BY emp_name
HAVING COUNT(*) > 1;

-- Query 10: Remove Duplicate Records
DELETE e1
FROM Employee e1
JOIN Employee e2
ON e1.emp_name = e2.emp_name
AND e1.emp_id > e2.emp_id;