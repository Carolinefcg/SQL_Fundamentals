/*
Join the 'employees' and the 'dept_manager' 
tables to return a subset of all the employees 
whose last name is Markovitch. See if the output 
contains a manager with that name.  

Hint: Create an output containing information 
corresponding to the following fields: ‘emp_no’,
‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’.
 Order by 'dept_no' descending, and then by 'emp_no'.
*/


SELECT 
    dm.emp_no,
    dm.dept_no,
    dm.from_date,
    e.first_name,
    e.last_name
FROM
    employees AS e
        LEFT JOIN
    dept_manager AS dm ON e.emp_no = dm.emp_no
WHERE
    e.last_name LIKE '%Markovitch%'
ORDER BY dm.dept_no DESC, e.emp_no;




