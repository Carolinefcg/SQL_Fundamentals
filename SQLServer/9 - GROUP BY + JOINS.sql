
-- 1 A)
SELECT 
	F.SalesQuantity
FROM 
	FactSales AS F
INNER JOIN DimDate AS D
ON F.DateKey = D.Datekey;