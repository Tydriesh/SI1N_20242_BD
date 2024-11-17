#FASE 1: CRIAR O BANCO DE DADOS:
CREATE SCHEMA EC4_SI1N;

SET sql_safe_updates = 0;

#FASE 2: SELECIONAR O NOVO ESQUEMA/DATABASE PARA USO:
USE EC4_SI1N;

#FASE 3 CRIANDO AS TABELAS SEM CHAVES ESTRANGEIRAS:
CREATE TABLE IF NOT EXISTS ALUNOS(
ID_ALUNOS INT PRIMARY KEY auto_increment,
NOME_ALUNO VARCHAR(50) NOT NULL,
CPF_ALUNO VARCHAR(14) NOT NULL,
DATA_NASC_ALUNO DATE,
RUA_ALUNO VARCHAR(45),
BAIRRO_ALUNO VARCHAR(45),
CIDADE_ALUNO VARCHAR(45),
NUM_CASA_ALUNO VARCHAR(10),
UF_ALUNO CHAR(2),
CEP_ALUNO VARCHAR(45),
EMAIL_ALUNO VARCHAR(100),
TEL_ALUNO VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS INSTRUTORES(
ID_INSTRUTOR INT PRIMARY KEY AUTO_INCREMENT,
NOME_INSTRUTOR VARCHAR(45) NOT NULL,
CPF_INSTRUTOR VARCHAR(14) NOT NULL
);

CREATE TABLE IF NOT EXISTS MODALIDADES(
ID_MODALIDADE INT PRIMARY KEY AUTO_INCREMENT,
NOME_MODALIDADE VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS PAGAMENTOS(
ID_PAGT INT PRIMARY KEY AUTO_INCREMENT,
ID_ALUNO INT NOT NULL,
DATA_PAGT DATE NOT NULL,
VALOR_PAGT DECIMAL(10,2) NOT NULL,
STATUS_PAGT VARCHAR(20),
CONSTRAINT FK_PAGT_ALUNOS FOREIGN KEY(ID_ALUNO) REFERENCES ALUNOS(ID_ALUNOS)
);

CREATE TABLE IF NOT EXISTS PLANO_TREINO(
ID_ALUNOS INT,
ID_INSTRUTOR INT,
PRIMARY KEY(ID_ALUNOS,ID_INSTRUTOR),
PROGRESS_ALUNO VARCHAR(45),
CONSTRAINT FK_TREINO_ALUNO FOREIGN KEY(ID_ALUNOS) REFERENCES ALUNOS(ID_ALUNOS),
CONSTRAINT FK_TREINO_INSTRUTOR FOREIGN KEY(ID_INSTRUTOR) REFERENCES INSTRUTORES(ID_INSTRUTOR)
);

CREATE TABLE IF NOT EXISTS INSTRUTORES_MODALIDADES(
ID_INSTRUTOR INT,
ID_MODALIDADE INT,
PRIMARY KEY(ID_INSTRUTOR,ID_MODALIDADE),
DATA_CADASTRO DATE,
CONSTRAINT FK_MODINST_MODALIDADES FOREIGN KEY(ID_MODALIDADE) REFERENCES MODALIDADES(ID_MODALIDADE),
CONSTRAINT FK_MODINST_INSTRUTORES FOREIGN KEY(ID_INSTRUTOR) REFERENCES INSTRUTORES(ID_INSTRUTOR)
);

CREATE TABLE IF NOT EXISTS AULAS(
ID_AULA INT PRIMARY KEY AUTO_INCREMENT,
HORA_AULA VARCHAR(45) NOT NULL,
CAPC_AULA INT NOT NULL,
ID_INSTRUTOR_MOD INT,
ID_MODALIDADE_INST INT,
CONSTRAINT FK_AULAS_INSTRUTOR FOREIGN KEY(ID_INSTRUTOR_MOD) REFERENCES INSTRUTORES_MODALIDADES(ID_INSTRUTOR),
CONSTRAINT FK_AULAS_MODALIDADE FOREIGN KEY(ID_MODALIDADE_INST) REFERENCES INSTRUTORES_MODALIDADES(ID_MODALIDADE)
);

CREATE TABLE IF NOT EXISTS AULAS_ALUNOS(
ID_ALUNO INT,
ID_AULA INT,
ID_MODALIDADE INT,
ID_INSTRUTOR INT,
NOME_AULA VARCHAR(45),
PRIMARY KEY(ID_ALUNO,ID_AULA,ID_MODALIDADE,ID_INSTRUTOR),
CONSTRAINT FK_AULASALUNOS_ALUNO FOREIGN KEY(ID_ALUNO) REFERENCES ALUNOS(ID_ALUNOS),
CONSTRAINT FK_AULASALUNOS_AULA FOREIGN KEY(ID_AULA) REFERENCES AULAS(ID_AULA),
CONSTRAINT FK_AULASALUNOS_MODALIDADE FOREIGN KEY(ID_MODALIDADE) REFERENCES AULAS(ID_MODALIDADE_INST),
CONSTRAINT FK_AULASALUNOS_INSTRUTOR FOREIGN KEY(ID_INSTRUTOR) REFERENCES AULAS(ID_INSTRUTOR_MOD)
);

insert into alunos(NOME_ALUNO, CPF_ALUNO, DATA_NASC_ALUNO, RUA_ALUNO, BAIRRO_ALUNO, CIDADE_ALUNO, NUM_CASA_ALUNO, UF_ALUNO, CEP_ALUNO, EMAIL_ALUNO, TEL_ALUNO) values
('Alice Silva', '123.456.789-00', '2000-05-15', 'Rua das Flores', 'Centro', 'São Paulo', '123', 'SP', '01000-000', 'alice.silva@email.com', '(11) 91234-5678'),
('Bruno Oliveira', '234.567.890-01', '1998-11-20', 'Avenida Paulista', 'Bela Vista', 'São Paulo', '456', 'SP', '01310-000', 'bruno.oliveira@email.com', '(11) 92345-6789'),
('Carla Souza', '345.678.901-02', '2001-03-10', 'Rua das Palmeiras', 'Centro', 'Rio de Janeiro', '789', 'RJ', '20000-000', 'carla.souza@email.com', '(21) 93456-7890'),
('Diego Costa', '456.789.012-03', '1999-07-25', 'Rua do Sol', 'Boa Vista', 'Belo Horizonte', '321', 'MG', '30130-000', 'diego.costa@email.com', '(31) 94567-8901'),
('Elena Martins', '567.890.123-04', '2002-01-30', 'Avenida das Américas', 'Copacabana', 'Rio de Janeiro', '654', 'RJ', '22000-000', 'elena.martins@email.com', '(21) 95678-9012');

update alunos
set nome_aluno = 'Alice Rodrigues'
where nome_aluno = 'Alice Silva';

update alunos
set rua_aluno = 'Rua Quinze de Novembro'
where nome_aluno = 'Bruno Oliveira';

insert into instrutores (NOME_INSTRUTOR, CPF_INSTRUTOR) values
('Carlos Silva', '123.456.789-00'),
('Mariana Oliveira', '234.567.890-11'),
('Pedro Santos', '345.678.901-22'),
('Ana Paula Souza', '456.789.012-33'),
('Lucas Almeida', '567.890.123-44');

update instrutores
set nome_instrutor = 'Carlos Pereira'
where cpf_instrutor = '123.456.789-00';

update instrutores
set cpf_instrutor = '111.222.333-44'
where nome_instrutor = 'Pedro Santos';

insert into modalidades(NOME_MODALIDADE) values
('Musculação'),
('Yoga'),
('Pilates'),
('Natação'),
('Boxe');

update modalidades
set nome_modalidade = 'Kickboxing'
where nome_modalidade = 'Boxe';

update modalidades
set nome_modalidade = 'Hidroginastica'
where nome_modalidade = 'Natação';

insert into pagamentos(ID_ALUNO, DATA_PAGT, VALOR_PAGT, STATUS_PAGT) values
(1, '2024-01-15', 250.00, 'Pago'),
(2, '2024-02-10', 300.00, 'Pendente'),
(3, '2024-02-20', 275.00, 'Pago'),
(4, '2024-03-05', 320.00, 'Atrasado'),
(5, '2024-03-15', 250.00, 'Pago');

update pagamentos
set status_pagt = 'Pago'
where id_aluno = 4;

update pagamentos
set status_pagt = 'Atrasado'
where id_aluno = 2;

insert into plano_treino values
(1, 1, 'Em progresso'),
(2, 2, 'Finalizado'),
(3, 3, 'Em progresso'),
(4, 4, 'Aguardando início'),
(5, 5, 'Em progresso');

update plano_treino
set progress_aluno = 'Finalizado'
where id_alunos = 3;

update plano_treino
set progress_aluno = 'Em Progresso'
where id_alunos = 4;

insert into instrutores_modalidades values
(1, 1,'2024-06-28'),
(2, 2,'2024-01-10'),
(3, 3,'2024-04-12'),
(4, 4,'2024-03-13'),
(5, 5,'2024-02-11');

update instrutores_modalidades
set data_cadastro = '2024-03-15'
where id_modalidade = 4;

update instrutores_modalidades
set data_cadastro = '2024-02-20'
where id_modalidade = 3;

insert into aulas(HORA_AULA, CAPC_AULA, ID_INSTRUTOR_MOD, ID_MODALIDADE_INST) values
('08:00', 20, 1, 1),
('10:00', 25, 2, 2),
('12:00', 15, 3, 3),
('14:00', 30, 4, 4),
('16:00', 20, 5, 5);

update aulas
set id_instrutor_mod = 3
where hora_aula = '08:00';

update aulas
set capc_aula = 30
where id_aula = 2;

insert into aulas_alunos(ID_ALUNO,ID_AULA,ID_MODALIDADE,ID_INSTRUTOR) values
(1, 1, 1, 3),
(2, 2, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 4),
(5, 5, 5, 5);

update aulas_alunos
set id_aluno = 2
where id_aula = 3;

update aulas_alunos
set id_modalidade = 2
where id_aluno = 1;

delete from aulas_alunos
where id_aluno = 5;

delete from aulas
where id_aula = 5;

delete from instrutores_modalidades
where id_modalidade = 5;

delete from plano_treino
where id_alunos = 5;

delete from pagamentos
where id_pagt = 5;

delete from modalidades
where id_modalidade = 5;

delete from instrutores
where id_instrutor = 5;

delete from alunos
where id_alunos = 5;