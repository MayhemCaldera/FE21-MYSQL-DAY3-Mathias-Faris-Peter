-- Excercises Day 3 

-- Report No. 1
SELECT COUNT( emp_no ) FROM employees

-- Result

-- COUNT( emp_no )
-- 300024


-- Report No. 2
SELECT COUNT(emp_no) 
FROM employees 
WHERE first_name='Mark'
-- Result
-- COUNT( emp_no )
-- 230

-- Report No. 3
SELECT first_name, last_name FROM employees WHERE first_name='Eric' AND last_name LIKE ('A%')

-- Result:
-- Showing rows 0 - 12 (13 total, Query took 0.1688 seconds.)


-- Report No. 4
-- version 1 using IN for the count only
SELECT
COUNT(emp_no),
CONCAT (first_name,' ',last_name) as employee_since_1985
FROM employees
WHERE emp_no IN(
    	SELECT emp_no
    	WHERE hire_date BETWEEN '1985-01-01' AND '1985-12-31'
    )
-- version 2 need 2 querries to define the names as well as the count

-- Remark: trainers solution they use hire_date > "1985-01-01" which i dont think it is correct interpretation of the question, we need to find employees that were employed in 1985 and NOT in 1986 and later years
SELECT
COUNT(emp_no)
FROM employees
WHERE  hire_date BETWEEN '1985-01-01' AND '1985-12-31';

SELECT
first_name as First_name,
last_name as employee_since_1985
FROM employees
WHERE  hire_date BETWEEN '1985-01-01' AND '1985-12-31';
-- Result:

-- COUNT(emp_no)
-- employee_since_1985
-- 35316
-- Bezalel Simmel

-- Report No. 5
SELECT
COUNT(emp_no)
FROM employees
WHERE  hire_date BETWEEN '1990-01-01' AND '1997-12-31';

SELECT
CONCAT (first_name,' ',last_name) as employee_since_1985
FROM employees
WHERE  hire_date BETWEEN '1990-01-01' AND '1997-12-31'

-- Result

-- COUNT(emp_no)
-- employee_since_1985
-- 129545
-- Saniya Kalloufi


-- Report No. 6

-- version 1
SELECT
COUNT(emp_no),
last_name as employee_salary_above70k
FROM employees
WHERE employees.emp_no IN (
			SELECT salaries.emp_no from salaries 
    		WHERE salaries.salary > '70000'
		)

-- version 2
SELECT
COUNT(employees.emp_no),
last_name as employee_salary_above70k
FROM employees
INNER JOIN salaries ON salaries.emp_no=employees.emp_no
WHERE salary > '70000'

-- COUNT(employees.emp_no)
-- employee_salary_above70k
-- 216942
-- Facello


-- Report No. 7

-- version 1 
SELECT
count(employees.emp_no)
FROM employees
JOIN dept_emp ON dept_emp.emp_no=employees.emp_no 
JOIN departments ON departments.dept_no=dept_emp.dept_no
WHERE departments.dept_name='Research' AND  
 employees.hire_date BETWEEN '1992-01-01' AND CURRENT_DATE() AND 
 dept_emp.to_date > CURRENT_DATE;

-- Remark 1: we missed adding the last condition which is to_date column to 
-- make make sure the employee is still with us, (see the table dept_emp) 

--  Remark 2: the trainers soluntion is only hire_date > '1992-01-01', but that would mean an employee that was hired in 1995 is also included, but that should not be the case, the difference in the result for us is 2 persons
 
SELECT
first_name, last_name
FROM employees
JOIN dept_emp ON dept_emp.emp_no=employees.emp_no 
JOIN departments ON departments.dept_no=dept_emp.dept_no
WHERE departments.dept_name='Research' AND  
employees.hire_date BETWEEN '1992-01-01' AND CURRENT_DATE() AND 
 dept_emp.to_date > CURRENT_DATE;

-- Uncompleted version using sub-querries -----------------------
SELECT
count(dept_emp.emp_no)
FROM dept_emp
WHERE dept_emp.dept_no=
(SELECT 
departments.dept_no
FROM departments 
 JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
 JOIN employees ON dept_emp.emp_no=employees.emp_no
WHERE departments.dept_name='Research' AND  
 employees.hire_date BETWEEN '1992-01-01' AND CURRENT_DATE()
)

-- result: 
-- count(employees.emp_no)
-- 6145


-- Report No. 8
SELECT
count(employees.emp_no)
FROM employees
JOIN dept_emp ON dept_emp.emp_no=employees.emp_no 
JOIN departments ON departments.dept_no=dept_emp.dept_no
JOIN salaries ON salaries.emp_no=employees.emp_no
WHERE departments.dept_name='Finance' AND  
employees.hire_date BETWEEN '1985-01-01' AND CURRENT_DATE() AND salaries.salary > '75000' AND dept_emp.to_date > CURRENT_DATE
GROUP BY fullName;
 
-- Remark 1: we missed adding the last condition which is to_date column to 
-- make make sure the employee is currently with us as an employee, (see the table dept_emp) 

SELECT
CONCAT (first_name,' ',last_name) as fullName
FROM employees
JOIN dept_emp ON dept_emp.emp_no=employees.emp_no 
JOIN departments ON departments.dept_no=dept_emp.dept_no
JOIN salaries ON salaries.emp_no=employees.emp_no
WHERE departments.dept_name='Finance' AND  
employees.hire_date BETWEEN '1985-01-01' AND CURRENT_DATE() AND salaries.salary > '75000'  AND dept_emp.to_date > CURRENT_DATE
GROUP BY fullName;


-- result: 

-- count(employees.emp_no)
-- 15456

-- Report No. 9
-- We need a table with employees, who are working for us at this moment (to_date) <--(salaries): first and last name, date of birth, gender, hire_date,<--(employees) title (titles)and salary (salaries).
SELECT
first_name as 'First Name',
last_name as 'Last Name',
birth_date as 'Date of Birth',
gender,
hire_date as  'Date Hired',
title,
salary
FROM employees
JOIN titles ON employees.emp_no=titles.emp_no
JOIN salaries ON employees.emp_no=salaries.emp_no
WHERE salaries.to_date > CURRENT_DATE()
GROUP BY employees.emp_no;


-- Remark: group by column choice  made a difference in the number of records being shown, when you change column name of group by then you get a different result for example when using employees.first_name.

-- Report No. 10
-- We need a table with managers, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title, department name and salary.
SELECT
first_name as 'First Name',
last_name as 'Last Name',
birth_date as 'Date of Birth',
gender,
hire_date as  'Date Hired',
title,
salary,
FROM employees
JOIN titles ON employees.emp_no=titles.emp_no
JOIN salaries ON employees.emp_no=salaries.emp_no
WHERE salaries.to_date > CURRENT_DATE() AND
dept_manager.to_date > CURRENT_DATE()

GROUP BY employees.emp_no;


-- Bonus Report

