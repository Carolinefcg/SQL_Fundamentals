
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

--- EXERCISES

-- 1 A)
CREATE DATABASE BD_Teste
-- 1 B)
DROP DATABASE BD_Teste
-- 1 C)
CREATE DATABASE Exercicios

-- 2
USE Exercicios

CREATE TABLE dCliente(
	ID_Cliente INT, 
	Nome_Cliente VARCHAR(100),
	Data_de_Nascimento DATE)

SELECT * FROM dCliente;

CREATE TABLE dGerente(
	ID_Gerente INT, 
	Nome_Gerente VARCHAR(100),
	Data_de_Contratacao DATE,
	Salario FLOAT)

SELECT * FROM dGerente;



CREATE TABLE fContratos(
	ID_Contrato INT, 
	Data_de_Assinatura DATE,
	ID_Cliente INT, 
	ID_Gerente INT, 
	Valor_do_Contrato FLOAT)

SELECT * FROM fContratos;

-- 3
INSERT INTO dCliente(ID_Cliente, Nome_Cliente, Data_de_Nascimento)
	VALUES
	(1, 'André Martins',	'19890212'),
	(2, 'Bárbara Campos',	'19920507'),
	(3, 'Carol Freitas',	'19850423'),
	(4, 'Diego Cardoso',	'19941011'),
	(5, 'Eduardo Pereira',	'19881109'),
	(6, 'Fabiana Silva',	'19890902'),
	(7, 'Gustavo Barbosa',	'19930627'),
	(8, 'Helen Viana',		'19900211')

SELECT * FROM dCliente

INSERT INTO dGerente(ID_Gerente, Nome_Gerente, Data_de_Contratacao, Salario)
	VALUES
	(1, 'Lucas Sampaio',	'20150321',	6700),
	(2, 'Mariana Padilha',	'20110110',	9900),
	(3, 'Nathália Santos',	'20181003',	7200),
	(4, 'Otávio Costa',	'20170418',	11000)

SELECT * FROM dGerente

INSERT INTO fContratos(ID_Contrato, Data_de_Assinatura, ID_Cliente, ID_Gerente, Valor_do_Contrato)
	VALUES
	(1, '20190112',	8,	1,	23000),
	(2, '20190210',	3,	2,	15500),
	(3, '20190307',	7,	2,	6500),
	(4, '20190315',	1,	3,	33000),
	(5, '20190321',	5,	4,	11100),
	(6, '20190323',	4,	2,	5500),
	(7, '20190328',	9,	3,	55000),
	(8, '20190404',	2,	1,	31000),
	(9, '20190405',	10,	4,	3400),
	(10,'20190405',	6,	2,	9200)

SELECT * FROM fContratos

-- 4
INSERT INTO dCliente(ID_Cliente, Nome_Cliente, Data_de_Nascimento)
	VALUES
	(9, 'André Tins',	'19890213')

INSERT INTO dGerente(ID_Gerente, Nome_Gerente, Data_de_Contratacao, Salario)
	VALUES
	(5, 'Lucas Cruz',	'20150321',	6705)

INSERT INTO fContratos(ID_Contrato, Data_de_Assinatura, ID_Cliente, ID_Gerente, Valor_do_Contrato)
	VALUES
	(11, '20190113',	7,	5,	26000)

-- 5
UPDATE fContratos
SET Data_de_Assinatura = '20190317',
	ID_Gerente = 2,
	Valor_do_Contrato = 33500
WHERE ID_Contrato = 4

select * from fContratos




