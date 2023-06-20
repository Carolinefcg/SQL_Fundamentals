

-- WHILE
DECLARE @varcount INT = 1

WHILE @varcount <= 10
BEGIN
	PRINT @varcount
	SET @varcount = @varcount + 1
END

-- USING BREAK STATEMENT

DECLARE @varcount2 INT = 0

WHILE @varcount2 <= 50
BEGIN
	PRINT @varcount2
	IF @varcount2 = 15
	BREAK
	SET @varcount2 = @varcount2 + 5
END

-- USING CONTINUE STATEMENT

DECLARE @varcount3 INT = 0

WHILE @varcount3 <= 50
BEGIN
	PRINT @varcount3
	SET @varcount3 = @varcount3 + 5
	IF @varcount3 = 15
	CONTINUE
	-- IGNORES EVERYTHING BELOW
	-- MOVES BACK TO WHILE
END


-- EXERCISES
-- 1
DECLARE @initial_value INT = 0,
		@final_value INT = 10

WHILE @initial_value < @final_value
BEGIN
	SET @initial_value = @initial_value + 1
	PRINT 'Count var value:' + CAST(@initial_value AS VARCHAR)
END

-- 2
DECLARE @count_hire INT = 0,
		@initial_year INT = 1996,
		@final_year INT = 2003

WHILE @initial_year <= @final_year
BEGIN
	SET @count_hire =	(SELECT COUNT(*)
						FROM DimEmployee
						WHERE YEAR(HireDate) = @initial_year)
	PRINT CONCAT(@count_hire, ' contratações em ', @initial_year)
	SET @initial_year +=  1
END

-- 3
use BDImpressionador

DROP TABLE if EXISTS Calendario

CREATE TABLE Calendario (
	dia_mes_ano DATE)
SELECT * FROM Calendario

DECLARE @days INT = 0,
		@start_date DATE = '2021-01-01'

WHILE @days < 365
BEGIN
	INSERT INTO Calendario(dia_mes_ano)
	VALUES	(@start_date)
	PRINT concat('DAYS', @days, ' DATE', @start_date)
	SET @days = @days + 1
	SET @start_date = DATEADD(DAY, 1, @start_date)
END

SELECT * FROM Calendario