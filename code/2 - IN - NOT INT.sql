# EXEMPLE - IN
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');
# Use CTRL+B for beautify the code
# Use simple quotes 
# Use ; in the end of the code
# MySQL is not case sentive, unlike others SQL languages
# If you try Elvis and ELVIs, it will be the
# same result 
# EXAMPLE - NOT IN

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');