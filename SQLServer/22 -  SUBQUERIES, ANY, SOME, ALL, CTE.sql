CREATE TABLE funcionarios(
id_funcionario INT,
nome VARCHAR(50),
idade INT,
sexo VARCHAR(50))

INSERT INTO funcionarios(id_funcionario, nome, idade, sexo)
VALUES	
	(1, 'Julia', 20, 'F'),
	(2, 'Daniel', 21, 'M'),
	(3, 'Amanda', 22, 'F'),
	(4, 'Pedro', 23, 'M'),
	(5, 'André', 24, 'M'),
	(6, 'Luisa', 25, 'F')

SELECT * FROM funcionarios

/*
IN (value1, value2,..., valueN):
	only accepts the values INside that set
	does not accept operators like:
		> IN(...)
		<= IN(...)

ANY (value1, value2,..., valueN):
	only accepts the values INside that set
		OR value1
		OR value2 
		...
		OR valueN
	accept operators like:
		> ANY(...)
		<= ANY(...)

SOME: same as ANY

ALL (value1, value2,..., valueN):
	only accepts ALL values INside that set
		AND value1
		AND value2 
		...
		AND valueN
	accept operators like:
		> ALL(...)
		<= ALL(...)
*/


--- DEMONSTRATIONS



-- Selecione os funcionários do sexo masculino (MAS, utilizando a coluna de IDADE para isso)

SELECT * FROM funcionarios
WHERE idade IN (21, 23, 24)

SELECT * FROM funcionarios
WHERE idade IN (SELECT idade FROM funcionarios WHERE sexo = 'M')

/*
= ANY(valor1, valor2, valor3) :
Equivalente ao IN, retorna as lunhas da tabela que sejam iguais ao valor1, OU valor2, OU valor3
*/

SELECT * FROM funcionarios
WHERE idade = ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

/*
> ANY(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, OU valor2, OU valor3. Ou seja, maior que o mínimo dos valores
*/

SELECT * FROM funcionarios
WHERE idade > ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

/*
< ANY(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, OU valor2, OU valor3. Ou seja, maior que o máximo dos valores
*/

SELECT * FROM funcionarios
WHERE idade < ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')


/*
> ALL(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, E valor2, E valor3. Ou seja, maior que o máximo dos valores
*/

SELECT * FROM funcionarios
WHERE idade > ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')

/*
< ALL(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores menores que o valor1, E valor2, E valor3. Ou seja, menor que o mínimo dos valores
*/

SELECT * FROM funcionarios
WHERE idade < ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')



-- SUBQUERY -  EXISTS
USE ContosoRetailDW

SELECT 
	P.ProductKey,
	P.ProductName
FROM 
	DimProduct AS P
WHERE EXISTS(
			SELECT 
				ProductKey
			FROM
				FactSales AS F
			WHERE
				DateKey = '20070101'
				AND F.ProductKey = P.ProductKey)

-- SUBQUERY - ADD COLUMNS
SELECT
	P.ProductKey,
	P.ProductName,
	(SELECT COUNT(F.ProductKey)
	FROM FactSales AS F
	WHERE F.ProductKey = P.ProductKey)
FROM
	DimProduct AS P

---------------------------------------------
--	CTE
-- Common Table Expressions

WITH cte AS (
	SELECT 
		ProductKey,
		ProductName
	FROM
		DimProduct
)
SELECT * FROM cte

-- renaming columns
WITH new_cte(new_ProductKey, new_ProductName) AS (
	SELECT 
		ProductKey,
		ProductName
	FROM
		DimProduct
)
SELECT * FROM new_cte

-- multiple ctes
WITH produtos_contoso AS (
	SELECT
		ProductKey,
		ProductName,
		BrandName
	FROM
		DimProduct
	WHERE
		BrandName = 'Contoso'
),
vendas_top100 AS (
	SELECT TOP(100)
		SalesKey,
		ProductKey,
		DateKey,
		SalesQuantity
	FROM
		FactSales
	ORDER BY
		DateKey DESC
)

SELECT * FROM vendas_top100
INNER JOIN produtos_contoso
	ON vendas_top100.ProductKey = produtos_contoso.ProductKey


-- EXERCISES

-- 1
WITH q1 as (
	SELECT *
	FROM FactSales
	WHERE StoreKey = (SELECT 
							StoreKey
						FROM DimStore
						WHERE StoreName = 'Contoso Orlando Store')
	)
SELECT * FROM q1


 -- 2 A)
SELECT
	ProductKey,
	ProductName,
	UnitPrice
FROM	
	DimProduct
WHERE UnitPrice > ANY (SELECT UnitPrice 
						FROM DimProduct
						WHERE ProductKey = 1893)
 -- 2 B)
 SELECT
	ProductKey,
	ProductName,
	UnitPrice,
	(SELECT UnitPrice 
	FROM DimProduct
	WHERE ProductKey = 1893) AS 'target_UnitPrice'
FROM	
	DimProduct
WHERE UnitPrice > ANY (SELECT UnitPrice 
						FROM DimProduct
						WHERE ProductKey = 1893)

-- 3
SELECT *
FROM 
	DimEmployee
WHERE ParentEmployeeKey = (SELECT 
							ParentEmployeeKey
						FROM
							DimEmployee
						WHERE FirstName = 'Miguel' and LastName = 'Severino')

-- 4
SELECT 
	CustomerKey,
	FirstName,
	LastName,
	EmailAddress,
	YearlyIncome
FROM DimCustomer
WHERE CustomerType = 'Person'
AND YearlyIncome > (SELECT AVG(YearlyIncome)
					FROM DimCustomer
					WHERE CustomerType = 'Person')
-- 5

SELECT * 
FROM 
	DimCustomer
WHERE CustomerKey IN (
						SELECT
						CustomerKey
					FROM
						FactOnlineSales
					WHERE PromotionKey IN (SELECT
											PromotionKey
										FROM DimPromotion
										WHERE PromotionName = 'Asian Holiday Promotion'
										))

-- 6
SELECT
	CustomerKey,
	CompanyName
FROM 
	DimCustomer
WHERE NOT CustomerType = 'Person'
AND CustomerKey IN (
					SELECT	CustomerKey
					FROM FactOnlineSales
					WHERE SalesAmount > 3000)

-- 7
SELECT
	ProductKey,
	ProductName,
	BrandName,
	UnitPrice,
	(select AVG(UnitPrice) from DimProduct) AS 'avg_UnitPrice'
FROM	
	DimProduct

-- 8
GO
WITH q8a AS(
		SELECT TOP(1)
		COUNT(*) AS 'Maior quantidade de produtos por marca'
		FROM DimProduct 
		GROUP BY BrandName 
		ORDER BY COUNT(*) DESC
				),
	q8b as (
		SELECT TOP(1)
		COUNT(*) AS 'Menor quantidade de produtos por marca'
		FROM DimProduct 
		GROUP BY BrandName 
		ORDER BY COUNT(*) ASC
				),
	q8c_aux as (
		SELECT AVG(ProductKey) AS 'avg'
		FROM DimProduct 
		GROUP BY BrandName
				),
	q8c as(
		SELECT AVG(avg) AS 'Média de produtos por marca' 
		FROM q8c_aux
				)
SELECT * FROM q8a
SELECT * FROM q8b


SELECT TOP (1)
	(
		SELECT TOP(1)
		COUNT(*) 
		FROM DimProduct 
		GROUP BY BrandName 
		ORDER BY COUNT(*) DESC
				)AS 'Maior quantidade de produtos por marca',
			(
		SELECT TOP(1)
		COUNT(*)
		FROM DimProduct 
		GROUP BY BrandName 
		ORDER BY COUNT(*) ASC
				) AS 'Menor quantidade de produtos por marca',
		(
		SELECT AVG(avg_pk)  
		FROM (SELECT AVG(ProductKey) AS 'avg_pk' FROM DimProduct GROUP BY BrandName) as t
		)AS 'Média de produtos por marca'
FROM DimProduct


/*	
	ATENTION!!!!!
	if you're using a subquery in FROM,
	>>>> ALWAYS <<<<< use an alias for your table
	FROM (subquery) AS 'alias'
*/


-- 9


















