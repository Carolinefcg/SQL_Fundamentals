# REPLACE

# Exemplo no bd

SELECT 
    Nome,
    Estado_Civil,
    REPLACE(REPLACE(Estado_Civil, 'S', 'Solteiro'),
        'C',
        'Casado') as 'Estado_Civil_ajus'
FROM
    clientes;