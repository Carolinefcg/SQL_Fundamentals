# LCASE : LOWERCASE
# UCASE: UPPERCASE

SET 
@nome = 'Caroline',
@sobrenome = 'Ferreira da Cruz',
@ultimo_nome = 'Gomes' ,
@nome_completo = CONCAT(@nome,' ',@sobrenome,' ',@ultimo_nome),
@nome_completo2 = CONCAT_WS(' ', @nome,@sobrenome,@ultimo_nome); # usa um separador

SELECT lcase(@nome_completo), ucase(@nome_completo2);