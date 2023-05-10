SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mark%');

SELECT 
    *
FROM
    employees
WHERE
hire_date LIKE ('%2000%');

SELECT 
    *
FROM
    employees
WHERE
emp_no LIKE ('1000_');

# The % is a substitute for a sequence os characters
# The _ helps you match a sigle character 