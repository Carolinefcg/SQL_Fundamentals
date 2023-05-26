
# SOLUÇÕES USANDO SUBQUERIES

# Exemplo 1: Quais pedidos foram feitos onde o Marcelo Castro é o gerente?
SELECT *
FROM base.pedidos
WHERE ID_Loja = (
				SELECT ID_Loja
                FROM base.lojas
                WHERE Gerente = 'Marcelo Castro');

# Exemplo 2: produto com preço acima da média

SELECT 
    *
FROM
    base.produtos
WHERE Preco_Unit > (
					SELECT AVG(Preco_Unit) 
					FROM base.produtos);
                    
# Exemplo 3 (Desafio): Descubra qual foi o cliente que mais gerou receita para a empresa

use base;
select * from clientes;
select * from pedidos;


select c.*
from clientes as c
INNER JOIN (
select ID_Cliente, Receita
from (	select ID_Cliente, sum(Receita_Venda) as 'Receita'
		from pedidos
		group by ID_Cliente
	 ) as p
where Receita = (SELECT MAX(Receita) 
from (	select ID_Cliente, sum(Receita_Venda) as 'Receita'
		from pedidos
		group by ID_Cliente) as p
	 )
group by ID_Cliente) as pe
ON c.ID_Cliente = pe.ID_Cliente;



 -- Solução Hastag
 
 SELECT * 
 FROM clientes
 WHERE ID_Cliente = (
					SELECT ID_Cliente
                    FROM pedidos
                    GROUP BY ID_Cliente
                    ORDER BY SUM(Receita_Venda) DESC
                    LIMIT 1
                    );
 
 
 # Exemplo 3: receita total dos produtos da marca DELL
 SET @marca_prod = 'DELL';
 
SELECT SUM(Receita_Venda) as 'Receita total'
 FROM
    pedidos
WHERE
    ID_Produto IN (
				 SELECT ID_Produto
				 FROM produtos
				 WHERE Marca_Produto = @marca_prod
                 );
                 
# Exemplo 4: Quais pedidos foram feitos na região Sudeste


SELECT * from pedidos;
SELECT * from clientes;
SELECT * FROM lojas;
SELECT * from locais;

SET @regiao = 'Sudeste';
SELECT * 
FROM PEDIDOS
WHERE ID_Loja IN (
				SELECT ID_Loja
                FROM lojas
                WHERE Loja IN (
							SELECT Cidade
							FROM locais
							WHERE Região = @regiao
                            )
				);
                
# Exemplo 5: subquery como uma coluna

SELECT *,
		(
        SELECT AVG(Preco_Unit)
		FROM produtos
        ) as 'Media_Preco_Unit'
 FROM produtos;
 
 
 # Exemplo 6: Do total de vendas por produto, qual foi a quantidade máxima vendida?
 # e a quantidade mínima? e a média?
 
 select *  from pedidos;
 
select
MAX(Total_Qtd_Vendida) as 'Qtd_max',
MIN(Total_Qtd_Vendida) as 'Qtd_min',
AVG(Total_Qtd_Vendida) as 'Qtd_media'
from (
	select ID_Produto, SUM(Qtd_Vendida) as 'Total_Qtd_Vendida'
	from pedidos
	GROUP BY ID_Produto
    ) AS a;