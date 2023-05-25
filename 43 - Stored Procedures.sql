-- Sintaxe 

/*
DELIMITER $$
CREATE PROCEDURE (param1 tipo1, param2 tipo2)
BEGIN
	DECLARE var1 tipo1;
	DECLARE var1 tipo1;
    
    instrucoes1;
	instrucoes2;
	instrucoes3;
END $$

DELIMITER ;
*/


# Exemplo 1

DELIMITER $$
CREATE PROCEDURE sp_Att_Curso(preco DECIMAL(10,2), id INT)
BEGIN
    
	UPDATE dCursos
    SET Preco_Curso = preco
    WHERE ID_Curso = id;
    
    -- Mensagem de confirmacao
    SELECT CONCAT('Curso de id (',id, ') foi atualizado com sucesso!') as '';
    
END $$
DELIMITER ;


DROP PROCEDURE sp_Att_Curso;

-- COMO USAR UMA PROCEDURE
CALL sp_Att_Curso(400, 1);

SELECT * FROM dCursos;

# Exemplo 1

DELIMITER $$
CREATE PROCEDURE sp_Desconto_Curso(id INT, desconto DECIMAL(4,2))
BEGIN
	-- 1º) Declarar variáveis
    
    DECLARE Nome VARCHAR(100);
    DECLARE Preco_antigo DECIMAL(10, 2);
    DECLARE Preco_novo DECIMAL(10,2);
    
    -- 2º) Set nas variáveis
	SET Nome = (SELECT Nome_Curso FROM dCursos WHERE ID_Curso = id),
		Preco_antigo = (SELECT Preco_Curso FROM dCursos WHERE ID_Curso = id),
        Preco_novo = Preco_antigo*(1- desconto); -- subquery
		
    -- 3º Atualizar tabela
	UPDATE dCursos
    SET Preco_Curso = Preco_novo
    WHERE ID_Curso = id;
    
    -- Mensagem de confirmacao
    SELECT CONCAT('Curso (',Nome, ') foi atualizado com sucesso!') as '',
    CONCAT('Desconto de ',desconto*100,'% aplicado') as '',
    CONCAT('De: R$ ',Preco_antigo, ' Para: R$ ', Preco_novo) as '';
    
END $$
DELIMITER ;

DROP PROCEDURE sp_Desconto_Curso;

CALL sp_Desconto_Curso(1, 0.05);

SELECT * FROM dCursos;