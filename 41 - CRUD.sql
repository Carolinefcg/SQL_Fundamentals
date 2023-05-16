

# C reate
# R ead
# U pdate
# D elete

#####################################################################
# CREATE

CREATE DATABASE db_exemplo;
-- vs
CREATE DATABASE IF NOT EXISTS db_exemplo;

# O IF NOT EXISTS permite que a mensagem seja de 
# warning, não um erro
# esse mudança é valiosa em um processo automatizado
# uma vez que um erro interompe o processo inteiro
# warning não interompe nada, é só um aviso

-- Verificar banco de dados existentes
SHOW DATABASES;

-- Verificar está sendo usado no momento
SELECT DATABASE();

-- Colocar bd como o principal (em uso)
USE db_exemplo;

-- Excluir bd 
DROP DATABASE db_exemplo;



