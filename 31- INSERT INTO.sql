
/*
Fill emp_manager with data about employees, (SEE IN  0 - DRAFT) 
the number of the department they are working in, 
and their managers.

Your query skeleton must be:

	Insert INTO emp_manager SELECT

	U.*

	FROM

					 (A)

	UNION (B) UNION (C) UNION (D) AS U;

A and B should be the same subsets used in 
the last lecture (SQL Subqueries Nested in 
SELECT and FROM). In other words, assign 
employee number 110022 as a manager to all 
employees from 10001 to 10020 (this must be subset A), 
and employee number 110039 as a manager to all employees 
from 10021 to 10040 (this must be subset B).

Use the structure of subset A to create subset C, 
where you must assign employee number 110039 as a 
manager to employee 110022.

Following the same logic, create subset D. Here you 
must do the opposite - assign employee 110022 as a 
manager to employee 110039.

Your output must contain 42 rows.

Good luck!
*/

/*
Fill emp_manager with data about employees, (SEE IN  0 - DRAFT) 
the number of the department they are working in, 
and their managers.
*/

SELECT
(select
emp_no
from
dept_manager) as A

Insert INTO emp_manager SELECT
U.*
FROM
                 (A)

UNION (B) UNION (C) UNION (D) AS U;