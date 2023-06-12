
-- 1
SELECT 
	SUM(SalesQuantity) AS 'Soma_Qtd_Vendida',
	SUM(ReturnQuantity)AS 'Soma_Qtd_Devolvida',
	AVG(SalesQuantity) AS 'AVG_Qtd_Vendida',
	AVG(ReturnQuantity) AS 'AVG_Qtd_Devolvida',
	MAX(SalesQuantity) AS 'MAX_Qtd_Vendida',
	MAX(ReturnQuantity) AS 'MAX_Qtd_Devolvida',
	MIN(SalesQuantity) AS 'MIN_Qtd_Vendida',
	MIN(ReturnQuantity)AS 'MIN_Qtd_Devolvida'
FROM FactSales;

-- 2
SELECT 
	AVG(YearlyIncome) as 'Media salarial anual'
FROM DimCustomer
WHERE Occupation = 'Professional';

-- 3 A) E B)
select 
	TOP(1) StoreName,
	MAX(EmployeeCount) as 'max'
from DimStore
group by StoreName
ORDER BY MAX(EmployeeCount) DESC;

-- 3 C) E D)
SELECT
	TOP(1) StoreName,
	MIN(EmployeeCount) AS 'MIN'
FROM DimStore
WHERE EmployeeCount IS NOT NULL
GROUP BY StoreName
ORDER BY MIN(EmployeeCount) ASC;

-- 4 A)
SELECT 
	Gender,
	COUNT(Gender) AS 'QTD'
FROM DimEmployee
GROUP BY Gender;

SELECT
	COUNT(Gender) AS 'QTD MASC'
FROM DimEmployee
WHERE Gender = 'M';

SELECT
	COUNT(Gender) AS 'QTD FEM'
FROM DimEmployee
WHERE Gender = 'F';


-- 4 B)
SELECT 
	TOP (1) Gender,
	FirstName,
	LastName,
	EmailAddress,
	HireDate AS 'MIN'
FROM DimEmployee
ORDER BY HireDate

SELECT 
	TOP (1) Gender,
	FirstName,
	LastName,
	EmailAddress,
	HireDate AS 'MIN'
FROM DimEmployee
WHERE Gender = 'F'
ORDER BY HireDate

-- 5 A), B) E C)
SELECT 
COUNT(DISTINCT ColorName) AS 'QTD_CORES',
COUNT(DISTINCT BrandName) AS 'QTD_MARCAS',
COUNT(DISTINCT ClassName) AS 'QTD_CLASES'
FROM DimProduct
