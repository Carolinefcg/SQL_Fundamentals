# Funções de data

# 1. pegar valores de data
# 	DAY - pega o dia de uma data
# 	MONTH - pega o mês de uma data
# 	YEAR - pega o ano de uma data

# 2. pegar valores de data do sistema (atual)
# 	NOW() - datetime atual
#	CURDATE() - data atual
#	CURTIME() - tempo hh:mm:ss atual

# 3. operações com data
# 	DATEDIFF(DataFim, DataInicio) - datetime atual
#	DATE_ADD(DataFim, INTERVAL # DAY/MONTH/YEAR) - adiciona dias ou meses ou anos a uma data
#	DATE_SUB(DataFim, INTERVAL # DAY/MONTH/YEAR) - subtrai dias ou meses ou anos a uma data

# 1. pegar valores de data
SELECT 
    Nome,
    Data_Nascimento,
    DAY(Data_Nascimento) AS 'DIA',
    MONTH(Data_Nascimento) AS 'MES',
    YEAR(Data_Nascimento) AS 'ANO'
FROM
    clientes;
    
# 2. pegar valores de data do sistema (atual)
SELECT NOW(), 
CURDATE(), 
CURTIME();

# 3. operações com data
SELECT 
    Nome,
    Data_Nascimento,
    DATEDIFF(NOW(), Data_Nascimento) AS 'DATEDIFF',
    DATE_ADD(Data_Nascimento, INTERVAL 10 DAY) AS 'DATE_ADD_DAY',
	DATE_ADD(Data_Nascimento, INTERVAL 10 MONTH) AS 'DATE_ADD_MONTH',
    DATE_ADD(Data_Nascimento, INTERVAL 10 YEAR) AS 'DATE_ADD_YEAR',
    DATE_ADD(DATE_ADD(Data_Nascimento, INTERVAL 10 DAY), INTERVAL 10 YEAR) AS 'DATE_ADD_DAY_YEAR'
    # DATE_ADD TEM A MESMA SINBTAXE DE DATE_SUB
FROM
    clientes;