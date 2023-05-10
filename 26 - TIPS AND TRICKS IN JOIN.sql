/*
How many male and how many 
female managers do we have in 
the ‘employees’ database?
*/


SELECT 
    e.gender, COUNT(1) AS count
FROM
    titles AS dm
        JOIN
    employees AS e ON dm.emp_no = e.emp_no
WHERE
    dm.title LIKE '%Manager%'
GROUP BY gender;

