
# SOLUÇÕES USANDO SUBQUERIES

# Exemplo 1: Quais pedidos foram feitos onde o Marcelo Castro é o gerente?
SELECT *
FROM base.pedidos
WHERE ID_Loja = (
				SELECT ID_Loja
                FROM base.lojas
                WHERE Gerente = 'Marcelo Castro');

