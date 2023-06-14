-- 1
SELECT
	s.ProductSubcategoryKey,
	s.ProductSubcategoryName
FROM 
	DimProduct as p
INNER JOIN DimProductSubcategory AS s
ON s.ProductSubcategoryKey = p.ProductSubcategoryKey;

-- 2
SELECT *
FROM DimProductCategory


SELECT *
FROM DimProductSubcategory

SELECT 
	s.*,
	c.*
FROM 
	DimProductSubcategory AS s
LEFT JOIN 
	DimProductCategory AS c
ON s.ProductCategoryKey = c.ProductCategoryKey;

-- 3
SELECT
	s.StoreKey,
	s.StoreName,
	s.EmployeeCount,
	g.ContinentName,
	g.RegionCountryName
FROM 
	DimStore as s
LEFT JOIN 
	DimGeography as g
ON s.GeographyKey = g.GeographyKey;

select * from DimGeography;
select * from DimStore;

-- 4
SELECT
	P.*,
	C.ProductCategoryDescription
FROM 
	DimProduct AS P
LEFT JOIN 
	DimProductSubcategory AS S
ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
LEFT JOIN 
	DimProductCategory AS C
ON S.ProductCategoryKey = C.ProductCategoryKey;

SELECT * FROM DimProductCategory;
SELECT * FROM DimProductSubcategory;
SELECT * FROM DimProduct;

-- 5 A)
SELECT TOP(100) *
FROM 
	FactStrategyPlan;

-- 5 B)
SELECT 
	F.StrategyPlanKey,
	F.Datekey,
	A.AccountName,
	F.Amount
FROM 
	FactStrategyPlan AS F
INNER JOIN 
	DimAccount AS A
ON F.AccountKey = A.AccountKey;

-- 6
SELECT 
	F.StrategyPlanKey,
	F.Datekey,
	S.ScenarioName,
	F.Amount
FROM 
	FactStrategyPlan AS F
INNER JOIN 
	DimScenario AS S
ON F.ScenarioKey = S.ScenarioKey;

-- 7
SELECT 
	DISTINCT S.ProductSubcategoryName,
	S.ProductSubcategoryKey
FROM 
	DimProduct AS P
RIGHT JOIN 
	DimProductSubcategory AS S
ON S.ProductSubcategoryKey = P.ProductSubcategoryKey
WHERE P.ProductName IS NULL;

-- 8
SELECT
	DISTINCT P.BrandName,
	C.ChannelName
FROM
	DimProduct AS P
CROSS JOIN
	DimChannel AS C
WHERE P.BrandName IN ('Contoso','Fabrikam','Litware');

-- 9
select 
	F.OnlineSalesKey,
	F.DateKey,
	P.PromotionName,
	F.SalesAmount
from 
	FactOnlineSales AS F
INNER JOIN 
	DimPromotion AS P
ON F.PromotionKey = P.PromotionKey
WHERE P.PromotionName <> 'No discount'
ORDER BY F.DateKey;

-- 10
SELECT 
	F.SalesKey,
	C.ChannelName,
	S.StoreName,
	P.ProductName,
	F.SalesAmount
FROM 
	FactSales AS F
INNER JOIN 
	DimChannel AS C
ON F.channelKey = C.ChannelKey
INNER JOIN 
	DimStore AS S
ON F.StoreKey = S.StoreKey
LEFT JOIN
	DimProduct AS P
ON F.ProductKey = P.ProductKey
ORDER BY F.SalesAmount DESC;

select TOP(10)* from FactSales;
select TOP(10)* from DimChannel;
select TOP(10)* from DimStore;
select TOP(10)* from DimProduct;