
-- CREATE VIEW

CREATE VIEW vwProducts AS
SELECT
	ProductKey,
	ProductName,
	ProductSubcategoryKey,
	BrandName,
	UnitPrice
FROM
	DimProduct;

GO -- MARKS THE END OF THE CODE
SELECT * FROM vwProducts;

-- SET THE MAIN DATABASE

USE ContosoRetailDW

-- ALTER VIEW
GO
ALTER VIEW vwProducts AS
SELECT
	ProductKey,
	ProductName,
	ProductSubcategoryKey,
	BrandName,
	UnitPrice
FROM
	DimProduct
WHERE BrandName = 'Contoso';

GO


-- DROP VIEW
DROP VIEW vwProducts


-- EXERCISES

-- 1 A)
GO
CREATE VIEW vwProdutos AS 
SELECT
	ProductName, 
	ColorName, 
	UnitPrice,
	UnitCost
FROM
	DimProduct

-- 1 B)
GO
CREATE VIEW vwFuncionarios AS 
SELECT
	FirstName,
	BirthDate,
	DepartmentName
FROM
	DimEmployee
-- 1 C)
GO
CREATE VIEW vwLojas AS 
SELECT
	StoreKey,
	StoreName
	OpenDate
FROM
	DimStore
-- 2
GO
CREATE VIEW vwClientes AS 
SELECT
	CONCAT(FirstName,' ', LastName) as 'Full name',
	IIF(GENDER = 'F', 'Feminine', 'Masculine') as 'Gender',
	EmailAddress,
	FORMAT(YearlyIncome, 'C') AS 'YearlyIncome'				-- NEW !!!
FROM
	DimCustomer
GO
SELECT * FROM vwClientes
GO
-- 3 A)
CREATE VIEW vwLojasAtivas AS 
SELECT
	*
FROM
	DimStore
WHERE CloseDate IS NULL
GO
-- 3 B)
CREATE VIEW vwFuncionariosMkt AS 
SELECT
	FirstName,
	EmailAddress,
	DepartmentName
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing'
GO
select * from vwFuncionariosMkt
GO
-- 3 C)
CREATE VIEW vwContosoLitwareSilver AS 
SELECT
	*
FROM
	DimProduct
WHERE BrandName IN ('Contoso', 'Litware')
AND ColorName = 'Silver'
GO
-- 4
CREATE VIEW vwTotalVendidoProdutos AS
SELECT
	P.ProductName,
	SUM(F.SalesQuantity) AS 'SUM(F.SalesQuantity)'
FROM
	FactSales AS F
INNER JOIN DimProduct AS P
	ON F.ProductKey = P.ProductKey
GROUP BY P.ProductName
GO

-- 5 A)
ALTER VIEW vwProdutos AS 
SELECT
	ProductName, 
	ColorName, 
	UnitPrice,
	UnitCost,
	BrandName -- added
FROM
	DimProduct
GO
-- 5 B)
GO
ALTER VIEW vwFuncionarios AS 
SELECT
	FirstName,
	BirthDate,
	DepartmentName
FROM
	DimEmployee
WHERE Gender = 'F'
-- 5 C)
GO
ALTER VIEW vwLojas AS 
SELECT
	StoreKey,
	StoreName
	OpenDate
FROM
	DimStore
WHERE CloseDate IS NULL
GO
-- 6 A )
CREATE VIEW vw_6a AS
SELECT
	BrandName,
	COUNT(*) AS 'QTY'
FROM
	DimProduct
GROUP BY BrandName;
GO
-- 6 B )
ALTER VIEW vw_6a AS
SELECT
	BrandName,
	COUNT(*) AS 'QTY',
	SUM(WEIGHT) AS 'TOTAL_WEIGHT'
FROM
	DimProduct
GROUP BY BrandName;
GO
SELECT * FROM vw_6a
GO
-- 6 A )
DROP VIEW vw_6a