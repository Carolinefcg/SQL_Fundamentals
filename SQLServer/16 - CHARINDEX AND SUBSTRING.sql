

---- CHARINDEX AND SUBSTRING
DECLARE @name VARCHAR(100) = 'Caroline Ferreira'

-- searches for the space between First Name and Last Name
SELECT CHARINDEX(' ', @name) AS 'Space Index'

-- returns last name
SELECT SUBSTRING(@name, CHARINDEX(' ', @name)+1, 100) as 'Last Name'


-- returns first name
SELECT SUBSTRING(@name, 1, CHARINDEX(' ', @name)-1) as 'First Name'