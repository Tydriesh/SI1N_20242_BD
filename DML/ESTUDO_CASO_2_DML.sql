CREATE SCHEMA EC2_SI1N;

SET sql_safe_updates = 0;

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

insert into passageiros values
(1, '123.456.789-00', 'Alice Silva', '(11)91234-5678', 'Rua das Flores, 123, São Paulo, SP', 'alice.silva@email.com'),
(2, '987.654.321-00', 'Bruno Santos', '(21)99876-5432', 'Av. Brasil, 456, Rio de Janeiro, RJ', 'bruno.santos@email.com'),
(3, '456.789.123-00', 'Carla Oliveira', '(31)91234-5678', 'Rua Minas Gerais, 789, Belo Horizonte, MG', 'carla.oliveira@email.com'),
(4, '321.654.987-00', 'Daniel Costa', '(41)99876-5432', 'Av. Paraná, 321, Curitiba, PR', 'daniel.costa@email.com'),
(5, '654.987.321-00', 'Elaine Souza', '(51)91234-5678', 'Rua do Porto, 654, Porto Alegre, RS', 'elaine.souza@email.com');

update passageiros
set nome_pass = 'Alice Pedrosa'
where id_pass = 1;

update passageiros
set tel_pass = '(27)99999-8888'
where id_pass = 3;

insert into aeroportos values
(1, 'Aeroporto Internacional de Guarulhos', 'São Paulo', 'Brasil', -46.469511, -23.435556),
(2, 'Aeroporto Internacional de Los Angeles', 'Los Angeles', 'Estados Unidos', -118.408075, 33.941589),
(3, 'Aeroporto de Heathrow', 'Londres', 'Reino Unido', -0.454295, 51.470020),
(4, 'Aeroporto de Changi', 'Cingapura', 'Cingapura', 103.987739, 1.364420),
(5, 'Aeroporto Internacional de Tóquio', 'Tóquio', 'Japão', 139.779839, 35.549393);

update aeroportos
set nome_aeroporto = 'Aeroporto Internacional de LA'
where id_aeroporto = 2;

update aeroportos
set nome_aeroporto = 'Aeroporto de Londres'
where id_aeroporto = 3;

insert into funcionarios values
(1, 'Carlos Pereira', 'Gerente', '1985-03-15', '(11)98765-4321'),
(2, 'Ana Souza', 'Analista', '1990-07-21', '(21)91234-5678'),
(3, 'Marcos Lima', 'Técnico', '1987-01-30', '(31)99876-5432'),
(4, 'Fernanda Silva', 'Coordenadora', '1992-12-05', '(41)97654-3210'),
(5, 'Bruno Santos', 'Assistente', '1995-08-10', '(51)93456-7890');

update funcionarios
set funcao_func = 'Diretora Analista'
where nome_func = 'Ana Souza';

update funcionarios
set nome_func = 'Bruna Silva'
where funcao_func ='Assistente';

insert into aeronaves values
(1, 'Boeing 737-800', '2015-06-15', 189, 'Boeing'),
(2, 'Airbus A320', '2018-04-10', 180, 'Airbus'),
(3, 'Embraer E195', '2016-09-22', 124, 'Embraer'),
(4, 'Boeing 787-9', '2017-02-28', 296, 'Boeing'),
(5, 'Airbus A330-200', '2014-11-05', 246, 'Airbus');

update aeronaves
set fabricante_aeronave = 'Boeing'
where prefixo_aeronave = 5;

update aeronaves
set capacidade_aeronave = 320
where prefixo_aeronave = 3;

insert into voos values
(1, '2024-11-15 08:00:00', '2024-11-15 12:00:00', 1, 2, 1),
(2, '2024-11-16 09:30:00', '2024-11-16 13:30:00', 2, 1, 2),
(3, '2024-11-17 07:15:00', '2024-11-17 11:15:00', 3, 4, 3),
(4, '2024-11-18 14:00:00', '2024-11-18 18:00:00', 4, 3, 4),
(5, '2024-11-19 16:45:00', '2024-11-19 20:45:00', 5, 5, 5);

update voos
set id_aeronave = 3
where id_voo = 2;

update voos
set aeroporto_origem = 4
where id_voo = 2;

insert into reservas values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

update reservas
set id_pass = 2
where id_voo = 1;

update reservas
set id_voo = 3
where id_pass = 4;

insert into equipes values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

update equipes
set id_func = 2
where id_voo = 3;

update equipes
set id_voo = 4
where id_func = 1;

delete from equipes
where id_func = 5;

delete from reservas
where id_voo = 5;

delete from voos
where id_voo = 5;

delete from aeronaves
where prefixo_aeronave = 5;

delete from funcionarios
where id_func = 5;

delete from aeroportos
where id_aeroporto = 5;

delete from passageiros
where id_pass = 5;