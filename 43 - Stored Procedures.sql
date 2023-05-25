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
	DECLARE nome_curso VARCHAR(100);
    
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