
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

-- EXERCISES

-- 1
DECLARE @v1 FLOAT = 10, @v2 FLOAT= 5, @v3 FLOAT= 34, @v4 FLOAT= 7

DECLARE @soma INT = @v1 + @v2,
		@sub INT =  @v3 - @v4, 
		@mult INT = @v1 * @v4, 
		@div FLOAT= @v3/@v4

SELECT  @soma, @sub, @mult, ROUND(@div, 2);

-- 2
DECLARE @produto VARCHAR(30), @qtd INT, @preco DECIMAL(10,2),@fat DECIMAL(10,2)
SET @produto = 'Celular'
SET @qtd = 12
SET @preco = 9.99
SET @fat = @qtd*@preco

SELECT @produto, @qtd, @preco,@fat

-- 3
DECLARE @nome VARCHAR(30) = 'André',
		@dn DATE = '1998-02-10',
		@pets INT = 2

SELECT CONCAT('Meu nome é ', @nome, ', nasci em ', FORMAT(@dn, 'dd/MM/yyyy'), ' e tenho ', @pets, ' pets.')

-- 4
DECLARE @lojas2008 VARCHAR(100) = ''
SELECT
	@lojas2008 = @lojas2008 + StoreName + ', '
FROM 
	DimStore
WHERE FORMAT(CloseDate, 'yyyy') = '2008'

SET @lojas2008 = LEFT(@lojas2008, DATALENGTH(@lojas2008)-2)
PRINT 'Closed stores in 2008: ' + @lojas2008;

-- 5
DECLARE @lampsKey INT, @lamps VARCHAR(999) 
SET @lamps = ''

SELECT 
	@lampsKey =  ProductSubcategoryKey
FROM 
	DimProductSubcategory
WHERE ProductSubcategoryName = 'Lamps';

SELECT
	@lamps = @lamps + CAST(ProductKey AS VARCHAR(10)) + ','
FROM
	DimProduct
WHERE ProductSubcategoryKey = @lampsKey;

SET @lamps = LEFT(@lamps, DATALENGTH(@lamps)-3)
PRINT 'LAMPS: ' + CHAR(10)+ @lamps


SELECT
	DISTINCT ProductKey
FROM
	DimProduct
WHERE ProductSubcategoryKey = @lampsKey;