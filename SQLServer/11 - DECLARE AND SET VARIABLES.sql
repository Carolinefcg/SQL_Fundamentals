
DECLARE @PRICE FLOAT
DECLARE @NAME VARCHAR(30)
DECLARE @DATE DATETIME


SET @PRICE = 99.99
SET @NAME = 'CFCG'
SET @DATE = '2001-07-12'

SELECT @PRICE as 'PRICE'
SELECT @NAME as 'NAME'
SELECT @DATE as 'DATE'

-- EXAMPLES WITH DB

DECLARE @discount_price FLOAT
DECLARE @DP_NAME VARCHAR(30)

SET @discount_price = 0.9
SET @DP_NAME = CONCAT(CAST(@discount_price AS VARCHAR),'_OFF_UnitPrice')
--SELECT @discount_price AS 'T'
--SELECT @DP_NAME AS 'NAME'
--SELECT @discount_price AS @DP_NAME 
--SELECT CONCAT(CAST(@discount_price AS VARCHAR),'_OFF_UnitPrice') AS 'FLOAT-TO-VARCHAR'

SELECT
	ProductKey,
	ProductName,
	UnitPrice
	,UnitPrice*@discount_price AS 'Discount'--CONCAT(CAST(@discount_price AS VARCHAR),'_OFF_UnitPrice')
FROM
	DimProduct;

-- Example pt2

DECLARE @BDAY DATE
SET @BDAY = '07-01-1970'

SELECT
	BirthDate
FROM	
	DimCustomer
WHERE BirthDate>= @BDAY

-- Example pt3
DECLARE @STORES_OFF INT
SET @STORES_OFF = (
					SELECT
						COUNT(StoreKey)
					FROM
						DimStore
					WHERE Status = 'Off'
					)
SELECT @STORES_OFF AS 'STORES_OFF'


-- SET WITHOUT SET STATEMENT

DECLARE @prdkey INT, @prdName VARCHAR(100)

SELECT TOP(1)
	@prdkey = ProductKey,
	@prdName = ProductName
FROM	
	DimProduct
ORDER BY UnitPrice DESC;

-- Applying that

SELECT
	ProductKey,
	ProductName,
	UnitPrice,
	ProductLabel,
	ProductDescription
FROM	
	DimProduct
WHERE @prdkey = ProductKey;


-- GLOBAL VARIBLES

SELECT * FROM DimEmployee
SELECT @@ROWCOUNT AS 'ROWCOUNT' -- GLOBAL VARIABLE