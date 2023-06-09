/*
Extract a list containing information about 
all managers’ employee number, first and last name, 
department number, and hire date. */

/* STRUCTURE
SELECT 
	table1.column_name(s), table2.column_name(s)
FROM
	table1
JOIN
	table2 ON table1.column_name(s) = table2.column_name(s);
*/

SELECT 
    dept_manager_dup.emp_no,
    #employees.emp_no,
    employees.first_name,
    employees.last_name,
    dept_manager_dup.dept_no,
    employees.hire_date
FROM
    dept_manager_dup
        JOIN
    employees ON dept_manager_dup.emp_no = employees.emp_no;
    
    
# COOLEST WAY =)

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM
    dept_manager_dup dm
        JOIN
    employees e ON dm.emp_no = e.emp_no;
    
/*	once you use aliases, ALWAYS use them when calling the table
	do not use AS */