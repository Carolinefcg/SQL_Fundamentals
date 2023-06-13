

--- BURNING 

-- 1 A)
SELECT
	D.CalendarYear,
	SUM(F.SalesQuantity) AS 'F.SalesQuantity'
FROM 
	FactSales AS F
INNER JOIN DimDate AS D
	ON F.DateKey = D.Datekey
GROUP BY D.CalendarYear;


-- 1 B)
SELECT
	D.CalendarYear,
	SUM(F.SalesQuantity) AS 'F.SalesQuantity'
FROM 
	FactSales AS F
INNER JOIN DimDate AS D
	ON F.DateKey = D.Datekey
WHERE D.CalendarMonthLabel = 'January'
GROUP BY D.CalendarYear;



-- 1 C)
SELECT
	D.CalendarYear,
	SUM(F.SalesQuantity) AS 'F.SalesQuantity'
FROM 
	FactSales AS F
INNER JOIN DimDate AS D
	ON F.DateKey = D.Datekey
WHERE D.CalendarMonthLabel = 'January'
GROUP BY D.CalendarYear
HAVING SUM(F.SalesQuantity) >= 1200000;

-- ACTUAL EXERCISES

-- 1 A)
SELECT TOP (1000)
	C.ChannelName,
	SUM(F.SalesQuantity) AS 'SUM(F.SalesQuantity)'
FROM
	FactSales AS F
INNER JOIN DimChannel AS C
	ON F.channelKey = C.ChannelKey
GROUP BY C.ChannelName
ORDER BY SUM(F.SalesQuantity) DESC;

-- 1 B)
SELECT TOP (1000)
	S.StoreName,
	SUM(F.SalesQuantity) AS 'SUM(F.SalesQuantity)',
	SUM(F.ReturnQuantity) AS 'SUM(F.ReturnQuantity)'
FROM
	FactSales AS F
INNER JOIN DimStore AS S
	ON F.StoreKey = S.StoreKey
GROUP BY S.StoreName;

-- 1 B)
SELECT TOP (1000)
	D.CalendarMonthLabel,
	D.CalendarYear,
	SUM(F.SalesQuantity) AS 'SUM(F.SalesQuantity)'
FROM
	FactSales AS F
INNER JOIN DimDate AS D
	ON F.DateKey = D.Datekey
GROUP BY D.CalendarMonthLabel, D.CalendarYear
ORDER BY D.CalendarMonthLabel ASC,D.CalendarYear DESC;

-- 2 A)
SELECT TOP(1)
	P.ColorName,
	 SUM(F.SalesAmount) AS 'SUM(F.SalesAmount)'
FROM
	FactSales AS F
INNER JOIN DimProduct AS P
ON F.ProductKey = P.ProductKey
GROUP BY P.ColorName
ORDER BY SUM(F.SalesAmount) DESC;

-- 2 B)
SELECT 
	P.ColorName,
	 SUM(F.SalesAmount) AS 'SUM(F.SalesAmount)'
FROM
	FactSales AS F
INNER JOIN DimProduct AS P
ON F.ProductKey = P.ProductKey
GROUP BY P.ColorName
HAVING SUM(F.SalesAmount) >3000000
ORDER BY SUM(F.SalesAmount) DESC;

-- 3
SELECT
	P.ProductCategoryName,
	SUM(F.SalesQuantity) AS 'F.SalesQuantity' 
FROM
	FactSales AS F
INNER JOIN DimProduct AS D
	ON F.ProductKey = D.ProductKey
INNER JOIN DimProductSubcategory AS S
	ON D.ProductSubcategoryKey = S.ProductSubcategoryKey
INNER JOIN DimProductCategory AS P
	ON S.ProductCategoryKey = P.ProductCategoryKey
GROUP BY P.ProductCategoryName;

-- 4 A)
SELECT TOP(1)
	CONCAT_WS(' ', C.FirstName, C.MiddleName, C.LastName) AS 'Full_Name',
	SUM(F.SalesQuantity) AS 'SUM(F.SalesQuantity)'
FROM 
	FactOnlineSales AS F
INNER JOIN DimCustomer AS C
	ON F.CustomerKey = C.CustomerKey
WHERE CONCAT_WS(' ', C.FirstName, C.MiddleName, C.LastName) IS NOT NULL
AND CONCAT_WS(' ', C.FirstName, C.MiddleName, C.LastName) <> ''
GROUP BY CONCAT_WS(' ', C.FirstName, C.MiddleName, C.LastName)
ORDER BY SUM(F.SalesQuantity) DESC;

-- 4 B)
SELECT TOP (10)
	CONCAT_WS(' ', C.FirstName, C.MiddleName, C.LastName) AS 'Full_Name',
	P.ProductName,
	SUM(F.SalesQuantity) AS 'SUM(F.SalesQuantity)'
FROM 
	FactOnlineSales AS F
INNER JOIN DimCustomer AS C
	ON F.CustomerKey = C.CustomerKey
INNER JOIN DimProduct AS P
	ON F.ProductKey = P.ProductKey
WHERE CONCAT_WS(' ', C.FirstName, C.MiddleName, C.LastName) = (
		SELECT TOP(1)
		CONCAT_WS(' ', C.FirstName, C.MiddleName, C.LastName) AS 'Full_Name'
		--,SUM(F.SalesQuantity) AS 'SUM(F.SalesQuantity)'
		FROM 
			FactOnlineSales AS F
		INNER JOIN DimCustomer AS C
			ON F.CustomerKey = C.CustomerKey
		WHERE CONCAT_WS(' ', C.FirstName, C.MiddleName, C.LastName) IS NOT NULL
		AND CONCAT_WS(' ', C.FirstName, C.MiddleName, C.LastName) <> ''
		GROUP BY CONCAT_WS(' ', C.FirstName, C.MiddleName, C.LastName)
		ORDER BY SUM(F.SalesQuantity) DESC
		)
GROUP BY CONCAT_WS(' ', C.FirstName, C.MiddleName, C.LastName),
		P.ProductName
ORDER BY SUM(F.SalesQuantity) DESC;

-- 5
SELECT
	C.Gender,
	SUM(F.SalesQuantity) AS 'SUM(F.SalesQuantity)'
FROM
	FactOnlineSales AS F
INNER JOIN DimCustomer AS C
	ON F.CustomerKey = C.CustomerKey
WHERE C.Gender IS NOT NULL
GROUP BY C.Gender;

-- 6
SELECT
	C.CurrencyDescription,
	SUM(F.AverageRate) AS 'F.AverageRate'
FROM
	FactExchangeRate AS F 
INNER JOIN DimCurrency AS C
	ON F.CurrencyKey = C.CurrencyKey
GROUP BY C.CurrencyDescription
HAVING SUM(F.AverageRate) BETWEEN 10 AND 100;

-- 7
SELECT
	S.ScenarioName,
	SUM(P.Amount) AS 'F.AverageRate'
FROM
	FactStrategyPlan as P
INNER JOIN DimScenario AS S
	ON P.ScenarioKey = S.ScenarioKey
WHERE S.ScenarioName IN ('Actual', 'Budget') 
GROUP BY S.ScenarioName;

-- 8
SELECT
	D.CalendarYear,
	SUM(P.Amount) AS 'F.AverageRate'
FROM
	FactStrategyPlan as P
INNER JOIN DimDate AS D
	ON P.Datekey = D.Datekey 
GROUP BY D.CalendarYear;


-- 9
SELECT 
	S.ProductSubcategoryName,
	COUNT(P.ProductKey) AS 'COUNT( P.ProductKey)'
FROM
	DimProduct AS P
INNER JOIN DimProductSubcategory AS S
	ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
WHERE P.BrandName = 'Contoso'
	AND P.ColorName = 'Silver'
GROUP BY S.ProductSubcategoryName;

-- 10
SELECT 
	P.BrandName,
	S.ProductSubcategoryName,
	COUNT(P.ProductKey) AS 'COUNT( P.ProductKey)'
FROM
	DimProduct AS P
INNER JOIN DimProductSubcategory AS S
	ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
GROUP BY P.BrandName, S.ProductSubcategoryName
ORDER BY P.BrandName;
