SELECT 
    *
FROM
    employees.salaries
GROUP BY salary
ORDER BY salary DESC
LIMIT 10;

/*
If you would like to skip the first 5 lines, use OFFSET
*/
SELECT 
    *
FROM
    employees.salaries
GROUP BY salary
ORDER BY salary DESC
LIMIT 10
OFFSET 10;
