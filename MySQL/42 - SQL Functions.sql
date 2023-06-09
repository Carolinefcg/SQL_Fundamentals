# Sintaxe

/*

DELIMITER $$

CREATE FUNCTION nome_funcao(param1 tipo1, param2 tipo2)
RETURNS tipo DETERMINISTIC
BEGIN
	instrucoes1;
	instrucoes2;
	instrucoes3;
	RETURN expressao
END $$

DELIMITER;


/*
SELECT nome_funcao(valor1, valor2);
*/

USE db_exemplo;
# Exemplo 1

DELIMITER $$

CREATE FUNCTION fn_BoasVindas(nome VARCHAR(100))
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	RETURN CONCAT('Olá ',nome, ', tudo bem?');
END $$

DELIMITER ;

SELECT fn_BoasVindas('CFCG');

# Exemplo 2

DELIMITER $$
CREATE FUNCTION fn_Faturamento(preco DECIMAL(10,2), qtd INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	RETURN preco*qtd;
END $$
DELIMITER ;

SELECT fn_Faturamento(9.99,100);


# Exemplo 3

DELIMITER $$
CREATE FUNCTION fn_RemoveAcentos(texto VARCHAR(100))
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	SET texto = REPLACE(texto,	'á',	'a'),
		texto = REPLACE(texto,	'é',	'e'),
        texto = REPLACE(texto,	'í',	'i'),
        texto = REPLACE(texto,	'ó',	'o'),
        texto = REPLACE(texto,	'ú',	'u'),
        texto = REPLACE(texto,	'à',	'a'),
		texto = REPLACE(texto,	'è',	'e'),
        texto = REPLACE(texto,	'ì',	'i'),
        texto = REPLACE(texto,	'ò',	'o'),
        texto = REPLACE(texto,	'ù',	'u'),
        texto = REPLACE(texto,	'Á',	'A'),
        texto = REPLACE(texto,	'É',	'E'),
        texto = REPLACE(texto,	'Í',	'I'),
        texto = REPLACE(texto,	'Ó',	'O'),
        texto = REPLACE(texto,	'Ú',	'U'),
        texto = REPLACE(texto,	'À',	'A'),
        texto = REPLACE(texto,	'È',	'E'),
        texto = REPLACE(texto,	'Ì',	'I'),
        texto = REPLACE(texto,	'Ò',	'O'),
        texto = REPLACE(texto,	'Ù',	'U'),
		texto = REPLACE(texto,	'â',	'a'),
		texto = REPLACE(texto,	'ê',	'e'),
        texto = REPLACE(texto,	'î',	'i'),
        texto = REPLACE(texto,	'ô',	'o'),
        texto = REPLACE(texto,	'û',	'u'),
        texto = REPLACE(texto,	'Â',	'A'),
        texto = REPLACE(texto,	'Ê',	'E'),
        texto = REPLACE(texto,	'Î',	'I'),
        texto = REPLACE(texto,	'Ô',	'O'),
        texto = REPLACE(texto,	'Û',	'U'),
        texto = REPLACE(texto,	'ã',	'a'),
        texto = REPLACE(texto,	'õ',	'o'),
        texto = REPLACE(texto,	'Ã',	'A'),
        texto = REPLACE(texto,	'Õ',	'O'),
        texto = REPLACE(texto,	'ç',	'c'),
        texto = REPLACE(texto,	'Ç',	'C');
	RETURN texto;
END $$
DELIMITER ;

SELECT 
Loja,
Endereco,
fn_RemoveAcentos(Endereco)
from base.lojas;


-- para alterar a função, use o próprio MySQL
-- clique com o botao direito na funcao e escolha 'Alter function'