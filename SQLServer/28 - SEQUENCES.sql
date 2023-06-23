

CREATE SEQUENCE clients_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE -- OR: MAXVALUE 999
NO CYCLE


SELECT NEXT VALUE FOR clients_seq

DROP SEQUENCE clients_seq


-- EXAMPLE
CREATE SEQUENCE projects_seq
AS INT
START WITH 0
INCREMENT BY 5
MAXVALUE 25
NO CYCLE

CREATE TABLE dProjects(
	id_project INT,
	project_name VARCHAR(100),

	CONSTRAINT dprojects_id_projects_pk PRIMARY KEY(id_project)
)

INSERT INTO dProjects(id_project, project_name)
VALUES
		(NEXT VALUE FOR projects_seq, 'A'),
		(NEXT VALUE FOR projects_seq, 'B'),
		(NEXT VALUE FOR projects_seq, 'C')

SELECT * FROM dProjects

INSERT INTO dProjects(id_project, project_name)
VALUES
		(NEXT VALUE FOR projects_seq, 'D'),
		(NEXT VALUE FOR projects_seq, 'E')

SELECT * FROM dProjects

-- EXERCISE

-- 1

CREATE SEQUENCE cliente_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO CYCLE

CREATE SEQUENCE carro_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO CYCLE

CREATE SEQUENCE loca�oes_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO CYCLE






