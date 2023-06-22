

-- CONSTRAINS

USE Exercicios
DROP TABLE IF EXISTS  dCliente

CREATE TABLE dCliente(
	id_cliente INT IDENTITY(1,1),
	Nome_Cliente VARCHAR(100) NOT NULL,
	Genero VARCHAR(5) NOT NULL,
	Data_de_Nascimento DATE NOT NULL,
	CPF VARCHAR(20) NOT NULL

	CONSTRAINT dcliente_id_cliente_pk PRIMARY KEY(id_cliente),
	CONSTRAINT dcliente_genero_ck CHECK (Genero IN ('M', 'F', 'O', 'PND')),
	CONSTRAINT dcliente_cpf_un UNIQUE(CPF)
)

/*
INDETITIY(start, increment)
NOT NULL: does not allow null values in the column. The default is NULL

Best Pratices

CONSTRAINT table_column_rule THERULE(column)
*/

INSERT INTO dCliente (Nome_Cliente, Genero, Data_de_Nascimento, CPF)
VALUES
('André Martins',	'M',	'1989-02-12',	'839.283.190-00'),
('Bárbara Campos',	'F',	'1992-05-07',	'351.391.410-82'),
('Carol Freitas',	'F',	'1985-04-23',	'139.274.921-12'),
('Diego Cardoso',	'F',	'1994-10-11',	'192.371.081-17'),
('Eduardo Pereira',	'M',	'1988-11-09',	'193.174.192-82'),
('Fabiana Silva',	'F',	'1989-09-02',	'231.298.471-98'),
('Gustavo Barbosa',	'M',	'1993-06-27',	'240.174.171-76'),
('Helen Viana',		'F',	'1990-02-11',	'193.129.183-01'),
('Igor Castro',		'M',	'1989-08-21',	'184.148.102-29'),
('Juliana Pires',	'F',	'1991-01-13',	'416.209.192-47')


SELECT * FROM dCliente


DROP TABLE IF EXISTS dGerente

CREATE TABLE dGerente( 
		ID_Gerente INT IDENTITY (1, 1)
      ,Nome_Gerente VARCHAR(100) NOT NULL
      ,Data_de_Contratacao DATE NOT NULL
      ,Salario FLOAT NOT NULL,

	  CONSTRAINT dGerente_id_gerente_pk PRIMARY KEY(ID_Gerente),
	  CONSTRAINT dGerente_salario_ck CHECK(Salario > 0)
)

INSERT INTO dGerente(Nome_Gerente, Data_de_Contratacao, Salario)
	VALUES
	('Lucas Sampaio',	'20150321',	6700),
	('Mariana Padilha',	'20110110',	9900),
	('Nathália Santos',	'20181003',	7200),
	('Otávio Costa',	'20170418',	11000)


SELECT * FROM dGerente

DROP TABLE IF EXISTS fContratos

CREATE TABLE fContratos(
	ID_Contrato INT IDENTITY(1,1), 
	Data_de_Assinatura DATE DEFAULT GETDATE(),
	ID_Cliente INT, 
	ID_Gerente INT , 
	Valor_do_Contrato FLOAT,
	
	CONSTRAINT fcontratos_id_contrato_pk PRIMARY KEY(ID_Contrato),
	CONSTRAINT fcontratos_id_cliente_fk FOREIGN KEY(ID_Cliente) REFERENCES dCliente(id_cliente),
	CONSTRAINT fcontratos_id_gerente_fk FOREIGN KEY(ID_Gerente) REFERENCES dGerente(id_gerente),
	CONSTRAINT fcontratos_valor_contrato CHECK(Valor_do_Contrato > 0)
	)

INSERT INTO fContratos(Data_de_Assinatura, ID_Cliente, ID_Gerente, Valor_do_Contrato)
	VALUES
	('20190112',	8,	1,	23000),
	('20190210',	3,	2,	15500),
	('20190307',	7,	2,	6500),
	('20190315',	1,	3,	33000),
	('20190321',	5,	4,	11100),
	('20190323',	4,	2,	5500),
	('20190328',	9,	3,	55000),
	('20190404',	2,	1,	31000),
	('20190405',	10,	4,	3400),
	('20190405',	6,	2,	9200)

SELECT * FROM fContratos


-- EXAMPLE: VIOLOTATING CONSTRAINTS

-- 1: ADD NULL VALUE
INSERT INTO dCliente(Genero, Data_de_Nascimento, CPF)
	VALUES('F', '2016-04-01', '111.111.111-11')
-- 2: ADD NON UNIQUE VALUE
INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF)
	VALUES('Mr. Not Unique','F', '2016-04-01', '839.283.190-00')
-- 3: ADD NOT ALLOWED VALUE
INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF)
	VALUES('Mr. Not Allowed','Alien', '2016-04-01', '839.283.190-01')
-- : ADD FK VALUE THAT IS NOT IN THE FOREIGN TABLE
INSERT INTO fContratos(Data_de_Assinatura, ID_Cliente, ID_Gerente, Valor_do_Contrato)
	VALUES('20190112',	8,	999,	23000)
-- The manager 999 is not listed in dGerente Table


/*
MANAGING CONSTRAINTS
*/

-- REMOVING CONSTRAINTS
ALTER TABLE dCliente
DROP CONSTRAINT dcliente_genero_ck 

-- ADDING CONSTRAINTS
ALTER TABLE dCliente
ADD CONSTRAINT dcliente_genero_ck CHECK (Genero IN ('M', 'F', 'O', 'PND'))

