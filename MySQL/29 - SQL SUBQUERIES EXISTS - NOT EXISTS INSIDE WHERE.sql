/*
Select the entire information for all employees whose job title is “Assistant Engineer”. 

Hint: To solve this exercise, use the 'employees' table.
*/

# Example 1

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

# Example 2: Check if there is any category that is not present in products table

SELECT * FROM produtos;
SELECT * FROM categorias;

SELECT *
FROM categorias as c
WHERE NOT EXISTS (
				SELECT *
                FROM produtos as p
                WHERE c.ID_Categoria = p.ID_Categoria);