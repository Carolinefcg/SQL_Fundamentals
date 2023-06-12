-- 1
select 
	TOP (100) *
from FactSales
ORDER BY SalesAmount DESC;

-- 2
SELECT 
	TOP(10) ProductName,
	UnitCost,
	Weight,
	AvailableForSaleDate
FROM DimProduct
ORDER BY UnitCost DESC, Weight DESC, AvailableForSaleDate ASC;

-- 3
SELECT 
	ProductName AS 'NomeProd',
	Weight AS 'Peso'
FROM DimProduct
WHERE Weight >= 100
ORDER BY Weight DESC;

-- 4
SELECT 
	StoreName,
	OpenDate,
	EmployeeCount
FROM DimStore
WHERE StoreType = 'Store'; -- 299

SELECT 
	StoreName,
	OpenDate,
	EmployeeCount
FROM DimStore
WHERE StoreType = 'Store'
AND Status LIKE '%On%'; -- 287


-- 5

select 
	ProductKey,
	ProductName,
	AvailableForSaleDate
from DimProduct
WHERE
BrandName = 'Litware'
AND ProductName like '%home theater%'
AND AvailableForSaleDate = '20090315';

-- 6
-- a)
SELECT 
	StoreName,
	OpenDate,
	EmployeeCount
FROM DimStore
WHERE Status NOT LIKE '%On%'; -- 12

-- b)
SELECT 
	StoreName,
	OpenDate,
	EmployeeCount,
	CloseReason
FROM DimStore
WHERE CloseReason IS NOT NULL;

-- 7
SELECT 
	StoreKey,
	StoreName,
	EmployeeCount,
	CASE WHEN 
	EmployeeCount <= 20 THEN 'Category 1'
	WHEN (EmployeeCount > 20 AND EmployeeCount <= 50)  THEN 'Category 2'
	ELSE 'Category 3' END AS 'CoffeeMachineCategory'
FROM DimStore;

-- 8
select 
	ProductKey,
	ProductName,
	UnitPrice
from DimProduct
where ProductName like '%LCD%';

-- 9
SELECT
	ProductName,
	Manufacturer,
	ColorName
FROM DimProduct
WHERE Manufacturer IN ('Contoso, Ltd', 'Litware, Inc.', 'Fabrikam, Inc.')
AND ColorName IN ('Green', 'Orange', 'Black', 'Silver', 'Pink');

-- 10

SELECT
	BrandName,
	ColorName,
	UnitPrice
FROM DimProduct
WHERE BrandName = 'Contoso'
AND ColorName = 'Silver'
AND UnitPrice BETWEEN 10 AND 30
ORDER BY UnitPrice DESC;