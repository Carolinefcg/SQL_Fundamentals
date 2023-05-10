/*
INNER JOIN = connects only values that match

CROSS JOIN = return all values even the ones that don't match
*/

/*
Use a CROSS JOIN to return a 
list with all possible combinations 
between managers from the dept_manager 
table and department number 9.
*/
 /*
SELECT 
    dm.emp_no, dp.dept_no, dp.dept_name
FROM
    dept_manager AS dm
        CROSS JOIN
    departments AS dp
WHERE
    dp.dept_no = 'd009';
*/


/*
Return a list with the first 10 employees with all the departments they can be assigned to.

Hint: Don’t use LIMIT; use a WHERE clause. 
*/

select
e.*,
d.dept_no
#,count(1)
from
employees as e
cross join
departments as d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name; 

/*
Remeber that we are selecting the first 10 employees
each employee can be assigned to 9 departments
hence, we have 90 rows as a output
*/