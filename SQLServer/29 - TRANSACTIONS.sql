
USE Exercicios

-- Creates clientes_aux table
SELECT *
INTO clientes_aux
from dCliente

select * from clientes_aux

/*
TRANSACTION COMMANDS

BEGIN TRANSACTION
ROLLBACK TRANSACTION -- deletes a transaction that was previously done
COMMIT TRANSACTION -- apply transaction changes in a permanent way
*/

-- EXAMPLE 1: INSERT INTO TRANSACTION AND ROLLBACK TRANSACTION

BEGIN TRANSACTION
INSERT INTO clientes_aux(Nome_Cliente, Genero, Data_de_Nascimento, CPF)
	VALUES('Testing Guy', 'M', '19990909', '123.123.123-12')

SELECT * FROM clientes_aux

ROLLBACK TRANSACTION

SELECT * FROM clientes_aux

-- EXAMPLE 2: DELETE TRANSACTION AND COMMIT TRANSACTION AND (attempt to) ROLLBACK
BEGIN TRANSACTION
DELETE 
FROM clientes_aux
WHERE id_cliente = 1

SELECT * FROM clientes_aux

COMMIT TRANSACTION

SELECT * FROM clientes_aux

-- will return an error message
ROLLBACK TRANSACTION

SELECT * FROM clientes_aux


-- EXAMPLE 3: UPDATE TRANSACTION AND ROLLBACK AND (attempt to) COMMIT TRANSACTION


