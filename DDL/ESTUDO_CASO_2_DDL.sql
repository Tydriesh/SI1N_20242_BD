CREATE SCHEMA EC2_SI1N;

USE EC2_SI1N;

CREATE TABLE IF NOT EXISTS PASSAGEIROS(
ID_PASS INT PRIMARY KEY,
CPF_PASS VARCHAR(14) NOT NULL,
NOME_PASS VARCHAR(50) NOT NULL,
TEL_PASS VARCHAR(15) NOT NULL,
END_PASS VARCHAR(100) NOT NULL,
EMAIL_PASS VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS AEROPORTOS(
ID_AEROPORTO INT PRIMARY KEY,
NOME_AEROPORTO VARCHAR(50) NOT NULL,
LOCAL_AEROPORTO VARCHAR(50) NOT NULL,
PAIS_AEROPORTO VARCHAR(50) NOT NULL,
LONGITUDE_AEROPORTO DECIMAL(9,6) NOT NULL,
LATITUDE_AEROPORTO DECIMAL(9,6) NOT NULL
);

CREATE TABLE IF NOT EXISTS FUNCIONARIOS(
ID_FUNC INT PRIMARY KEY,
NOME_FUNC VARCHAR(50) NOT NULL,
FUNCAO_FUNC VARCHAR(50) NOT NULL,
DATA_NASC_FUNC DATE NOT NULL,
TEL_FUNC VARCHAR(14) NOT NULL
);

CREATE TABLE IF NOT EXISTS AERONAVES(
PREFIXO_AERONAVE INT PRIMARY KEY,
MODELO_AERONAVE VARCHAR(50) NOT NULL,
ANO_FAB_AERONAVE DATE NOT NULL,
CAPACIDADE_AERONAVE INT NOT NULL,
FABRICANTE_AERONAVE VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS VOOS(
ID_VOO INT PRIMARY KEY,
DATA_HORA_ORIGEM DATETIME NOT NULL,
DATA_HORA_DESTINO DATETIME NOT NULL,
AEROPORTO_ORIGEM INT,
AEROPORTO_DESTINO INT,
ID_AERONAVE INT,
CONSTRAINT ORIGEM_VOO FOREIGN KEY(AEROPORTO_ORIGEM) REFERENCES AEROPORTOS(ID_AEROPORTO),
CONSTRAINT DESTINO_VOO FOREIGN KEY(AEROPORTO_DESTINO) REFERENCES AEROPORTOS(ID_AEROPORTO),
CONSTRAINT AERONAVE_VOO FOREIGN KEY(ID_AERONAVE) REFERENCES AERONAVES(PREFIXO_AERONAVE)
);

CREATE TABLE IF NOT EXISTS RESERVAS(
ID_PASS INT,
ID_VOO INT,
PRIMARY KEY(ID_PASS, ID_VOO),
CONSTRAINT RESERVA_PASS FOREIGN KEY(ID_PASS) REFERENCES PASSAGEIROS(ID_PASS),
CONSTRAINT RESERVA_VOO FOREIGN KEY(ID_VOO) REFERENCES VOOS(ID_VOO)
);

CREATE TABLE IF NOT EXISTS EQUIPES(
ID_FUNC INT,
ID_VOO INT,
PRIMARY KEY(ID_FUNC, ID_VOO),
CONSTRAINT EQUIPES_FUNC FOREIGN KEY(ID_FUNC) REFERENCES FUNCIONARIOS(ID_FUNC),
CONSTRAINT EQUIPES_VOO FOREIGN KEY(iD_VOO) REFERENCES VOOS(ID_VOO)
);

-- ALTER ADD: Adiciona uma nova coluna 'DATA_CAD_PASS' na tabela PASSAGEIROS.
ALTER TABLE PASSAGEIROS
ADD DATA_CAD_PASS DATE NOT NULL;

-- ALTER MODIFY COLUMN: Altera o tipo de dado da coluna 'EMAIL_PASS' de VARCHAR(100) para VARCHAR(150) na tabela PASSAGEIROS.
ALTER TABLE PASSAGEIROS
MODIFY COLUMN EMAIL_PASS VARCHAR(150);

-- ALTER CHANGE COLUMN: Renomeia a coluna 'END_PASS' para 'ENDERECO_PASSAGEIRO' na tabela PASSAGEIROS.
ALTER TABLE PASSAGEIROS
CHANGE COLUMN END_PASS ENDERECO_PASSAGEIRO VARCHAR(100);

-- ALTER ADD INDEX: Adiciona um índice na coluna 'CPF_PASS' na tabela PASSAGEIROS.
ALTER TABLE PASSAGEIROS
ADD INDEX IDX_CPF_PASSAGEIRO (CPF_PASS);

-- ALTER DROP COLUMN: Remove a coluna 'TEL_PASS' da tabela PASSAGEIROS.
ALTER TABLE PASSAGEIROS
DROP COLUMN TEL_PASS;

-- ALTER ADD: Adiciona uma nova coluna 'CAPITAL_PAIS' na tabela AEROPORTOS.
ALTER TABLE AEROPORTOS
ADD CAPITAL_PAIS VARCHAR(50);

-- ALTER MODIFY COLUMN: Altera o tipo de dado da coluna 'LOCAL_AEROPORTO' de VARCHAR(50) para VARCHAR(100) na tabela AEROPORTOS.
ALTER TABLE AEROPORTOS
MODIFY COLUMN LOCAL_AEROPORTO VARCHAR(100);

-- ALTER CHANGE COLUMN: Renomeia a coluna 'PAIS_AEROPORTO' para 'PAIS_LOCAL' na tabela AEROPORTOS.
ALTER TABLE AEROPORTOS
CHANGE COLUMN PAIS_AEROPORTO PAIS_LOCAL VARCHAR(50);

-- ALTER ADD INDEX: Adiciona um índice na coluna 'NOME_AEROPORTO' na tabela AEROPORTOS.
ALTER TABLE AEROPORTOS
ADD INDEX IDX_NOME_AEROPORTO (NOME_AEROPORTO);

-- ALTER DROP COLUMN: Remove a coluna 'LONGITUDE_AEROPORTO' da tabela AEROPORTOS.
ALTER TABLE AEROPORTOS
DROP COLUMN LONGITUDE_AEROPORTO;

-- ALTER ADD: Adiciona uma nova coluna 'EMAIL_FUNC' na tabela FUNCIONARIOS.
ALTER TABLE FUNCIONARIOS
ADD EMAIL_FUNC VARCHAR(100);

-- ALTER MODIFY COLUMN: Altera o tipo de dado da coluna 'TEL_FUNC' de VARCHAR(14) para VARCHAR(20) na tabela FUNCIONARIOS.
ALTER TABLE FUNCIONARIOS
MODIFY COLUMN TEL_FUNC VARCHAR(20);

-- ALTER CHANGE COLUMN: Renomeia a coluna 'FUNCAO_FUNC' para 'CARGO_FUNC' na tabela FUNCIONARIOS.
ALTER TABLE FUNCIONARIOS
CHANGE COLUMN FUNCAO_FUNC CARGO_FUNC VARCHAR(50);

-- ALTER ADD INDEX: Adiciona um índice na coluna 'NOME_FUNC' na tabela FUNCIONARIOS.
ALTER TABLE FUNCIONARIOS
ADD INDEX IDX_NOME_FUNC (NOME_FUNC);

-- ALTER DROP COLUMN: Remove a coluna 'DATA_NASC_FUNC' da tabela FUNCIONARIOS.
ALTER TABLE FUNCIONARIOS
DROP COLUMN DATA_NASC_FUNC;

-- ALTER ADD: Adiciona uma nova coluna 'ANO_REVISAO_AERONAVE' na tabela AERONAVES.
ALTER TABLE AERONAVES
ADD ANO_REVISAO_AERONAVE DATE;

-- ALTER MODIFY COLUMN: Altera o tipo de dado da coluna 'CAPACIDADE_AERONAVE' de INT para DECIMAL(5,1) na tabela AERONAVES.
ALTER TABLE AERONAVES
MODIFY COLUMN CAPACIDADE_AERONAVE DECIMAL(5,1);

-- ALTER CHANGE COLUMN: Renomeia a coluna 'FABRICANTE_AERONAVE' para 'FABRICANTE' na tabela AERONAVES.
ALTER TABLE AERONAVES
CHANGE COLUMN FABRICANTE_AERONAVE FABRICANTE VARCHAR(50);

-- ALTER ADD INDEX: Adiciona um índice na coluna 'MODELO_AERONAVE' na tabela AERONAVES.
ALTER TABLE AERONAVES
ADD INDEX IDX_MODELO_AERONAVE (MODELO_AERONAVE);

-- ALTER DROP COLUMN: Remove a coluna 'ANO_FAB_AERONAVE' da tabela AERONAVES.
ALTER TABLE AERONAVES
DROP COLUMN ANO_FAB_AERONAVE;

-- ALTER ADD: Adiciona uma nova coluna 'STATUS_VOO' na tabela VOOS.
ALTER TABLE VOOS
ADD STATUS_VOO ENUM('AGENDADO', 'CONCLUÍDO', 'CANCELADO') NOT NULL;

-- ALTER MODIFY COLUMN: Altera o tipo de dado da coluna 'DATA_HORA_DESTINO' de DATETIME para TIMESTAMP na tabela VOOS.
ALTER TABLE VOOS
MODIFY COLUMN DATA_HORA_DESTINO TIMESTAMP;

-- ALTER CHANGE COLUMN: Renomeia a coluna 'ID_AERONAVE' para 'AERONAVE_ID' na tabela VOOS.
ALTER TABLE VOOS
CHANGE COLUMN ID_AERONAVE AERONAVE_ID INT;

-- ALTER ADD INDEX: Adiciona um índice na coluna 'AEROPORTO_ORIGEM' na tabela VOOS.
ALTER TABLE VOOS
ADD INDEX IDX_ORIGEM_VOO (AEROPORTO_ORIGEM);

-- ALTER DROP COLUMN: Remove a coluna 'DATA_HORA_ORIGEM' da tabela VOOS.
ALTER TABLE VOOS
DROP COLUMN DATA_HORA_ORIGEM;

-- ALTER ADD: Adiciona uma nova coluna 'DATA_RESERVA' na tabela RESERVAS.
ALTER TABLE RESERVAS
ADD DATA_RESERVA DATE NOT NULL;

-- ALTER MODIFY COLUMN: Altera o tipo de dado da coluna 'ID_PASS' de INT para BIGINT na tabela RESERVAS.
ALTER TABLE RESERVAS
MODIFY COLUMN DATA_RESERVA TIMESTAMP;

-- ALTER ADD INDEX: Adiciona um índice na coluna 'ID_VOO' na tabela RESERVAS.
ALTER TABLE RESERVAS
ADD INDEX IDX_ID_VOO (ID_VOO);

-- ALTER DROP FOREIGN KEY: Remove a restrição de chave estrangeira 'RESERVA_PASS' na tabela RESERVAS.
ALTER TABLE RESERVAS
DROP FOREIGN KEY RESERVA_PASS;

-- ALTER ADD: Adiciona uma nova coluna 'FUNCAO_EQUIPE' na tabela EQUIPES.
ALTER TABLE EQUIPES
ADD FUNCAO_EQUIPE VARCHAR(50);

-- ALTER MODIFY COLUMN: Altera o tipo de dado da coluna 'ID_VOO' de INT para BIGINT na tabela EQUIPES.
ALTER TABLE EQUIPES
MODIFY COLUMN FUNCAO_EQUIPE VARCHAR(100);

-- ALTER ADD INDEX: Adiciona um índice na coluna 'ID_FUNC' na tabela EQUIPES.
ALTER TABLE EQUIPES
ADD INDEX IDX_ID_FUNC (ID_FUNC);

-- ALTER DROP FOREIGN KEY: Remove a restrição de chave estrangeira 'EQUIPES_FUNC' na tabela EQUIPES.
ALTER TABLE EQUIPES
DROP FOREIGN KEY EQUIPES_FUNC;

DROP TABLE IF EXISTS EQUIPES;

DROP TABLE IF EXISTS RESERVAS;

DROP TABLE IF EXISTS VOOS;

DROP TABLE IF EXISTS AERONAVES;

DROP TABLE IF EXISTS FUNCIONARIOS;

DROP TABLE IF EXISTS AEROPORTOS;

DROP TABLE IF EXISTS PASSAGEIROS;
