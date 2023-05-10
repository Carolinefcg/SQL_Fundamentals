/*
Extract the information about 
all department managers who were 
hired between the 1st of January 
1990 and the 1st of January 1995.
*/

SELECT 
    e.*
FROM
    employees AS e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager AS dm)
        AND e.hire_date BETWEEN '1990-01-01' AND '1995-01-01';