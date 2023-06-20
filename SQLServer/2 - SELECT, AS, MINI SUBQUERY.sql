-- 1 a)
SELECT COUNT(*) AS 'Qtd' FROM DimProduct; -- 2.517

-- 1 b)
SELECT COUNT(*) AS 'Qtd' FROM DimCustomer; -- 18.859

-- 2 a) e b)
SELECT 
	CustomerKey AS 'ID',
	FirstName AS 'NOME',
	EmailAddress AS 'EMAIL',
	BirthDate AS 'BDAY'
from DimCustomer;

-- 3 a)
select TOP(100) *
from DimCustomer
WHERE DateFirstPurchase IS NOT NULL
ORDER BY DateFirstPurchase;

-- 3 b)
select TOP(10) PERCENT *
from DimCustomer
WHERE DateFirstPurchase IS NOT NULL
ORDER BY DateFirstPurchase;

-- 3 c)
select TOP(100) 
	FirstName,
	EmailAddress,
	BirthDate
from DimCustomer
WHERE DateFirstPurchase IS NOT NULL
ORDER BY DateFirstPurchase;

-- 3 d)

select TOP(100) 
	FirstName AS 'Nome',
	EmailAddress AS 'Email',
	BirthDate AS 'NIVER'
from DimCustomer
WHERE DateFirstPurchase IS NOT NULL
ORDER BY DateFirstPurchase;

-- 4 
SELECT 
	DISTINCT Manufacturer AS 'Fornecedores'
FROM DimProduct;

-- 5


SELECT ProductKey FROM DimProduct
WHERE ProductKey NOT IN (SELECT ProductKey FROM FactSales);


-- USING CURRENT ALIAS AS COLUMN

SELECT 
ProductKey AS 'Product_ID',
COUNT(ProductKey) AS 'QTD' 
FROM ContosoRetailDW.dbo.DimProduct
GROUP BY ProductKey
ORDER BY [QTD];
