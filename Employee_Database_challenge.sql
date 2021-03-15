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

