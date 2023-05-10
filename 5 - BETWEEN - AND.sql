# The structure BETWEEN ... AND can que applied for
# dates
# strings
# numbers
# And, at least at MySQL, it will include de first and last values 
# in the interval, like a [a, b] closed interval

SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;
    
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';


SELECT 
    *
FROM
    employees.departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';