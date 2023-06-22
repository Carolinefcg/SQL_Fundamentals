
-- CHECK YOUR SSMS COLLATE
SELECT SERVERPROPERTY('collation')

-- SPECIFY COLLATE WHEN CREATING A DATABASE
CREATE DATABASE BD_Collation
COLLATE Latin1_General_CI_AI

/*
CI: Case Insensitive - upper and lower letters are the same (SQL = sql)
CS: Case Sensitive - upper and lower letters are different (SQL <> sql)
AI: Accent Insensitive - accent marks are not differentiated (�gua = agua)
AS: Accent Insensitive - accent marks are differentiated (�gua <> agua)
*/

-- CHANGE THE COLLATE IN THE DATABASE
ALTER DATABASE BD_Collation COLLATE Latin1_General_CI_AS

-- CHECK THE COLLATE FROM A DATABASE
SELECT DATABASEPROPERTYEX('BD_Collation', 'collation')

DROP TABLE IF EXISTS NEW_TABLE

-- SET THE COLLATE FOR A TABLE
CREATE TABLE NEW_TABLE(
	ID INT,
	NAMES VARCHAR(20) COLLATE Latin1_General_CS_AS -- (!) ONLY VALID IN A CHAR TYPE COLUMN
	)

-- CHECK THE COLLATE FROM TABLE (AND ITS DESCRIPTION)
GO
sp_help	NEW_TABLE

-- EXAMPLE
INSERT INTO NEW_TABLE(ID, NAMES)
	VALUES
	(1,	'Matheus'),
	(2,	'Marcela'),
	(3,	'marcos'),
	(4,	'MAuricio'),
	(5,	'Marta'),
	(6,	'Miranda'),
	(7,	'Melissa'),
	(8,	'Lucas'),
	(9,	'luisa'),
	(10,'Pedro'),
	(11,'PK'),
	(12,'I7'),
	(13,'V2'),
	(14,'A'),
	(15,'B'),
	(16,'C'),
	(17,'M1R'),
	(18,'@ig'),
	(19,'#peace'),
	(20,'hey,@all!')

-- LIKE: IN CASE SENTIVE

SELECT * FROM NEW_TABLE
-- first letter m, second letter a
-- it follows the order
WHERE NAMES LIKE '[m][a]%'

-- LIKE: UPPER AND LOWER LETTERS

SELECT * FROM NEW_TABLE
-- first letter m or M, second letter a or A
-- it follows the order
WHERE NAMES LIKE '[Mm][Aa]%'

-- LIKE: MORE THAN 1 POSSIBILITY IN FIRST LETTER
SELECT * FROM NEW_TABLE
WHERE NAMES LIKE '[MmLlA]%'

-- LIKE: JUST HAVE 1 CHARACTER
SELECT * FROM NEW_TABLE
WHERE NAMES LIKE '[A-z]'

-- LIKE: JUST HAVE 2 CHARACTER
SELECT * FROM NEW_TABLE
WHERE NAMES LIKE '[A-z][A-z]'

-- LIKE: JUST HAVE 1 CHARACTER AND 1 NUMBER
SELECT * FROM NEW_TABLE
WHERE NAMES LIKE '[A-z][0-9]'

-- LIKE: THE JOKER _ CAN BE ANYTHING, INCLUDING NUMBERS!
SELECT * FROM NEW_TABLE
WHERE NAMES LIKE '[Mm]_[Rr]%'

-- LIKE: FOR DIFFERENT THAN USE ^
SELECT * FROM NEW_TABLE
WHERE NAMES LIKE '[^Mm]%'

SELECT * FROM NEW_TABLE
WHERE NAMES LIKE '_[^Aa]%'

-- LIKE: FILTER SPECIAL CHARS
SELECT * FROM NEW_TABLE
WHERE NAMES LIKE '%[^a-z0-9]%'

/*numbers*/
DROP TABLE IF EXISTS NUMBERS

CREATE TABLE NUMBERS(
NUMBER DECIMAL(10,2))

INSERT INTO NUMBERS(NUMBER)
VALUES
	(50.79), (30.99), (9), (100.54), (6.5), (501.55), (1000.56), (12), (70), (99.99) 

-- LIKE: 2 DIGITS INT NUMBER 
SELECT * FROM NUMBERS
WHERE NUMBER LIKE '[0-9][0-9].[0][0]'

-- LIKE: BEGINS WITH 1 AND HAS 5 AS THE FIRST DECIMAL VALUE
SELECT * FROM NUMBERS
WHERE NUMBER LIKE '1%.[5][0-9]'
