
/*
WINDOWS FUNCTIONS

OVER
PARTITION BY
ROW_NUMBER
RANK
DENSE_RANK
NTAIL
ROWS PRECEDING
ROWS CURRENT ROW
ROWS FOLLOWING
UNBOUNDED
LAG
LEAD
MoM (Month over Month)
*/





/*
################# Código para Criação da Tabela Lojas #####################
*/

CREATE DATABASE WF
USE WF

CREATE TABLE Lojas(
   ID_Loja INT,
   Nome_Loja VARCHAR(100),
   Regiao VARCHAR(100),
   Qtd_Vendida FLOAT
)

INSERT INTO LOJAS(ID_Loja, Nome_Loja, Regiao, Qtd_Vendida)
VALUES
   (1, 'Botafogo Praia&Mar', 'Sudeste', 1800),
   (2, 'Lojas Vitoria', 'Sudeste', 800),
   (3, 'Empórioi Mineirinho', 'Sudeste', 2300),
   (4, 'Central Paulista', 'Sudeste', 1800),
   (5, 'Rio 90 graus', 'Sudeste', 700),
   (6, 'Casa Flor & Anópolis', 'Sul', 2100),
   (7, 'Pampas & Co', 'Sul', 990),
   (8, 'Paraná Papéis', 'Sul', 2800),
   (9, 'Amazonas Prime', 'Norte', 4200),
   (10, 'Pará Bens', 'Norte', 3200),
   (11, 'Tintas Rio Branco', 'Norte', 1500),
   (12, 'Nordestemido Hall', 'Nordeste', 1910),
  (13, 'Cachoerinha Loft', 'Nordeste', 2380)

SELECT * FROM LOJAS

-- OVER AND PARTITION BY

SELECT
	*,
	MAX(Qtd_Vendida) OVER(PARTITION BY Regiao) as 'Max_Stores_by_Region' 
FROM LOJAS
ORDER BY Regiao

-- PRACTICING

-- 1 a)
SELECT
	*,
	FORMAT((SUM(Qtd_Vendida) OVER(PARTITION BY ID_Loja))/SUM(Qtd_Vendida) OVER(), '0.00%')  as 'Sales_by_store'
FROM LOJAS
ORDER BY ID_Loja

-- 1 b)
SELECT
	*,
	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Regiao', 
	SUM(Qtd_Vendida) OVER(PARTITION BY ID_Loja) AS 'by_ID_Loja',
	FORMAT((SUM(Qtd_Vendida) OVER(PARTITION BY ID_Loja))/SUM(Qtd_Vendida) OVER(PARTITION BY Regiao), '0.00%') as 'Max_Stores_by_Region' 
FROM LOJAS
ORDER BY ID_Loja


-- Funções de Janela
-- Funções de Classificação: ROW_NUMBER, RANK, DENSE_RANK, NTILE


SELECT
	*,
	-- ROW_NUMBER() : SET ROW NUMBERS FOR A CRITERIA. REPEATED DATA WON'T HAVE SPECIAL TREATMENT
	ROW_NUMBER() OVER(ORDER BY Qtd_Vendida DESC) AS 'rownumber',
	-- RANK(): DUPLICATED VALUES WILL HAVE DUPLICATED HANKS AND CHANGE IN THE SEQUENTIAL ORDER (1-2-2-4)
	RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'rank',
	-- DENSE_RANK():  DUPLICATED VALUES WILL HAVE DUPLICATED HANKS BUT THERE'S NO CHANGE IN THE SEQUENTIAL ORDER (1-2-2-3)
	DENSE_RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'dense',
	-- SEPARATES DATA IN N CLASSES (OR GROUPS, OR TILES)
	NTILE(3) OVER(ORDER BY Qtd_Vendida DESC) AS 'ntile'
FROM
	Lojas
WHERE Regiao = 'Sudeste'
--ORDER BY Qtd_Vendida DESC


SELECT
	*,
	-- ROW_NUMBER() : SET ROW NUMBERS FOR A CRITERIA. REPEATED DATA WON'T HAVE SPECIAL TREATMENT
	ROW_NUMBER() OVER(ORDER BY Qtd_Vendida DESC) AS 'rownumber',
	-- RANK(): DUPLICATED VALUES WILL HAVE DUPLICATED HANKS AND CHANGE IN THE SEQUENTIAL ORDER (1-2-2-4)
	RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'rank',
	-- DENSE_RANK():  DUPLICATED VALUES WILL HAVE DUPLICATED HANKS BUT THERE'S NO CHANGE IN THE SEQUENTIAL ORDER (1-2-2-3)
	DENSE_RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'dense',
	-- SEPARATES DATA IN N CLASSES (OR GROUPS, OR TILES)
	NTILE(3) OVER(ORDER BY Qtd_Vendida DESC) AS 'ntile'
FROM
	Lojas
WHERE Regiao = 'Sudeste'
--ORDER BY Qtd_Vendida DESC


SELECT
	Regiao,
	SUM(Qtd_Vendida) as 'Total_amount',
	RANK() OVER(ORDER BY SUM(Qtd_Vendida) DESC) AS 'ranking'
FROM
	Lojas
GROUP BY Regiao
ORDER BY [Total_amount] DESC 


-- Funções de Janela
-- Cálculo de soma móvel e média móvel

CREATE TABLE Resultado(
Data_Fechamento DATETIME,
Faturamento_MM FLOAT)


INSERT INTO Resultado(Data_Fechamento, Faturamento_MM)
VALUES
	('01/01/2020', 8),
	('01/02/2020', 10),
	('01/03/2020', 6),
	('01/04/2020', 9),
	('01/05/2020', 5),
	('01/06/2020', 4),
	('01/07/2020', 7),
	('01/08/2020', 11),
	('01/09/2020', 9),
	('01/10/2020', 12),
	('01/11/2020', 11),
	('01/12/2020', 10)

SELECT * FROM Resultado


-- Soma móvel -- CURRENT ROW

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS 'Fat. Acumulado (em milhões)'
FROM Resultado
ORDER BY [Data do Fechamento]


-- Média móvel -- CURRENT ROW

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	AVG(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS 'Fat. Acumulado (em milhões)'
FROM Resultado
ORDER BY [Data do Fechamento]


-- Soma móvel dos N anteriores
-- ao inves de pegar um numero especifico de linhas anteriores 
-- a linha atual, usamos UNBOUNDED

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Fat. Acumulado (em milhões)'
FROM Resultado
ORDER BY [Data do Fechamento]

-- Soma móvel -- 1 FOLLOWING

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS 'Fat. Acumulado (em milhões)'
FROM Resultado
ORDER BY [Data do Fechamento]


-- Média móvel -- 1 FOLLOWING

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	AVG(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS 'Fat. Acumulado (em milhões)'
FROM Resultado
ORDER BY [Data do Fechamento]

-- Funções de Janela
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
DROP IF EXISTS vwHistoricoLojas

CREATE VIEW vwHistoricoLojas AS (
	ID INT,
	ANO INT, 
	MES VARCHAR(20),
	QTD_LOJAS INT
)

GO
CREATE VIEW vwHistoricoLojas AS
SELECT
	RANK() OVER(ORDER BY YEAR(S.OpenDate),  MONTH(S.OpenDate) ) as 'ID',
	YEAR(OpenDate) as 'ANO',
	DATENAME(MONTH, OpenDate) AS 'MES',
	COUNT(OpenDate) OVER()
FROM 
	DimStore AS S
INNER JOIN DimDate AS D
	ON D.CalendarYear = YEAR(S.OpenDate)
	AND MONTH(D.Datekey) = MONTH(S.OpenDate)
--WHERE YEAR(OpenDate) >= 2004
GO
/*
	ID INT,
	ANO INT, 
	MES VARCHAR(20),
	QTD_LOJAS INT
)

	CONCAT(YEAR(S.OpenDate),FORMAT(S.OpenDate, 'MM')) AS 'STORE',
	D.CalendarMonth AS 'DATE',
	S.*
PARTITION BY YEAR(D.Datekey),  MONTH(D.Datekey)

*/

SELECT
	RANK() OVER(ORDER BY Datekey) as 'ID',
	YEAR(Datekey) as 'ANO',
	DATENAME(MONTH, Datekey) AS 'MES',
	ISNULL(S.QTD_OpenDate, 0)
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
			WHERE DAY(Datekey) = 01) AS D
	ON D.CalendarMonth = S.OpenDate













