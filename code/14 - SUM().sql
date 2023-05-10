/*What is the total amount of money 
spent on salaries for all contracts 
starting after the 1st of January 1997?*/

SELECT 
	SUM(salary) AS salary_sum
FROM
    salaries
WHERE
    from_date > '1997-01-01';