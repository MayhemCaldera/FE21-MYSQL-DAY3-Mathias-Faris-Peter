/* 1. Report:

 How many rows do we have in each table in the employees database?*/
SELECT table_name, table_rows
   FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_SCHEMA = 'employees';

/*2. Report:

How many employees with the first name "Mark" do we have in our company?*/

SELECT COUNT(first_name) FROM employees WHERE employees.first_name = "Mark";

/*3. Report:

How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company?*/

SELECT COUNT(*) FROM employees WHERE employees.first_name = "Eric" AND employees.last_name LIKE "A%";

 /*4. Report:

 How many employees do we have that are working for us since 1985 and who are they?*/
SELECT COUNT(employees.emp_no) FROM employees WHERE employees.hire_date > "1985-01-01";

SELECT first_name,last_name,hire_date FROM employees WHERE employees.hire_date > "1985-01-01" 

/*5. Report:

 How many employees got hired from 1990 until 1997 and who are they?*/

SELECT COUNT(employees.emp_no) FROM employees WHERE employees.hire_date BETWEEN "1990-01-01" AND "1997-12-31"; 

SELECT first_name,last_name,hire_date FROM employees WHERE employees.hire_date BETWEEN "1990-01-01" AND "1997-12-31"; 

 /*6. Report:

 How many employees have salaries higher than EUR 70 000,00 and who are they? */

SELECT COUNT(salary) FROM salaries WHERE salaries.salary >70000;

SELECT DISTINCT employees.first_name, employees.last_name
FROM employees 
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE salaries.salary>70000;

 /*7. Report:

 How many employees do we have in the Research Department, who are working for us since 1992 and who are they?*/

SELECT COUNT(employees.emp_no)
FROM employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE employees.hire_date > "1992-01-01" AND departments.dept_no="d008" AND dept_emp.to_date > CURRENT_DATE(); 

SELECT employees.first_name,employees.last_name,employees.hire_date 
FROM employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE employees.hire_date > "1992-01-01" AND departments.dept_no="d008" AND dept_emp.to_date > CURRENT_DATE()
ORDER BY employees.hire_date; 

 /*8. Report:

 How many employees do we have in the Finance Department, who are working for us since 1985 until now and who have salaries higher than EUR 75 000,00 - who are they?*/

SELECT COUNT(employees.emp_no)
FROM employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE employees.hire_date > "1985-01-01" AND departments.dept_no="d002" AND salaries.salary > 75000;

SELECT employees.emp_no,employees.first_name,employees.last_name,employees.hire_date,departments.dept_name,salaries.salary
FROM employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE employees.hire_date > "1985-01-01" AND departments.dept_no="d002" AND salaries.salary > 75000
group by employees.emp_no

 /*9. Report:

 We need a table with employees, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title and salary.*/

SELECT employees.emp_no,employees.first_name,employees.last_name,employees.birth_date,employees.gender,employees.hire_date,titles.title,salaries.salary
FROM employees
INNER JOIN titles ON titles.emp_no = employees.emp_no
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE salaries.to_date > CURRENT_DATE()
group by employees.emp_no

 /*10. Report:

 We need a table with managers, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title, department name and salary.*/

SELECT employees.emp_no,employees.first_name,employees.last_name,employees.birth_date,employees.gender,employees.hire_date,titles.title,departments.dept_name,salaries.salary
FROM employees
INNER JOIN titles ON titles.emp_no = employees.emp_no
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
INNER JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE salaries.to_date > CURRENT_DATE()
AND dept_manager.to_date > CURRENT_DATE()
group by employees.emp_no

/*Bonus query:

  Create a query which will join all tables and show all data from all tables.
 */
SELECT employees.*,titles.*,salaries.*,dept_emp.*,departments.*,dept_manager.*
FROM employees
INNER JOIN titles ON titles.emp_no = employees.emp_no
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
INNER JOIN dept_manager ON dept_manager.dept_no = departments.dept_no;