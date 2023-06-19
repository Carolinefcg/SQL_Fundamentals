

-- SEPARATE INFO FROM DATE TYPE
--- DAY, MONTH, YEAR

DECLARE @date DATE = '07-12-2001'

SELECT 
	DAY(@date) AS 'DAY',
	MONTH(@date) AS 'MONTH',
	YEAR(@date) AS 'YEAR'


-- UNION INFO FROM DATE TYPE
--- DATEFROMPARTS

DECLARE @day INT = '04', @month INT = '08', @year INT = '2014'

SELECT
	DATEFROMPARTS(@year,@month,@day)

-- GETDATE 
SELECT GETDATE()
-- SYSDATETIME
SELECT SYSDATETIME() -- MORE PRECISE

DECLARE @TDATE DATE = GETDATE()

-- DATENAME: RETURNS DATA INFO AS TEXT
SELECT
	DATENAME(DAY, @TDATE) AS 'DAY',
	DATENAME(MONTH, @TDATE) AS 'MONTH',
	DATENAME(YEAR, @TDATE) AS 'YEAR',
	DATENAME(DAYOFYEAR, @TDATE) AS 'DAYOFYEAR'

SELECT SQL_VARIANT_PROPERTY(DATENAME(DAY, @TDATE), 'BaseType') AS 'DATENAME_TYPE'

-- DATENAME: RETURNS DATA INFO AS INT
SELECT
	DATEPART(DAY, @TDATE) AS 'DAY',
	DATEPART(MONTH, @TDATE) AS 'MONTH',
	DATEPART(YEAR, @TDATE) AS 'YEAR',
	DATEPART(DAYOFYEAR, @TDATE) AS 'DAYOFYEAR';

SELECT SQL_VARIANT_PROPERTY(DATEPART(DAY, @TDATE), 'BaseType') AS 'DATEPART_TYPE';

-- DATEADD

DECLARE @DATE1 DATE = '2001-07-12',
		@DATE2 DATE = '2014-08-04'

SELECT DATEADD(YEAR, 22, @DATE1)

-- DATEDIFF

SELECT DATEDIFF(YEAR, @DATE1, @DATE2)

SELECT DATEDIFF(YEAR, @DATE2, @DATE1)

-- EXERCISES

-- 1 A)
SELECT
	ProductName,
	DATALENGTH(ProductName) AS 'DATALENGTH(ProductName)'
FROM
	DimProduct
ORDER BY DATALENGTH(ProductName) DESC;

-- 1 B)
SELECT
	AVG(DATALENGTH(ProductName)) AS 'AVG(DATALENGTH(ProductName))'
FROM
	DimProduct

-- 1 C) E D)
SELECT
	ProductName,
	TRIM(STUFF(ProductName, CHARINDEX(ColorName, ProductName)-5 , 100, '')) AS 'shorted',
	DATALENGTH(ProductName) AS 'DATALENGTH(ProductName)',
	DATALENGTH(TRIM(STUFF(ProductName, CHARINDEX(ColorName, ProductName)-5 , 100, ''))) AS 'shorted_LENGTH'
FROM
	DimProduct  
ORDER BY DATALENGTH(ProductName) DESC;

-- 2
SELECT
	StyleName, 
	TRANSLATE(StyleName, '0123456789', 'ABCDEFGHIJ') AS 'TRANSLATE'
FROM
	DimProduct

-- 3
SELECT
	CONCAT(FirstName, LastName) AS 'FULL NAME',
	EmailAddress,
	SUBSTRING(EmailAddress, 1, CHARINDEX('@', EmailAddress)-1) as 'EMAIL_ID',
	CONCAT(UPPER(FirstName), DATENAME(DAYOFYEAR, BirthDate)) as 'PASSWORD'
FROM
	DimEmployee

-- 4
SELECT
	FirstName,
	EmailAddress,
	AddressLine1,
	DateFirstPurchase
FROM	
	DimCustomer
WHERE DATEPART(YEAR, DateFirstPurchase) = 2001;

-- 5
SELECT
	FirstName,
	EmailAddress,
	HireDate,
	DAY(HireDate) AS 'DAY(HireDate)' ,
	FORMAT(HireDate, 'MMMMM') AS 'MONTH(HireDate)',
	YEAR(HireDate) AS 'YEAR(HireDate)' 
FROM
	DimEmployee;

-- 6
DECLARE @TODAYSDATE DATE = GETDATE()

SELECT TOP(1)
	DATEDIFF(DAYOFYEAR, OpenDate, @TODAYSDATE),
	*
FROM
	DimStore
WHERE CloseDate IS NULL
ORDER BY DATEDIFF(DAYOFYEAR, OpenDate, @TODAYSDATE) DESC