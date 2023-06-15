 

 -- TRANSLATE: replaces every character in the text order

 SELECT TRANSLATE('AB-12-AB78-CDAB', 'AB', 'RR')
 
 SELECT TRANSLATE('AB-12-AB78-CDAB', 'AB', 'RRR') -- doesnt work
												  -- must be the same length

-- STUFF: selects a certain amount of chars and replace them
SELECT STUFF('SQL is great', 1, 3, 'Python')
SELECT STUFF('great SQL is ', 7, 10, 'Python') -- in the middle/end of string is not a good idea