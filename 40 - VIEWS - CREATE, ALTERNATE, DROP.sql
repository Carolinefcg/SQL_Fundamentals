

-- CREATE VIEW

SELECT 
    *
FROM
    CLIENTES;

CREATE VIEW vwClientes AS
    SELECT 
        ID_Cliente,
        Nome,
        Data_Nascimento, 
        Email,
        Telefone
    FROM
        clientes;
        
        
-- ALTER VIEW

ALTER VIEW vwClientes AS
    SELECT 
        ID_Cliente,
        Nome, 
        Data_Nascimento, 
        Email,
        Telefone,
        Escolaridade
    FROM
        clientes
	WHERE Escolaridade = 'Parcial';
    
select * from vwclientes;


# Exemplo 1

CREATE VIEW vwProdutosAtualizada AS
SELECT * 
from produtos;       

ALTER VIEW vwProdutosAtualizada AS
SELECT * 
from produtos
WHERE Marca_Produto in ('DELL', 'SAMSUNG', 'SONY');

SELECT * FROM vwprodutosatualizada;

#####################################################################

# Exemplo 2

CREATE VIEW vwReceitaECustoTotal AS
    SELECT 
        ID_Pedido,
        SUM(Receita_Venda) AS 'Total receita',
        SUM(Custo_Venda) AS 'Total custo'
    FROM
        pedidos
    WHERE
        ID_Loja = 2
    GROUP BY ID_Pedido;
    

ALTER VIEW vwReceitaECustoTotal AS
    SELECT 
        ID_Produto,
        SUM(Receita_Venda) AS 'Total receita',
        SUM(Custo_Venda) AS 'Total custo'
    FROM
        pedidos
    WHERE
        ID_Loja = 2
    GROUP BY ID_Produto
	HAVING SUM(Receita_Venda) >= 1000000;
    
    SELECT * FROM vwreceitaecustototal;
    
#####################################################################

# Exemplo 3

CREATE VIEW vwProdutosEPedidos AS
    SELECT 
        pe.*, pr.Nome_Produto, pr.Marca_Produto, pr.Num_Serie
    FROM
        pedidos AS pe
            iNNER JOIN
        produtos AS pr
        on pe.ID_Produto = pr.ID_Produto;
select * from vwProdutosEPedidos;

#####################################################################

# Exemplo 4


CREATE VIEW vwReceitasECustosProduto AS
    SELECT 
        pr.Nome_Produto,
        SUM(pe.Receita_Venda) AS 'Total receita',
        SUM(pe.Custo_Venda) AS 'Total custo'
    FROM
        pedidos as pe
	INNER JOIN produtos as pr
    ON pe.ID_Produto = pr.ID_Produto
    GROUP BY pr.Nome_Produto;
    
select * from vwReceitasECustosProduto;