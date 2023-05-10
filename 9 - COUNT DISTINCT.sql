SELECT 
    COUNT(emp_no)
FROM
    salaries
WHERE
    salary >= 100000;

########################


SELECT 
    *, COUNT(emp_no)
FROM
    titles
    where title = 'Manager';