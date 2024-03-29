-- 1 a)

SELECT 
	channelKey,
	SUM(SalesQuantity) AS 'Soma_Qtd_Vendida',
	AVG(SalesQuantity) AS 'AVG_Qtd_Vendida',
	MAX(SalesQuantity) AS 'MAX_Qtd_Vendida',
	MIN(SalesQuantity) AS 'MIN_Qtd_Vendida'
FROM FactSales
GROUP BY channelKey;

-- 1 B)
SELECT
	StoreKey,
	SUM(SalesQuantity) AS 'Soma_Qtd_Vendida',
	SUM(ReturnQuantity)AS 'Soma_Qtd_Devolvida',
	AVG(SalesQuantity) AS 'AVG_Qtd_Vendida',
	AVG(ReturnQuantity) AS 'AVG_Qtd_Devolvida',
	MAX(SalesQuantity) AS 'MAX_Qtd_Vendida',
	MAX(ReturnQuantity) AS 'MAX_Qtd_Devolvida',
	MIN(SalesQuantity) AS 'MIN_Qtd_Vendida',
	MIN(ReturnQuantity)AS 'MIN_Qtd_Devolvida'
FROM FactSales
GROUP BY StoreKey
order by StoreKey;

-- 1 C)
SELECT
	channelKey,
	SUM(SalesAmount) AS 'SUM(SalesAmount)',
	AVG(SalesAmount) AS 'AVG(SalesAmount)',
	MAX(SalesAmount) AS 'MAX(SalesAmount)',
	MIN(SalesAmount) AS 'MIN(SalesAmount)'
FROM FactSales
WHERE DateKey BETWEEN '2007-01-01' AND '2007-12-31'
GROUP BY channelKey;

-- 2 A)
SELECT 
	ProductKey,
	SUM(SalesAmount) AS 'SUM(SalesAmount)'
FROM FactSales
GROUP BY ProductKey
HAVING SUM(SalesAmount) >= 5000000
ORDER BY SUM(SalesAmount) DESC;

-- 2 B)
SELECT 
	TOP(10) ProductKey,
	SUM(SalesAmount) AS 'SUM(SalesAmount)'
FROM FactSales
GROUP BY ProductKey
ORDER BY SUM(SalesAmount) DESC;


-- 3 A)
SELECT
	TOP(1) CustomerKey,
	SUM(SalesQuantity) AS 'SUM(SalesQuantity)'
FROM 
	FactOnlineSales
GROUP BY CustomerKey
ORDER BY SUM(SalesQuantity) DESC;


-- 3 B)
SELECT
	TOP(3) ProductKey,
	CustomerKey,
	SUM(SalesQuantity) AS 'SUM(SalesQuantity)'
FROM 
	FactOnlineSales
WHERE CustomerKey IN (SELECT
						TOP(1) CustomerKey
					FROM FactOnlineSales
					GROUP BY CustomerKey
					ORDER BY SUM(SalesQuantity) DESC)
GROUP BY CustomerKey, ProductKey
ORDER BY SUM(SalesQuantity) DESC;


-- 4 A)
SELECT 
	BrandName,
	COUNT(ProductKey) AS 'COUNT(ProductKey)'
FROM DimProduct
GROUP BY BrandName;

-- 4 B)
SELECT 
	ClassName,
	AVG(UnitPrice) AS 'AVG(UnitPrice)'
FROM DimProduct
GROUP BY ClassName;

-- 4 C)
SELECT 
	ColorName,
	AVG(Weight) AS 'AVG(Weight)'
FROM DimProduct
GROUP BY ColorName;

-- 5
SELECT 
	StockTypeName,
	SUM(Weight) AS 'SUM(Weight)'
FROM DimProduct
WHERE BrandName = 'Contoso'
GROUP BY StockTypeName
ORDER BY SUM(Weight) DESC;

-- 6
SELECT
	BrandName,
	COUNT(DISTINCT ColorID) AS 'Colors',
	CASE 
	WHEN COUNT(DISTINCT ColorID) < 16 THEN CONCAT(COUNT(DISTINCT ColorID), '/16')
	ELSE '16/16 - ALL COLORS AVAILABLE' END AS 'COLOR_AVAILABILITY'
FROM DimProduct
GROUP BY BrandName;

-- 7
SELECT
	Gender,
	COUNT(Gender) AS 'Customer_qty',
	AVG(YearlyIncome) AS 'AVG(YearlyIncome)'
FROM 
	DimCustomer
WHERE GENDER IS NOT NULL
GROUP BY Gender;

-- 8
SELECT
	Education,
	COUNT(Education) AS 'Customer_qty',
	AVG(YearlyIncome) AS 'AVG(YearlyIncome)'
FROM 
	DimCustomer
WHERE Education IS NOT NULL
GROUP BY Education
ORDER BY COUNT(Education) DESC;

-- 9
SELECT
	DepartmentName,
	COUNT(DepartmentName) AS 'Employees_Qty'
FROM 
	DimEmployee
WHERE EndDate IS NULL
GROUP BY DepartmentName;

-- 10
SELECT
	Title,
	sum(VacationHours) AS 'sum(VacationHours)'
FROM DimEmployee
WHERE Gender = 'F'
AND DepartmentName IN ('Production', 'Marketing', 'Engineering', 'Finance')
AND HireDate BETWEEN '1999-01-01' AND '2000-12-31'
GROUP BY Title;
