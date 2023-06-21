
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
################# C�digo para Cria��o da Tabela Lojas #####################
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
   (3, 'Emp�rioi Mineirinho', 'Sudeste', 2300),
   (4, 'Central Paulista', 'Sudeste', 1800),
   (5, 'Rio 90 graus', 'Sudeste', 700),
   (6, 'Casa Flor & An�polis', 'Sul', 2100),
   (7, 'Pampas & Co', 'Sul', 990),
   (8, 'Paran� Pap�is', 'Sul', 2800),
   (9, 'Amazonas Prime', 'Norte', 4200),
   (10, 'Par� Bens', 'Norte', 3200),
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


-- Fun��es de Janela
-- Fun��es de Classifica��o: ROW_NUMBER, RANK, DENSE_RANK, NTILE


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


-- Fun��es de Janela
-- C�lculo de soma m�vel e m�dia m�vel

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


-- Soma m�vel -- CURRENT ROW

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milh�es)',
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS 'Fat. Acumulado (em milh�es)'
FROM Resultado
ORDER BY [Data do Fechamento]


-- M�dia m�vel -- CURRENT ROW

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milh�es)',
	AVG(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS 'Fat. Acumulado (em milh�es)'
FROM Resultado
ORDER BY [Data do Fechamento]


-- Soma m�vel dos N anteriores
-- ao inves de pegar um numero especifico de linhas anteriores 
-- a linha atual, usamos UNBOUNDED

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milh�es)',
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Fat. Acumulado (em milh�es)'
FROM Resultado
ORDER BY [Data do Fechamento]

-- Soma m�vel -- 1 FOLLOWING

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milh�es)',
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS 'Fat. Acumulado (em milh�es)'
FROM Resultado
ORDER BY [Data do Fechamento]


-- M�dia m�vel -- 1 FOLLOWING

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milh�es)',
	AVG(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS 'Fat. Acumulado (em milh�es)'
FROM Resultado
ORDER BY [Data do Fechamento]

-






