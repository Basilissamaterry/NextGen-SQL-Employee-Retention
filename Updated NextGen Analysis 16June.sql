 1. Top 5 longest-serving employees
SELECT employee_id, first_name || ' ' || last_name AS full_name, hire_date,
       CURRENT_DATE - hire_date AS days_served
FROM employee
ORDER BY days_served DESC
LIMIT 5;

2. Turnover rate by department
SELECT department,
       COUNT(*) FILTER (WHERE status = 'Resigned') * 100.0 / COUNT(*) AS turnover_rate
FROM employee
GROUP BY department;

SELECT * FROM employee  LIMIT 5;

ALTER TABLE employee
ADD COLUMN status TEXT;

UPDATE employee
SET status = CASE
    WHEN employee_id IN (2, 4) THEN 'Resigned'
    ELSE 'Employed'
END;

SELECT department,
       COUNT(*) FILTER (WHERE status = 'Resigned') * 100.0 / COUNT(*) AS turnover_rate
FROM employee
GROUP BY department;


3. Employees at risk (performance below 3.5)
SELECT employee_id, first_name, last_name, department, performance_score
FROM employee
WHERE performance_score < 3.5;

ALTER TABLE employee
ADD COLUMN performance_score NUMERIC;

UPDATE employee
SET performance_score = CASE
    WHEN employee_id = 1 THEN 4.5
    WHEN employee_id = 2 THEN 2.9
    WHEN employee_id = 3 THEN 3.3
    WHEN employee_id = 4 THEN 5.0
END;

SELECT employee_id, first_name, last_name, department, performance_score
FROM employee
WHERE performance_score < 3.5;


4. Main reasons employees left
SELECT reason_for_leaving, COUNT(*) AS total
FROM employee
WHERE status = 'Resigned'
GROUP BY reason_for_leaving
ORDER BY total DESC;

ALTER TABLE employee
ADD COLUMN reason_for_leaving TEXT;

UPDATE employee
SET reason_for_leaving = CASE
    WHEN employee_id = 2 THEN 'Better offer'
    WHEN employee_id = 4 THEN 'Work-life balance'
    ELSE NULL
END;

SELECT reason_for_leaving, COUNT(*) AS total
FROM employee
WHERE status = 'Resigned'
GROUP BY reason_for_leaving;



  Performance Analysis
1. Number of employees who left
SELECT COUNT(*) AS total_left
FROM employee
WHERE status = 'Resigned';

2. Employees with score = 5.0 or < 3.5
SELECT COUNT(*) AS total_5_star
FROM employee
WHERE performance_score = 5.0;

SELECT COUNT(*) AS total_below_3_5
FROM employee
WHERE performance_score < 3.5;

3. Departments with most 5.0 and < 3.5 performers
SELECT department, COUNT(*) AS total_5_star
FROM employee
WHERE performance_score = 5.0
GROUP BY department
ORDER BY total_5_star DESC;

SELECT department, COUNT(*) AS total_below_3_5
FROM employee
WHERE performance_score < 3.5
GROUP BY department
ORDER BY total_below_3_5 DESC;

4. Average performance score by department
SELECT department, ROUND(AVG(performance_score), 2) AS avg_score
FROM employee
GROUP BY department;

  Salary Analysis

1. Total salary expense
SELECT SUM(salary) AS total_salary_expense
FROM employee;

2. Average salary by job title
SELECT job_title, ROUND(AVG(salary), 2) AS avg_salary
FROM employee
GROUP BY job_title;

ALTER TABLE employee
ADD COLUMN job_title TEXT;

SELECT job_title, ROUND(AVG(salary), 2) AS avg_salary
FROM employee
GROUP BY job_title;

UPDATE employee
SET job_title = CASE
    WHEN employee_id = 1 THEN 'HR Manager'
    WHEN employee_id = 2 THEN 'Finance Analyst'
    WHEN employee_id = 3 THEN 'IT Support'
    WHEN employee_id = 4 THEN 'Finance Analyst'
END;

SELECT job_title, ROUND(AVG(salary), 2) AS avg_salary
FROM employee
GROUP BY job_title;


3. Employees earning above 80,000
SELECT COUNT(*) AS high_earners
FROM employee
WHERE salary > 80000;

4. Performance vs salary by department
SELECT department, ROUND(AVG(salary), 2) AS avg_salary,
       ROUND(AVG(performance_score), 2) AS avg_performance
FROM employee
GROUP BY department;
