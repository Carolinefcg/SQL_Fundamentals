GO
CREATE OR ALTER FUNCTION fnFirstName(@fullName as VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @spacePosition AS INT
	DECLARE @result as VARCHAR(MAX)

	SET @spacePosition = CHARINDEX(' ', @fullName)
	IF @spacePosition = 0
		SET @result = @fullName
	ELSE
		SET @result = LEFT(@fullName, @spacePosition -1)
	RETURN @result
END
GO

SELECT 
fn,*
FROM dGerente
