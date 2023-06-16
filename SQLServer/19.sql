-- 1 A)
DECLARE @E varchar(30) = 'Economy,0.05',
		@R varchar(30) = 'Regular,0.07',
		@D varchar(30) = 'Deluxe,0.09'

SELECT
	ProductKey,
	ProductName,
	UnitPrice,
	ClassName,
	IIF(ClassName = SUBSTRING(@E, 1, CHARINDEX(',', @E)-1),
		CAST(SUBSTRING(@E, CHARINDEX(',', @E)+1, 100) AS FLOAT),
			IIF(ClassName = SUBSTRING(@R, 1, CHARINDEX(',', @R)-1),
				 CAST(SUBSTRING(@R, CHARINDEX(',', @R)+1, 100) AS FLOAT),
				0.09)) AS 'DISCOUNT',
	CASE
		WHEN ClassName = SUBSTRING(@E, 1, CHARINDEX(',', @E)-1) THEN UnitPrice*(1- CAST(SUBSTRING(@E, CHARINDEX(',', @E)+1, 100) AS FLOAT))
		WHEN ClassName = SUBSTRING(@R, 1, CHARINDEX(',', @R)-1) THEN UnitPrice*(1- CAST(SUBSTRING(@R, CHARINDEX(',', @R)+1, 100) AS FLOAT))
		ELSE UnitPrice*0.91
	END AS 'UNITPRICE_DISCOUNTED'
FROM
	DimProduct;

-- 2
SELECT
	BrandName,
	COUNT(ProductKey) as 'qtd',
	CASE
		WHEN COUNT(ProductKey)> 500 THEN 'A'
		WHEN COUNT(ProductKey) BETWEEN 100 AND 500 THEN 'B'
		ELSE 'C'
	END AS 'CATEGORY'
FROM
	DimProduct
GROUP BY BrandName
ORDER BY COUNT(ProductKey) DESC;

-- 3
SELECT
	StoreName,
	EmployeeCount,
	CASE
		WHEN EmployeeCount >= 50 THEN 'Acima de 50 funcionários'
		WHEN EmployeeCount >= 40 THEN 'Entre 40 e 50 funcionários'
		WHEN EmployeeCount >= 30 THEN 'Entre 30 e 40 funcionários'
		WHEN EmployeeCount >= 20 THEN 'Entre 20 e 30 funcionários'
		WHEN EmployeeCount >= 40 THEN 'Entre 10 e 20 funcionários'
		ELSE 'Abaixo de 20 funcionários'
	END AS 'EmpCount'
FROM
	DimStore

-- 4
SELECT
FROM
	DIMPRO