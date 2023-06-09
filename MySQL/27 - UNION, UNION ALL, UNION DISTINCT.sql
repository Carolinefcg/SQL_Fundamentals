/*
Select all managers’ first and 
last name, hire date, job title, 
start date, and department name.
*/

SELECT
    dm.from_date as date_
FROM
    employees.dept_manager AS dm
UNION
SELECT
    e.birth_date as date_
FROM
    employees.employees AS e
group by date_;


SELECT
    dm.from_date as date_
FROM
    employees.dept_manager AS dm
UNION ALL
SELECT
    e.birth_date as date_
FROM
    employees.employees AS e
group by date_;


SELECT
    dm.from_date as date_
FROM
    employees.dept_manager AS dm
UNION DISTINCT
SELECT
    e.birth_date as date_
FROM
    employees.employees AS e
group by date_;