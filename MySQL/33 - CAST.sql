# CAST

# A função CAST converte um valor de qualquer tipo em outro tipo de dado especificado

-- Obs: no CAST,
-- INT é SIGNED quando são valores inteiros
-- INT É UNSIGNED quando são valores inteiros positivos
-- VARCHAR é o CHAR

# Exemplo

SET @varNumero = 10.924;

SELECT @varNumero,
	CAST(@varNumero AS SIGNED),
	CAST(@varNumero AS DECIMAL(10,2)),
	CAST(@varNumero AS CHAR);

SET @varDATA = '2023-05-10';

SELECT @varDATA,
	CAST(@varDATA AS DATE),
	CAST(@varDATA AS DATETIME);