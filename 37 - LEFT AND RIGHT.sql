# LEFT E RIGHT

SET @var = 'MySQL Workbech';

select 
LEFT(@var, 5) as 'left',
RIGHT(@var, 8) as 'right';


# Exemplo no bd

SELECT 
    Num_serie,
    LEFT(Num_serie, 3) AS 'LEFT',
    RIGHT(Num_serie, 6) AS 'RIGHT'
FROM
    produtos;