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

use Exercicios

SELECT *, dbo.fnFirstName(Nome_Gerente)
FROM dGerente


/*EXERCISES*/

--1
GO
CREATE OR ALTER FUNCTION fnQ1(@startdate DATE, @enddate  DATE)
RETURNS INT
BEGIN
	IF @enddate IS NULL
		SET @enddate = GETDATE()
	DECLARE @empTime INT = DATEDIFF(YEAR, @startdate, @enddate)
	RETURN @empTime
END
GO

SELECT
	*,
	dbo.fnQ1(Data_de_Contratacao, NULL)
FROM
	dGerente

-- 2
USE ContosoRetailDW
-- 3
GO
CREATE OR ALTER FUNCTION fnQ3(@gender as VARCHAR(10))
RETURNS TABLE
BEGIN
	With result as (SELECT *
	FROM
	DimCustomer
	WHERE Gender = @gender)
	return result
END
GO
-- 4


