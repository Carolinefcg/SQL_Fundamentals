SET @myfirstvariable = 'DELL';

SELECT * 
FROM base.produtos
where Marca_Produto like @myfirstvariable;