/*
Assign employee number 110022 as a manager 
to all employees from 10001 to 10020, 
and employee number 110039 as a manager 
to all employees froom 10021 to 10040

Note that we have 2 subsets:
A: the new manager 110022
B: the new manager 110039
*/

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no LIKE '110022') AS manager_ID
    FROM
        employees AS e
    JOIN dept_emp AS de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no BETWEEN 10001 AND 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A
UNION
SELECT
B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no LIKE '110039') AS manager_ID
    FROM
        employees AS e
    JOIN dept_emp AS de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no  BETWEEN 10021 AND 10040
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B
