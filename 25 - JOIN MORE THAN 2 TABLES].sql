/*
Select all managers’ first and 
last name, hire date, job title, 
start date, and department name.
*/

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    dept_manager AS dm
        JOIN
    employees AS e on dm.emp_no = e.emp_no
        JOIN
    titles AS t on e.emp_no = t.emp_no
        JOIN
    departments AS d on dm.dept_no = d.dept_no
    where t.title = 'Manager'
    order by e.emp_no;