

-- CHARINDEX AND SUBSTRING
DECLARE @name VARCHAR(100) = 'Caroline Ferreira'

-- searches for the space between First Name and Last Name
SELECT CHARINDEX(' ', @name) AS 'Space Index'

-- returns last name
SELECT SUBSTRING(@name, CHARINDEX(' ', @name)+1, 100) as 'Last Name'