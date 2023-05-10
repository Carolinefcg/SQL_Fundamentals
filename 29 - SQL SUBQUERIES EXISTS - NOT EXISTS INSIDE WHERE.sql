/*
Select the entire information for all employees whose job title is “Assistant Engineer”. 

Hint: To solve this exercise, use the 'employees' table.
*/

SELECT
e.*
FROM
employees as e
where  EXISTS (SELECT
t.title 
FROM
titles as t
where 
e.emp_no = t.emp_no and t.title like '%Assistant Engineer%')
order by e.emp_no;
