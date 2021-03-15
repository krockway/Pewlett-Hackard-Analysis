--Deliverable 1: The Number of Retiring Employees by Title

-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
-- Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT e.emp_no,
    e.first_name,
    e.last_name,
	t.title,
    t.from_date,
    t.to_date
-- Create a new table using the INTO clause.
INTO retire_title_count
FROM employees as e
-- Join both tables on the primary key.
JOIN titles as t
ON (e.emp_no = t.emp_no)
-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

-- Use Dictinct with Orderby to remove duplicate rows from above table
SELECT DISTINCT ON (rtc.emp_no) rtc.emp_no,
    rtc.first_name,
    rtc.last_name,
	rtc.title,
    rtc.from_date,
    rtc.to_date
INTO retire_title_unique
FROM retire_title_count as rtc
ORDER BY rtc.emp_no ASC, to_date DESC;
	
-- Count the # of employees 
SELECT COUNT(title), title
INTO retiring_titles
FROM retire_title_unique 
GROUP BY title
ORDER BY count DESC

-- Deliverable 2: The Employees Eligible for the Mentorship Program
-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- Retrieve the from_date and to_date columns from the Department Employee table.
-- Retrieve the title column from the Titles table.
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
	de.from_date,
	de.to_date,
	t.title
-- Create a new table using the INTO clause.
INTO metorship_eligibility
FROM employees as e
-- Join the Employees and the Department Employee tables on the primary key.
JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
-- Join the Employees and the Titles tables on the primary key.
JOIN titles as t
ON (e.emp_no = t.emp_no)
-- Filter the data on the to_date column to get current employees whose birth dates are between January 1, 1965 and December 31, 1965.
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
-- Order the table by the employee number.
ORDER BY e.emp_no ASC