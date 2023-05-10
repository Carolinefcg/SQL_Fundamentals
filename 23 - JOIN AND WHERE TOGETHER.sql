/*
Select the first and last name, 
the hire date, and the job title 
of all employees whose first name 
is “Margareta” and have the last name “Markovitch”
*/

SELECT 
    e.first_name, e.last_name, e.hire_date, tits.title
FROM
    employees AS e
        JOIN
    titles AS tits on e.emp_no = tits.emp_no
WHERE
    e.first_name LIKE '%Margareta%'
        AND e.last_name LIKE '%Markovitch%';
        

