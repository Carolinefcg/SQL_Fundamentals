- Funções de Janela
-- FUNÇÕES DE OFFSET (Deslocamento): LAG e LEAD

-- LAG(COLUMN, PRECEDING_NUMBER, NULL_VALUE)
-- LEAD(COLUMN, PRECEDING_NUMBER, NULL_VALUE)

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	LAG(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento) AS 'Fat. Mês Anterior',
	LEAD(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento) AS 'Fat. Mês Seguinte'
FROM Resultado
ORDER BY [Data do Fechamento]


-- Funções de Janela
-- Cálculo MoM (Month over Month)

-- USING NULLIF 
SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	FORMAT((Faturamento_MM/NULLIF(LAG(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento), 0)) - 1, '0.00%') AS 'Crescimento MoM'
FROM Resultado
ORDER BY [Data do Fechamento]

SELECT NULLIF(4, NULL)

-- CHANGING THE LAG() ITSELF
SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	FORMAT((Faturamento_MM/LAG(Faturamento_MM, 1, NULL) OVER(ORDER BY Data_Fechamento)) - 1, '0.00%') AS 'Crescimento MoM'
FROM Resultado
ORDER BY [Data do Fechamento]

-- USING COALESCE

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	COALESCE(FORMAT((Faturamento_MM/LAG(Faturamento_MM, 1, NULL) OVER(ORDER BY Data_Fechamento)) - 1, '0.00%'), '-') AS 'Crescimento MoM'
FROM Resultado
ORDER BY [Data do Fechamento]

-- Funções de Janela
-- FUNÇÕES DE OFFSET (Deslocamento): FIRST_VALUE e LAST_VALUE

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	FIRST_VALUE(Faturamento_MM) OVER(ORDER BY Data_Fechamento) AS 'Primeiro valor',
	LAST_VALUE(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'Último valor'
FROM Resultado
ORDER BY [Data do Fechamento]

-- EXERCISES
GO
USE ContosoRetailDW
DROP VIEW IF EXISTS vwProdutos
GO
CREATE VIEW vwProdutos AS
SELECT
	BrandName AS 'Marca',
	ColorName AS 'Cor',
	COUNT(*) AS 'Quantidade_Vendida',
	ROUND(SUM(SalesAmount), 2) AS 'Receita_Total'
FROM 
	DimProduct
INNER JOIN FactSales
	ON DimProduct.ProductKey = FactSales.ProductKey
GROUP BY BrandName, ColorName

-- 1
SELECT
	*,
	SUM(Quantidade_Vendida) OVER() AS 'QTD TOTAL VENDIDA'
FROM vwProdutos

-- 2
SELECT
	*,
	SUM(Quantidade_Vendida) OVER() AS 'QTD TOTAL VENDIDA',
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS 'QTD TOTAL VENDIDA POR MARCA'
FROM vwProdutos

-- 3
SELECT
	--*,
	SUM(Quantidade_Vendida) OVER() AS 'QTD_TOTAL',
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS 'QTD_MARCA',
	FORMAT(SUM(Quantidade_Vendida) OVER(PARTITION BY Marca)/SUM(Quantidade_Vendida) OVER(), '0.00%') AS '% PARTICIPACAO'
FROM vwProdutos
ORDER BY Marca

-- 4 
SELECT
	Marca,
	Cor,
	Quantidade_Vendida,
	RANK() OVER(PARTITION BY Marca ORDER BY Quantidade_Vendida DESC ) as 'Rank'
FROM 
	vwProdutos
WHERE MARCA = 'Contoso'
ORDER BY  Quantidade_Vendida DESC

-- 5.1
DROP VIEW IF EXISTS vwHistoricoLojas

CREATE VIEW vwHistoricoLojas AS (
SELECT
	RANK() OVER(ORDER BY Datekey) as 'ID',
	YEAR(Datekey) as 'ANO',
	DATENAME(MONTH, Datekey) AS 'MES',
	ISNULL(S.QTD_OpenDate, 0) as 'QTD_LOJAS'
FROM 
	(SELECT CONCAT(YEAR(OpenDate),FORMAT(OpenDate, 'MM')) AS 'OpenDate',
	COUNT(OpenDate) AS 'QTD_OpenDate'
	FROM DimStore
	GROUP BY CONCAT(YEAR(OpenDate),FORMAT(OpenDate, 'MM'))
	) AS S
RIGHT JOIN (SELECT DISTINCT 
			CalendarMonth,
			Datekey
			FROM DimDate
			WHERE DAY(Datekey) = 01
			) AS D
	ON D.CalendarMonth = S.OpenDate

)

-- 5.2
SELECT 
	*,
	SUM(QTD_LOJAS) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) AS 'MOVING SUM'
FROM
	vwHistoricoLojas

-- 6
SELECT 
	*,
	SUM(QTD_LOJAS) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS 'MOVING SUM'
FROM
	vwHistoricoLojas

-- 7.1
DROP DATABASE IF EXISTS DESAFIO

CREATE DATABASE DESAFIO

DROP TABLE IF EXISTS Calendario

CREATE TABLE Calendario (
	data DATE
)

DECLARE @firstYear INT = (SELECT TOP (1) YEAR(DateFirstPurchase) 
						FROM DimCustomer
						WHERE DateFirstPurchase IS NOT NULL
						ORDER BY DateFirstPurchase),
		@lastYear INT = (SELECT TOP (1) YEAR(DateFirstPurchase) 
						FROM DimCustomer
						WHERE DateFirstPurchase IS NOT NULL
						ORDER BY DateFirstPurchase DESC)
DECLARE @dateAux DATE = DATEFROMPARTS(@firstYear, '01', '01')


WHILE @dateAux <> DATEFROMPARTS(@lastYear, '12', '31')
BEGIN

INSERT INTO Calendario(data)
VALUES (@dateAux)
SET @dateAux = DATEADD(DAY, 1, @dateAux)

END

ALTER TABLE Calendario
ADD ANO INT,
	MES INT,
	DIA INT,
	ANOMES INT,
	NOMEMES VARCHAR(20)

UPDATE Calendario
SET ANO = YEAR(data),
	MES = MONTH(data),
	DIA = DAY(data),
	ANOMES= FORMAT(data, 'yyyyMM'),
	NOMEMES = DATENAME(MONTH, data)

SELECT * FROM Calendario

DROP VIEW IF EXISTS vwNovosClientes
GO
CREATE VIEW vwNovosClientes AS 
SELECT
	RANK() OVER(ORDER BY C.ANOMES) AS 'ID',
	C.ANO, 
	C.NOMEMES,
	ISNULL(NOVOS_CLIENTES, 0) AS 'NOVOS_CLIENTES'
FROM
	(SELECT DISTINCT
		ANOMES,
		ANO, 
		NOMEMES
	FROM Calendario) AS C
LEFT JOIN (SELECT 
			FORMAT(DateFirstPurchase, 'yyyyMM') AS 'ANOMES',
			COUNT(DateFirstPurchase) AS 'NOVOS_CLIENTES'
			FROM DimCustomer
			WHERE FORMAT(DateFirstPurchase, 'yyyyMM') IS NOT NULL
			GROUP BY FORMAT(DateFirstPurchase, 'yyyyMM')
			) AS D
				ON C.ANOMES = D.ANOMES
GO

SELECT * FROM vwNovosClientes

-- 7 A)
SELECT
	*,
	ISNULL(SUM(NOVOS_CLIENTES) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING), 0) AS 'MOVING SUM'
FROM
	vwNovosClientes
-- 7 B)
SELECT
	*,
	ISNULL(AVG(NOVOS_CLIENTES) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING), 0) AS 'MOVING SUM'
FROM
	vwNovosClientes
-- 7 C)
SELECT
	*,
	SUM(NOVOS_CLIENTES) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'ACCUM_SUM'
FROM
	vwNovosClientes
-- 7 D)
SELECT
	*,
	SUM(NOVOS_CLIENTES) OVER(PARTITION BY ANO ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'ACCUM_SUM_YEAR'
FROM
	vwNovosClientes

-- 8
SELECT
	*,
	LAG(NOVOS_CLIENTES, 1, 0) OVER(ORDER BY ID) AS 'M' ,
	LAG(NOVOS_CLIENTES, 1, 0) OVER(PARTITION BY NOMEMES ORDER BY ANO) AS 'Y' ,
	FORMAT(ISNULL(CAST(NOVOS_CLIENTES AS FLOAT)/NULLIF(LAG(CAST(NOVOS_CLIENTES AS FLOAT), 1, 0) OVER(ORDER BY ID), 0), 0), '0.00%') AS 'MoM',
	FORMAT(ISNULL(CAST(NOVOS_CLIENTES AS FLOAT)/NULLIF(LAG(CAST(NOVOS_CLIENTES AS FLOAT), 1, 0) OVER(PARTITION BY NOMEMES ORDER BY ANO), 0), 0), '0.00%') AS 'YoY'
FROM
	vwNovosClientes
ORDER BY ID
