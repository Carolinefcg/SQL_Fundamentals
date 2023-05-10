# the wildcard characters are
# *
# %
# _

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%Jack%');
    
    
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Jack%');