SELECT 
    first_name, last_name
FROM
    employees;
    
SELECT 
    *
FROM
    employees;
    
/* EXERCICIO */

SELECT 
    dept_no
FROM
    departments;
    
SELECT 
    *
FROM
    departments;
    
/* WHERE*/

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';
    
/* AND */

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F';

/* OR */

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' OR first_name = 'Aruna';


/*PARENTESES QUE SALVAM*/

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F' AND(first_name = 'Kellie' OR first_name = 'Aruna');

