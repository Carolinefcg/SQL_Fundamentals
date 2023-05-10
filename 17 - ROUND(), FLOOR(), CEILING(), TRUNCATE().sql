/*
Round the average amount of money 
spent on salaries for all contracts 
that started after the 1st of January 
1997 to a precision of cents.
*/
/*
If you use ROUND(#) without specifying
the number of digits, it'll round
to the closest integer */
SELECT 
    ROUND(AVG(salary), 2) AS avg_salary
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
    
SELECT
	ROUND(1207.20019, 3) 	AS 'ROUND',
    floor(1207.20019, 3) 	AS 'FLOOR',
    ceiling(1207.20019, 3) 	AS 'CEILING',
    TRUNCATE(1207.20019, 3) AS 'TRUNCATE';
    