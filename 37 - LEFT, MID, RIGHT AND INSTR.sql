# LEFT, MID RIGHT AND INSTR

# MID - MEIO
# INSTR - IN STRING

SET @var = 'MySQL Workbech';

select 
LEFT(@var, 5) as 'left',
RIGHT(@var, 8) as 'right';


SELECT 
    Num_serie,
    LEFT(Num_serie, 3) AS 'LEFT',
    MID(Num_Serie,  INSTR(Num_serie,'-')+1, INSTR(Num_serie,'-')-2) as 'MIND_AND_INSTR',
    RIGHT(Num_serie, 6) AS 'RIGHT'
FROM
    produtos;
    
    
#teste

/*
SET @varInstr =  (select INSTR(Num_serie,'-') from produtos;
SELECT 
	@varInstr,
    Num_serie,
    LEFT(Num_serie, 3) AS 'LEFT',
    MID(Num_Serie,  @varInstr +1, INSTR(Num_serie,'-')-2) as 'MIND_AND_INSTR',
    RIGHT(Num_serie, 6) AS 'RIGHT'
FROM
    produtos;
    */