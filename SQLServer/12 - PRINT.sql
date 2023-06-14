-- PRINT HAS A DEFAULT MESSAGE
-- WE WON'T NEED IT NOW
SET NOCOUNT ON 

-- Example 1: sending messages with PRINT function
DECLARE @storesOff INT, @storesOn INT
SET @storesOn = (SELECT COUNT(*)
				FROM DimStore
				WHERE Status = 'On')
SET @storesOff = (SELECT COUNT(*)
				FROM DimStore
				WHERE Status = 'Off')

SELECT @storesOn, @storesOff;

PRINT 'Total of open stores ' + CAST(@storesOn AS VARCHAR(10))
PRINT CONCAT('Total of closed stores ', @storesOff)


