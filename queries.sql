-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create table of retiring employees
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

-- Joining departments and dept_manager table
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments AS d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01';

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO retiring_count_per_dept
FROM current_emp AS ce
LEFT JOIN dept_emp AS de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

-- Create table of retiring employees info
SELECT emp_no, 
	first_name, 
	last_name,
	gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM emp_info;

-- Create emp_info table with full name, gender, salary, to_date
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees AS e
INNER JOIN salaries AS s
ON e.emp_no = s.emp_no
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

DROP TABLE emp_info CASCADE;

-- Create managers list
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON dm.dept_no = d.dept_no
	INNER JOIN current_emp as ce
		ON dm.emp_no = ce.emp_no;

-- List of retirees updated
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp AS ce
	INNER JOIN dept_emp AS de
		ON ce.emp_no = de.emp_no
	INNER JOIN departments AS d
		ON de.dept_no = d.dept_no;

-- Create retirement_info list for sales team
SELECT ri.*, d.dept_name
INTO sales_info
FROM retirement_info as ri
	INNER JOIN dept_emp AS de
		ON ri.emp_no = de.emp_no
	INNER JOIN departments AS d
		ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- Create retirement_info list for sales and development team
SELECT ri.*, d.dept_name
INTO sales_dev_info
FROM retirement_info as ri
	INNER JOIN dept_emp AS de
		ON ri.emp_no = de.emp_no
	INNER JOIN departments AS d
		ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS ti
		ON e.emp_no = ti.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Retiring titles count
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Create a mentorship eligibility table
SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON e.emp_no = de.emp_no
	INNER JOIN titles AS ti
		ON e.emp_no = ti.emp_no
WHERE de.to_date = '9999-01-01'
AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibility;

SELECT COUNT(emp_no)
FROM mentorship_eligibility
WHERE title = 'Engineer';

-- Eligible mentors per title
SELECT COUNT(title), title
INTO mentorship_titles
FROM mentorship_eligibility
GROUP BY title
ORDER BY count DESC;

-- retirement count per department
SELECT DISTINCT ON (ut.emp_no) ut.*, d.dept_name
INTO unique_titles_depts
FROM unique_titles AS ut
	INNER JOIN dept_emp AS de
		ON ut.emp_no = de.emp_no
	INNER JOIN departments AS d
		ON de.dept_no = d.dept_no;

-- Retiring titles count per department
SELECT COUNT(dept_name), dept_name
INTO retiring_dept
FROM unique_titles_depts
GROUP BY dept_name
ORDER BY count DESC;

-- eligible  mentors with department
SELECT DISTINCT ON (me.emp_no) me.*, d.dept_name
INTO mentorship_eligibility_depts
FROM mentorship_eligibility AS me
	INNER JOIN dept_emp AS de
		ON me.emp_no = de.emp_no
	INNER JOIN departments AS d
		ON de.dept_no = d.dept_no;

-- eligible mentors per department
SELECT COUNT(dept_name), dept_name
INTO mentorship_depts
FROM mentorship_eligibility_depts
GROUP BY dept_name
ORDER BY count DESC;