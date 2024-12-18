#FASE 1: CRIAR O BANCO DE DADOS (SCHEMA OU DATABASE):
#MEU PRIMEIRO BANQUINHO
CREATE SCHEMA EC1_SI1N;

SET sql_safe_updates = 0;

#FASE 2: SELECIONAR O NOVO SCHEMA OU DATABASE PARA USO:
#USANDO MEU BANQUINHO
USE EC1_SI1N;

# FASE 3: CRIANDO AS TABELAS SEM CHAVES ESTRANGEIRAS

#CRIANDO A TABELINHA FORNECEDORES
CREATE TABLE IF NOT EXISTS FORNECEDORES(
#NOMEDOATRIBUTO - TIPO - RESTRIÇÃO DE INTEGRIDADE(OPCIONAL)
FORNEC_COD INT PRIMARY KEY,
FORNEC_NOME VARCHAR(45) NOT NULL,
FORNEC_RUA VARCHAR(45) NOT NULL,
FORNEC_NUMRUA INT,
FORNEC_BAIRRO VARCHAR(45) NOT NULL,
FORNEC_CIDADE VARCHAR(45) NOT NULL,
FORNEC_ESTADO VARCHAR(45) NOT NULL,
FORNEC_PAIS VARCHAR(30) NOT NULL,
FORNEC_CODPOSTAL VARCHAR(10) NOT NULL,
FORNEC_TELEFONE VARCHAR(15) NOT NULL,
FORNEC_CONTATO TEXT NOT NULL
);

#CRIANDO A TABELINHA FILIAIS
CREATE TABLE IF NOT EXISTS FILIAIS(
FILIAL_COD INT PRIMARY KEY,
FILIAL_NOME VARCHAR(45) NOT NULL,
FILIAL_RUA VARCHAR(100) NOT NULL,
FILIAL_NUMRUA INT,
FILIAL_BAIRRO VARCHAR(50) NOT NULL,
FILIAL_CIDADE VARCHAR(50) NOT NULL,
FILIAL_ESTADO VARCHAR(50) NOT NULL,
FILIAL_PAIS VARCHAR(50) NOT NULL,
FILIAL_CODPOSTAL VARCHAR(10) NOT NULL,
FILIAL_CAPACIDADE TEXT NOT NULL);

#CRIANDO A TABELINHA PRODUTOS
CREATE TABLE IF NOT EXISTS PRODUTOS(
PROD_COD INT PRIMARY KEY,
PROD_NOME VARCHAR(50) NOT NULL,
PROD_DESCRICAO TEXT NOT NULL,
PROD_ESPECTEC TEXT NOT NULL,
PROD_QUANT DECIMAL(10,3) NOT NULL,
PROD_PRECOUNIT DECIMAL(10,2) NOT NULL,
PROD_UNIDMEDIDA VARCHAR(10) NOT NULL,
PROD_ESTOQ_MIN DECIMAL(10,3) NOT NULL
);

#FASE 4: CRIAR AS TABELAS COM DEPENDÊNCIA DE CHAVE ESTRANGEIRA

#CRIANDO A TABELA PEDIDOS
CREATE TABLE IF NOT EXISTS PEDIDOS(
PED_CODIGO INT PRIMARY KEY,
PED_DATA DATE NOT NULL,
PED_HORA TIME NOT NULL,
PED_PREVISAO DATE NOT NULL,
PED_STATUS ENUM('PENDENTE','CONCLUÍDO','EM ESPERA'),
PED_FORNECEDOR INT NOT NULL, #NOSSA CHAVE ESTRANGEIRA DE FORNECEDOR
#CRIANDO A REFERENCIA PARA A CHAVE ESTRANGEIRA
#RESTRIÇÃO APELIDO CH.ESTRANGEIRA(CAMPO CRIADO) REFERENCIA TABELA(CH.PRIMÁRIA)
CONSTRAINT FK_FORNECEDOR FOREIGN KEY (PED_FORNECEDOR) #DAR NOME A RESTRIÇÃO(CONSTRAINT) É UMA BOA PRÁTICA
REFERENCES FORNECEDORES(FORNEC_COD) #REFERENCIA A CHAVE PRIMÁRIA DE FORNECEDORES
);

#CRIANDO A TABELA RECEBIMENTOS (VEIO DEPOIS POIS TEM DEPENDÊNCIA DE PEDIDOS)
CREATE TABLE IF NOT EXISTS RECEBIMENTOS(
RECEB_DATA DATE NOT NULL,
RECEB_HORA TIME NOT NULL,
RECEB_QUANT_PROD DECIMAL(10,3),
RECEB_CONDICAO TEXT NOT NULL,
RECEB_PEDIDOS INT PRIMARY KEY,
CONSTRAINT FK_PEDIDOS FOREIGN KEY(RECEB_PEDIDOS) REFERENCES PEDIDOS(PED_CODIGO));

#FASE 5: CRIANDO AS TABELAS ASSOCIATIVAS (ENTIDADES ASSOCIATIVAS)

#CRIANDO A TABELA PEDIDOS_PRODUTOS
CREATE TABLE IF NOT EXISTS PEDIDOS_PRODUTOS(
PDPR_PEDIDOS INT,
PDPR_PRODUTOS INT,
PRIMARY KEY(PDPR_PEDIDOS,PDPR_PRODUTOS),
PDPR_QUANT DECIMAL(10,3) NOT NULL,
CONSTRAINT PDPR_FK_PEDIDOS FOREIGN KEY(PDPR_PEDIDOS) REFERENCES PEDIDOS(PED_CODIGO),
CONSTRAINT PDPR_FK_PRODUTOS FOREIGN KEY(PDPR_PRODUTOS) REFERENCES PRODUTOS(PROD_COD)
);

#CRIANDO A TABELA FILIAIS_PRODUTOS
CREATE TABLE IF NOT EXISTS FILIAIS_PRODUTOS(
FLPR_FILIAL INT,
FLPR_PRODUTOS INT,
PRIMARY KEY(FLPR_FILIAL,FLPR_PRODUTOS),
FLPR_QUANT DECIMAL(10,3) NOT NULL,
CONSTRAINT FLPR_FK_FILIAIS FOREIGN KEY(FLPR_FILIAL) REFERENCES FILIAIS(FILIAL_COD),
CONSTRAINT FLPR_FK_PRODUTOS FOREIGN KEY(FLPR_PRODUTOS) REFERENCES PRODUTOS(PROD_COD));

#CRIAR A TABELA FORNECEDORES_PRODUTOS
CREATE TABLE IF NOT EXISTS FORNECEDORES_PRODUTOS(
FRPR_FORNECEDOR INT,
FRPR_PRODUTOS INT,
PRIMARY KEY(FRPR_FORNECEDOR,FRPR_PRODUTOS),
FRPR_QTD INT,
CONSTRAINT FRPR_FK_FORNECEDORES FOREIGN KEY(FRPR_FORNECEDOR)
REFERENCES FORNECEDORES(FORNEC_COD),
CONSTRAINT FRPR_FK_PRODUTOS FOREIGN KEY(FRPR_PRODUTOS) 
REFERENCES PRODUTOS(PROD_COD));

insert into fornecedores values
(1,"Queijos LTDA","Rua Quinze de Novembro",600,"Praia da Costa","Vila Velha","ES","Brasil","29100-030","2799999-8888","João Silva"),
(2,"Bom dia & Cia","Rua Carijo",50,"Fluminense","Rio de Janeiro","RJ","Brasil","20010-010","2198899-1234","Pedro Moraes"),
(3, "Supermercado Estrela", "Rua dos Andradas", 120, "Centro", "São Paulo", "SP", "Brasil", "01002-000", "113322-4455", "Maria Souza"),
(4, "Loja do João", "Avenida Paulista", 1500, "Bela Vista", "São Paulo", "SP", "Brasil", "01310-200", "1199988-7766", "João Fernandes"),
(5, "Padaria Pão Quente", "Rua das Flores", 35, "Jardim das Rosas", "Curitiba", "PR", "Brasil", "80520-100", "4198877-3344", "Ana Clara");

update fornecedores
set fornec_contato = "Pedro Antonio"
where fornec_cod = 2;

update fornecedores
set fornec_rua = 'Rua dom Pedro'
where fornec_cod = 3;

insert into filiais values
(1,"Filial São José","Rua Dr Antonio Basilio",31,"Jardim da Penha","Vitoria","ES","Brasil","29060-390",200),
(2, "Filial Zona Sul", "Rua das Laranjeiras", 456, "Laranjeiras", "Rio de Janeiro", "RJ", "Brasil", "22240-003", 350),
(3, "Filial Norte Shopping", "Avenida Dom Hélder Câmara", 5474, "Cachambi", "Rio de Janeiro", "RJ", "Brasil", "20771-004", 500),
(4, "Filial Paulista", "Avenida Brigadeiro Faria Lima", 1010, "Pinheiros", "São Paulo", "SP", "Brasil", "01452-000", 600),
(5, "Filial Centro Histórico", "Rua dos Andradas", 789, "Centro Histórico", "Porto Alegre", "RS", "Brasil", "90020-005", 450);

update filiais
set filial_capacidade = 1000
where filial_cod = 5;

update filiais
set filial_numrua = 600
where filial_cod = 3;

insert into produtos values
(1,"Celular X","Celular Azul","Produto de 128gb de memoria na cor azul",15,1200.00,"UN",5),
(2, "Notebook Z", "Notebook Cinza", "Laptop com processador i5, 8GB RAM e 256GB SSD", 10, 3500.00, "UN", 3),
(3, "TV Ultra HD", "Televisor 50 polegadas", "Televisor Ultra HD com resolução 4K", 7, 2200.00, "UN", 2),
(4, "Fone de Ouvido", "Fone Bluetooth", "Fone de ouvido Bluetooth com cancelamento de ruído", 50, 200.00, "UN", 10),
(5, "Smartwatch S", "Relógio Inteligente Preto", "Smartwatch com monitoramento de frequência cardíaca", 20, 800.00, "UN", 4);

UPDATE PRODUTOS 
SET PROD_PRECOUNIT = 49.99 
WHERE PROD_COD = 10;

UPDATE PRODUTOS 
SET PROD_QUANT = 150.000 
WHERE PROD_COD = 5;

insert into pedidos values
(1, '2024-11-01', '09:30:00', '2024-11-10', 'PENDENTE',1),
(2, '2024-11-02', '10:15:00', '2024-11-12', 'EM ESPERA',2),
(3, '2024-11-03', '11:45:00', '2024-11-13', 'CONCLUÍDO',3),
(4, '2024-11-04', '13:20:00', '2024-11-14', 'PENDENTE',4),
(5, '2024-11-24', '15:20:10', '2024-11-14', 'CONCLUÍDO',5);

UPDATE PEDIDOS 
SET PED_STATUS = 'CONCLUÍDO'
WHERE PED_CODIGO = 1;

UPDATE PEDIDOS 
SET PED_PREVISAO = '2024-11-20' 
WHERE PED_CODIGO = 2;

insert into recebimentos values
('2024-11-01', '08:30:00', 150, 'Aprovado', 1),
('2024-11-02', '09:45:00', 300, 'Aprovado', 2),
('2024-11-03', '10:15:00', 50, 'Recusado', 3),
('2024-11-04', '11:00:00', 275, 'Aprovado', 4),
('2024-11-05', '14:30:00', 120, 'Em espera', 5);

UPDATE RECEBIMENTOS 
SET RECEB_QUANT_PROD = 200.000
WHERE RECEB_PEDIDOS = 50;

UPDATE RECEBIMENTOS 
SET RECEB_CONDICAO = 'Recebido em bom estado'
WHERE RECEB_PEDIDOS = 50;

insert into pedidos_produtos values
(1, 1, 15),
(1, 2, 20),
(2, 3, 50),
(3, 4, 10),
(4, 5, 25);

UPDATE PEDIDOS_PRODUTOS 
SET PDPR_QUANT = 5.000
WHERE PDPR_PEDIDOS = 1001 AND PDPR_PRODUTOS = 5;

UPDATE PEDIDOS_PRODUTOS 
SET PDPR_QUANT = 100
WHERE PDPR_PEDIDOS = 1;

insert into filiais_produtos values
(1, 1, 100),
(1, 2, 200),
(2, 3, 150),
(3, 3, 300),
(4, 4, 50);

UPDATE FILIAIS_PRODUTOS
SET FLPR_QUANT = 500
WHERE FLPR_FILIAL = 1;

insert into fornecedores_produtos values
(1, 1,5),
(2, 2,10),
(3, 3,15),
(4, 4,20),
(5, 5,25);

UPDATE FORNECEDORES_PRODUTOS
SET FRPR_QTD = 50
WHERE FRPR_FORNECEDOR = 1;

UPDATE FORNECEDORES_PRODUTOS
SET FRPR_QTD = 55
WHERE FRPR_FORNECEDOR = 2;

DELETE FROM FORNECEDORES_PRODUTOS
WHERE FRPR_FORNECEDOR = 5;

DELETE FROM FILIAIS_PRODUTOS
WHERE FLPR_FILIAL = 5;

DELETE FROM PEDIDOS_PRODUTOS
WHERE PDPR_PRODUTOS = 5;

DELETE FROM RECEBIMENTOS
WHERE RECEB_PEDIDOS = 5;

DELETE FROM PEDIDOS
WHERE PED_CODIGO = 5;

DELETE FROM PRODUTOS
WHERE PROD_COD = 5;

DELETE FROM FILIAIS
WHERE FILIAL_COD = 5;

DELETE FROM FORNECEDORES
WHERE FORNEC_COD = 5;