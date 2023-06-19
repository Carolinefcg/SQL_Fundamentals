
-- CRUD


-- CREATE
CREATE DATABASE BDImpressionador
GO
USE BDImpressionador

CREATE TABLE Produtos(
	id_produto INT, 
	nome_produto VARCHAR(200),
	data_validade DATETIME,
	preco_produto FLOAT
)
SELECT * FROM Produtos

-- INSERT USING SELECT
INSERT INTO Produtos(id_produto, nome_produto, data_validade, preco_produto)
SELECT
	ProductKey,
	ProductName,
	AvailableForSaleDate,
	UnitPrice
FROM
	ContosoRetailDW.dbo.DimProduct

SELECT * FROM Produtos

-- INSERT USING VALUES
DROP TABLE Produtos
GO
INSERT INTO Produtos(id_produto, nome_produto, data_validade, preco_produto)
VALUES
	(1, 'Arroz', '12/07/2023', 5.99),
	(2, 'Paçoca', '04/09/2023', 7.99)
GO

-- READ
select * from Produtos;
GO

-- UPDATE
UPDATE Produtos
SET nome_produto = 'Feijao'
WHERE id_produto = 1

select * from Produtos;

-- DELETE
DELETE
FROM Produtos
WHERE id_produto = 1
select * from Produtos;

DROP TABLE Produtos
DROP DATABASE BDImpressionador


--------------------------------------------------------------------

USE BDImpressionador

-- DROP TABLE Funcionarios

CREATE TABLE Funcionarios(
	id_funcionario int,
	nome_funcionario varchar(100),
	salario float,
	data_nascimento DATETIME
)

INSERT INTO Funcionarios(id_funcionario, nome_funcionario, salario, data_nascimento)
VALUES
	(1, 'Lucas'		, 1500, '19900320'),
	(2, 'Andressa'	, 2300, '19881207'),
	(3, 'Felipe'	, 4000, '19930213'),
	(4, 'Marcelo'	, 7100, '19930410'),
	(5, 'Carla'		, 3200, '19860902'),
	(6, 'Juliana'	, 5500, '19890121'),
	(7, 'Mateus'	, 1900, '19931102'),
	(8, 'Sandra'	, 3900, '19900509'),
	(9, 'André'		, 1000, '19940313'),
	(10, 'Julio'	, 4700, '19920705')

SELECT * FROM Funcionarios

-- ALTER TABLE

-- ADD COLUMN
GO
ALTER TABLE Funcionarios
ADD cargo VARCHAR(100), bonus FLOAT
GO

UPDATE Funcionarios
SET CARGO = 'Analista', bonus = 0.15
WHERE id_funcionario = 1

SELECT * FROM Funcionarios


-- ALTER DATA TYPE
GO
ALTER TABLE Funcionarios
ALTER COLUMN salario INT
GO
-- DROP COLUMN
ALTER TABLE Funcionarios
DROP COLUMN	cargo, bonus

SELECT * FROM Funcionarios

