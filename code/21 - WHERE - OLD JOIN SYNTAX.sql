/*
Extract a list containing information
about all managers’ employee number,
first and last name, department number, 
and hire date. Use the old type of join 
syntax to obtain the result.*/

# WHERE - JOIN BUMMER WAY

SELECT 
    dm.dept_no,
    dm.emp_no,
    e.first_name,
    e.last_name,
    e.hire_date
FROM
    dept_manager AS dm,
    employees AS e
WHERE
	e.emp_no = dm.emp_no; /*(order!!)*/
/*
REMEMBER: THE ORDER MATTERS!
*/