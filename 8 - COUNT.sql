SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000;



SELECT 
    COUNT(*) /* this COUNT will consider null values*/
FROM
    titles
    where title = 'Manager';
    
# or 

SELECT 
    COUNT(*)
FROM
    dept_manager;
    
########################

SELECT 
    COUNT(DISTINCT dept_no) AS departments
FROM
    dept_emp;