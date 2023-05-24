

# C reate
# R ead
# U pdate
# D elete

#####################################################################
# CREATE DATABASE

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
#####################################################################
# CREATE TABLE

CREATE TABLE IF NOT EXISTS dAlunos(
ID_Aluno INT,
Nome_Aluno VARCHAR(100) NOT NULL,
Email VARCHAR(100) NOT NULL,
PRIMARY KEY(ID_Aluno)
);

CREATE TABLE IF NOT EXISTS dCursos(
ID_Curso INT,
Nome_Curso VARCHAR(100) NOT NULL,
Preco_Curso DECIMAL(10,2) NOT  NULL, -- 99999999,99
PRIMARY KEY(ID_Curso)
);

CREATE TABLE IF NOT EXISTS fMatriculas(
ID_Matricula INT,
ID_Aluno INT NOT NULL,
ID_Curso INT NOT NULL,
Data_Cadastro DATE NOT NULL,
PRIMARY KEY(ID_Matricula),
FOREIGN KEY (ID_Aluno) REFERENCES dAlunos(ID_Aluno),
FOREIGN KEY (ID_Curso) REFERENCES dCursos(ID_Curso)
);

SHOW TABLES;

# INSERT INTO

INSERT INTO dAlunos(ID_Aluno, Nome_Aluno, Email)
VALUES
	(1,	'Ana'	,	'ana123@gmail.com'			),
	(2,	'Bruno'	,	'bruno_vargas@outlook.com'			),
	(3,	'Carla'	,	'carlinha1999@gmail.com'			),
	(4,	'Diego'	,	'diicastroneves@gmail.com'			);
    
SELECT * FROM dAlunos;

INSERT INTO dCursos(ID_Curso, Nome_Curso, Preco_Curso)
VALUES
	(1,	'Excel'		,	100),
	(2,	'VBA'		,	200),
	(3,	'PowerBI'	,	150);
    
SELECT * FROM dCursos;

INSERT INTO fMatriculas(ID_Matricula, ID_Aluno, ID_Curso, Data_Cadastro)
VALUES
	(1,	1, 1, '2021/03/11'	),
	(2,	1, 2, '2021/06/21'	),
	(3,	2, 3, '2021/01/08'	),
	(4,	3, 1, '2021/04/03'	),
	(5,	4, 1, '2021/05/10'	),
	(6,	4, 3, '2021/05/10'	);
    
SELECT * FROM fMatriculas;

# UPDATE

UPDATE dCursos
SET Preco_Curso = 300
where ID_Curso = 1;

SELECT 
    *
FROM
    dCursos;
    
    
# DELETE

DELETE FROM fMatriculas
WHERE ID_Matricula = 6;

SELECT * FROM fMatriculas;


# TRUNCATE TABLE VS. DROP TABLE

# TRUNCATE TABLE: exclui todos os registros de uma tabela
# DROP TABLE: exclui uma tabela

SELECT * FROM fMatriculas;
TRUNCATE TABLE fMatriculas;
DROP TABLE fMatriculas;