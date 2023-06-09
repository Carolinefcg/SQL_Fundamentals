# CONCAT
# CONCAT_WS

SET 
@nome = 'Caroline',
@sobrenome = 'Ferreira da Cruz',
@ultimo_nome = 'Gomes' ,
@nome_completo = CONCAT(@nome,@sobrenome,@ultimo_nome),
@nome_completo2 = CONCAT_WS(' ', @nome,@sobrenome,@ultimo_nome); # usa um separador

SELECT @nome_completo, @nome_completo2;