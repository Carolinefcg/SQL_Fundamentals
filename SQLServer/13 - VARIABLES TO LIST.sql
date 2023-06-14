
SET NOCOUNT ON

DECLARE @namesList VARCHAR(199)
SET @namesList = '' -- initialize the variable

SELECT
	@namesList = @namesList + FirstName + ', ' + CHAR(10)
				-- append variable + Object + delimitator + break line (optional)
FROM DimEmployee
WHERE DepartmentName = 'Marketing' and Gender = 'F';

PRINT @namesList;

-- Removes last delimitator
SET @namesList = LEFT(@namesList, DATALENGTH(@namesList)-3)
PRINT CONCAT('Removing last delimitator', CHAR(10), @namesList);