
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
BEGIN TRANSACTION T1
DELETE 
FROM clientes_aux
WHERE id_cliente = 1

SELECT * FROM clientes_aux

COMMIT TRANSACTION T1

SELECT * FROM clientes_aux

-- will return an error message
ROLLBACK TRANSACTION T1

SELECT * FROM clientes_aux


-- EXAMPLE 3: UPDATE TRANSACTION AND ROLLBACK AND (attempt to) COMMIT TRANSACTION
BEGIN TRAN T2
UPDATE clientes_aux
SET CPF = '000.000.000-01'
WHERE id_cliente = 2

SELECT * FROM clientes_aux

ROLLBACK TRAN T2

SELECT * FROM clientes_aux

-- will return an error message
COMMIT TRAN T2

SELECT * FROM clientes_aux

/*CONDITIONAL INSERT*/

DECLARE @cpf_insert VARCHAR(20) = '193.174.192-82'
BEGIN TRANSACTION T3
INSERT INTO clientes_aux(Nome_Cliente, Genero, Data_de_Nascimento,  CPF)
	VALUES('Testing Guy', 'M', '19990909', @cpf_insert)

DECLARE @cpf_check VARCHAR(20) = (SELECT count(*) from clientes_aux WHERE CPF = @cpf_insert)
SELECT @cpf_check

IF @cpf_check> 1 -- only save unique cpfs
	BEGIN
	ROLLBACK TRAN T3
	END
ELSE 
	BEGIN
	COMMIT TRAN T3
	END

SELECT * FROM clientes_aux
