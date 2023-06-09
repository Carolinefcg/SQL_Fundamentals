SELECT 
	DISTINCT ColorName
FROM DimProduct
WHERE ColorName <> 'Silver';

SELECT 
	DISTINCT ColorName
FROM DimProduct
WHERE ColorName != 'Silver';


SELECT 
	DISTINCT ColorName
FROM DimProduct
WHERE NOT ColorName = 'Silver';