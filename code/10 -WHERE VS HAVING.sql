/*
If you're using an aggregate functionb such s COUNT(), SUM()
you must using HAVING istead of WHERE and follow de the order;
where is applied to ALL INDIVIDUALS in the table and 
acts as a filter
SELECT col_names(s)
from <schema>.<table>
where conditions
group by col_names(s)
HAVING  conditions
order by col_names(s);
*/


/*
FILTERING DATA

To filter data in where, always use the american date format
MySQL will only do correct operations such as 
Everyone younger than me 
where "age" > '2000-07-12'

american date format: 'AAAA-MM-DD'

*/
select emp_no, AVG(salary) AS media
from salaries
group by emp_no
having media>120000
order by salary;


# EXERCISE

SELECT 
    *, COUNT(emp_no) AS contract_signed
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(emp_no) > 1
ORDER BY COUNT(emp_no) DESC