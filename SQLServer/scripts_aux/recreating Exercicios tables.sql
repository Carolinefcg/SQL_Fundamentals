





-- Tabela 1: dCliente

-- A tabela dCliente deve conter as seguintes colunas:

-- Coluna 1: id_cliente do tipo INT     --> Chave Primária e deve ser auto incrementada
-- Coluna 2: nome_cliente do tipo VARCHAR  --> Não aceita valores nulos
-- Coluna 3: genero VARCHAR         --> Não aceita valores nulos e devem ser ('M', 'F', 'O', 'PND')
-- Coluna 4: data_nascimento DATE      --> Não aceita valores nulos  
-- Coluna 5: cpf do tipo VARCHAR       --> Não aceita valores duplicados nem valores nulos


CREATE TABLE dCliente(
id_cliente INT IDENTITY(1, 1), --COMEÇA DE 1 UM E INCREMENTA EM 1 UM 
nome_cliente VARCHAR(100) NOT NULL, -- NOT NUL NÃO PODE TER VALORES NULOS
genero VARCHAR(100) NOT NULL,
data_de_nascimento DATE NOT NULL,
cpf VARCHAR(100) NOT NULL,
CONSTRAINT dcliente_id_cliente_pk PRIMARY KEY(id_cliente),
CONSTRAINT dcliente_genero CHECK(Genero IN ('M', 'F', 'O', 'PND')), --PRECISA SER ESTE VALORES EM CHECK
CONSTRAINT dcliente_cpf_un UNIQUE(cpf) --NÃO PODE TER VALORES REPETIDOS
)

INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF)
VALUES
('André Martins', 'M', '12/02/1989', '839.283.190-00'),
('Bárbara Campos', 'F', '07/05/1992', '351.391.410-02'),
('Carol Freitas', 'F', '23/04/1985', '139.274.921-12'),
('Diego Cardoso',  'M', '11/10/1994', '192.371.081-17'),
('Eduardo Pereira', 'M', '09/11/1988', '193.174.192-82'),
('Fabiana Silva', 'F', '02/09/1989', '231.298.471-98'),
('Gustavo Barbosa', 'M', '27/06/1993', '240.174.171-76'),
('Helen Viana',  'F', '11/02/1990', '193.129.183-01'),
('Igor Castro',  'M', '21/08/1989', '184.148.102-29'),
('Juliana Pires',  'F', '13/01/1991', '416.209.192-47')



SELECT * FROM dCliente


-- Tabela 2: dGerente

-- A tabela dGerente deve conter as seguintes colunas:

-- Coluna 1: id_gerente do tipo INT      --> Chave Primária e auto incrementada
-- Coluna 2: nome_gerente do tipo VARCHAR   --> Não aceita valores nulos
-- Coluna 3: data_contratacao VARCHAR     --> Não aceita valores nulos
-- Coluna 4: salario do tipo FLOAT       --> Não aceita valores nulos nem abaixo de zero


CREATE TABLE dGerente(
id_gerente INT IDENTITY(1, 1),
nome_gerente VARCHAR(100) NOT NULL,
data_contratacao VARCHAR(100) NOT NULL,
salario FLOAT NOT NULL,
CONSTRAINT dgerente_id_gerente_pk PRIMARY KEY(id_gerente),
CONSTRAINT dgerente_salario_ck CHECK(salario > 0)
)



INSERT INTO dGerente(Nome_Gerente, Data_Contratacao, Salario)
VALUES
('Lucas Sampaio',  '21/03/2015', 6700),
('Mariana Padilha', '10/01/2011', 9900),
('Nathália Santos', '03/10/2018', 7200),
('Otávio Costa',  '18/04/2017', 11000)


SELECT * FROM dGerente




-- Tabela 3: fContratos

-- A tabela fContratos deve conter as seguintes colunas:

-- Coluna 1: id_contrato do tipo INT      --> Chave Primária e auto incremental
-- Coluna 2: data_assinatura do tipo DATE   --> Valor Padrão (GETDATE) caso não seja preenchida
-- Coluna 3: id_cliente do tipo INT      --> Chave Estrangeira
-- Coluna 4: id_gerente do tipo INT      --> Chave Estrangeira
-- Coluna 5: valor_contrato do tipo FLOAT   --> Não aceita valores nulos e deve ser maior que zero


CREATE TABLE fContratos(
id_contrato INT IDENTITY(1, 1),
data_assinatura DATE DEFAULT GETDATE(),
id_cliente INT,
id_gerente INT,
valor_contrato FLOAT,
CONSTRAINT fcontratos_id_contrato_pk PRIMARY KEY(id_contrato),
CONSTRAINT fcontratos_id_cliente_fk FOREIGN KEY(id_cliente) REFERENCES dCliente(id_cliente),
CONSTRAINT fcontratos_id_gerente_fk FOREIGN KEY(id_gerente) REFERENCES dGerente(id_gerente),
CONSTRAINT fcontratos_valor_contrato_ck CHECK(valor_contrato > 0)
)

INSERT INTO fContratos(Data_Assinatura, ID_Cliente, ID_Gerente, Valor_Contrato)
VALUES
('12/01/2019', 8, 1, 23000),
('10/02/2019', 3, 2, 15500),
('07/03/2019', 7, 2, 6500),
('15/03/2019', 1, 3, 33000),
('21/03/2019', 5, 4, 11100),
('23/03/2019', 4, 2, 5500),
('28/03/2019', 9, 3, 55000),
('04/04/2019', 2, 1, 31000),
('05/04/2019', 10, 4, 3400),
('05/04/2019', 6, 2, 9200)


SELECT * FROM fContratos