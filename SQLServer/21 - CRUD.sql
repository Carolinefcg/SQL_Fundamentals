
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