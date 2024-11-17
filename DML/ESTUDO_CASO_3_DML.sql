#FASE 1: CRIAR O BANCO DE DADOS:
CREATE SCHEMA EC3_SI1N;

#FASE 2: SELECIONAR O NOVO ESQUEMA/DATABASE PARA USO:
USE EC3_SI1N;

SET sql_safe_updates = 0;
#FASE 3 CRIANDO AS TABELAS SEM CHAVES ESTRANGEIRAS:

CREATE TABLE IF NOT EXISTS TELEFONES(
ID_TEL INT PRIMARY KEY,
NUM_TEL VARCHAR(15) NOT NULL,
DDD_TEL VARCHAR(2) NOT NULL,
DDD_PAIS_TEL VARCHAR (2) NOT NULL
);

CREATE TABLE IF NOT EXISTS TIPO_ENDERECO(
ID_TIPO_END INT PRIMARY KEY,
NOME_TIPO_END VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS TIPO_COMPONENTE(
ID_TIPO_COMP INT PRIMARY KEY,
NOME_TIPO_COMP VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS MAQUINAS(
ID_MAQUINA INT PRIMARY KEY,
TEMPO_VIDA_MAQ INT NOT NULL,
DATA_COMPRA_MAQ DATE NOT NULL,
DATA_FIM_GARANTIA_MAQ DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS RECURSOS_ESPECIFICOS(
ID_COMP_RE INT PRIMARY KEY,
QNTD_COMP DECIMAL(10,2) NOT NULL,
UND_COMP VARCHAR(30) NOT NULL,
TEMPO_USO_MAQ DECIMAL(10,2) NOT NULL,
HORAS_MAO_OBRA DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS REGISTRO_SUPRIMENTOS(
ID_COMP_RS INT PRIMARY KEY,
QTD_SUPRIMENTO DECIMAL(10,2) NOT NULL,
DATA_NECESSIDADE_SUPRIMENTO DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS FORMA_PAGAMENTO(
ID_FORMA_PAGT INT PRIMARY KEY,
NOME_FORMA_PAGT VARCHAR(15) NOT NULL
);

#FASE 4 CRIANDO AS TABELAS COM CHAVES ESTRANGEIRAS:
CREATE TABLE IF NOT EXISTS ENDERECOS(
ID_ENDERECO INT PRIMARY KEY,
LOGRADOURO_END VARCHAR(100) NOT NULL,
NUMERO_END INT,
COMPLEMENTO_END VARCHAR(50) NOT NULL,
CEP_END VARCHAR(10) NOT NULL,
BAIRRO_END VARCHAR(45) NOT NULL,
CIDADE_END VARCHAR(45) NOT NULL,
UF_END CHAR(2) NOT NULL,
TIPO_END INT NOT NULL,
CONSTRAINT FK_TIPO_ENDERECO FOREIGN KEY(TIPO_END) REFERENCES TIPO_ENDERECO(ID_TIPO_END)
);

CREATE TABLE IF NOT EXISTS EMPRESAS(
ID_EMP INT PRIMARY KEY,
CNPJ_EMP VARCHAR(30) NOT NULL,
RAZAO_SOCIAL_EMP VARCHAR(50) NOT NULL,
RAMO_EMP VARCHAR(20) NOT NULL,
DATA_CAD_EMP DATE NOT NULL,
TIPO_EMP VARCHAR(20) NOT NULL,
PESSOA_CONT_EMP VARCHAR(50) NOT NULL,
ENDERECOS_EMP INT NOT NULL,
TELEFONE_EMP INT NOT NULL,
CONSTRAINT FK_ENDERECO_EMPRESA FOREIGN KEY(ENDERECOS_EMP) REFERENCES ENDERECOS(ID_ENDERECO),
CONSTRAINT FK_TELEFONE_EMPRESA FOREIGN KEY(TELEFONE_EMP) REFERENCES TELEFONES(ID_TEL)
);

CREATE TABLE IF NOT EXISTS FUNCIONARIOS(
ID_FUNC INT PRIMARY KEY,
NOME_FUNC VARCHAR(50) NOT NULL,
SALARIOS_FUNC DECIMAL(10,2) NOT NULL,
DATA_ADMISSAO_FUNC DATE NOT NULL,
QUALIFIC_FUNC VARCHAR(50) NOT NULL,
CARGO_FUNC VARCHAR(50) NOT NULL,
ENDERECO_FUNC INT NOT NULL,
TELEFONE_FUNC INT NOT NULL,
CONSTRAINT FK_ENDERECO_FUNCIONARIO FOREIGN KEY(ENDERECO_FUNC) REFERENCES ENDERECOS(ID_ENDERECO),
CONSTRAINT FK_TELEFONE_FUNCIONARIO FOREIGN KEY(TELEFONE_FUNC) REFERENCES TELEFONES(ID_TEL)
);

CREATE TABLE IF NOT EXISTS ENCOMENDAS(
ID_ENCOMENDAS INT PRIMARY KEY,
DATA_INC_ENCOMENDA DATE NOT NULL,
VALOR_TOT_ENCOMENDA DECIMAL(10,2) NOT NULL,
VALOR_DESC_ENCOMENDA DECIMAL(10,2) NOT NULL,
VALOR_LIQ_ENCOMENDA DECIMAL(10,2) NOT NULL,
QTD_PARCELAS_ENCOMENDA INT NOT NULL,
EMPRESA_ENCOMENDA INT NOT NULL,
TIPO_PAGT_ENCOMENDA INT NOT NULL,
CONSTRAINT FK_EMPRESA_ENCOMENDA FOREIGN KEY(EMPRESA_ENCOMENDA) REFERENCES EMPRESAS(ID_EMP),
CONSTRAINT FK_FORMA_PAGT_ENCOMENDA FOREIGN KEY(TIPO_PAGT_ENCOMENDA) REFERENCES FORMA_PAGAMENTO(ID_FORMA_PAGT)
);

CREATE TABLE IF NOT EXISTS PRODUTOS(
ID_PRODUTO INT PRIMARY KEY,
NOME_PROD VARCHAR(50) NOT NULL,
COR_PROD VARCHAR(50) NOT NULL,
DIMENSOES_PROD VARCHAR(20) NOT NULL,
PESO_PROD DECIMAL(10,2) NOT NULL,
TEMPO_FAB_PROD DECIMAL(5,2) NOT NULL,
DESENHO_PROD BLOB,
HORAS_MAO_OBRA_PROD DECIMAL(5,2) NOT NULL,
RECURSO_ESPEC_PROD INT NOT NULL,
REGISTRO_SUPRIMENTO_PROD INT NOT NULL,
CONSTRAINT FK_RE_PRODUTOS FOREIGN KEY(RECURSO_ESPEC_PROD) REFERENCES RECURSOS_ESPECIFICOS(ID_COMP_RE),
CONSTRAINT FK_RS_PRODUTOS FOREIGN KEY(REGISTRO_SUPRIMENTO_PROD) REFERENCES REGISTRO_SUPRIMENTOS(ID_COMP_RS)
);

CREATE TABLE IF NOT EXISTS COMPONENTES(
ID_COMP INT PRIMARY KEY,
NOME_COMP VARCHAR(50) NOT NULL,
QTD_COMP DECIMAL(10,2) NOT NULL,
PRECO_UND_COMP DECIMAL(10,2) NOT NULL,
UND_MED_COMP VARCHAR(20) NOT NULL,
TIPO_COMP INT NOT NULL,
CONSTRAINT FK_COMPONENTE_TIPO FOREIGN KEY(TIPO_COMP) REFERENCES TIPO_COMPONENTE(ID_TIPO_COMP)
);

CREATE TABLE IF NOT EXISTS REGISTRO_MANUTENCAO(
ID_RM INT PRIMARY KEY,
DATA_MANUTENCAO DATETIME NOT NULL,
DESC_MANUTENCAO TEXT NOT NULL,
ID_MAQUINA_MANUTENCAO INT NOT NULL,
CONSTRAINT FK_MANUTENCAO_MAQUINA FOREIGN KEY(ID_MAQUINA_MANUTENCAO) REFERENCES MAQUINAS(ID_MAQUINA)
);

#FASE 5: CRIANDO ENTIDADES ASSOSSIATIVAS:
CREATE TABLE IF NOT EXISTS EMPRESAS_COMPONENTES(
ID_COMPONENTES INT,
ID_EMPRESAS INT,
PRIMARY KEY(ID_COMPONENTES,ID_EMPRESAS),
QTD_COMPONENTES DECIMAL(10,2),
CONSTRAINT EMPCOMP_FK_COMPONENTES FOREIGN KEY(ID_COMPONENTES) REFERENCES COMPONENTES(ID_COMP),
CONSTRAINT EMPCOMP_FK_EMPRESAS FOREIGN KEY(ID_EMPRESAS) REFERENCES EMPRESAS(ID_EMP)
);

CREATE TABLE IF NOT EXISTS COMPONENTES_PRODUTOS(
ID_COMPONENTES INT,
ID_PRODUTOS INT,
PRIMARY KEY(ID_COMPONENTES,ID_PRODUTOS),
QTD_COMPONENTES DECIMAL(10,2),
CONSTRAINT PRODCOMP_FK_PRODUTOS FOREIGN KEY(ID_PRODUTOS) REFERENCES PRODUTOS(ID_PRODUTO),
CONSTRAINT PRODCOMP_FK_COMPONENTES FOREIGN KEY(ID_COMPONENTES) REFERENCES COMPONENTES(ID_COMP)
);

CREATE TABLE IF NOT EXISTS MAQUINAS_PRODUTOS(
ID_MAQUINAS INT,
ID_PRODUTOS INT,
PRIMARY KEY(ID_MAQUINAS,ID_PRODUTOS),
QTD_PROD_PRODUZIDO DECIMAL(10,2),
CONSTRAINT MAQPROD_FK_MAQUINA FOREIGN KEY(ID_MAQUINAS) REFERENCES MAQUINAS(ID_MAQUINA),
CONSTRAINT MAQPROD_FK_PRODUTO FOREIGN KEY(ID_PRODUTOS) REFERENCES PRODUTOS(ID_PRODUTO)
);

CREATE TABLE IF NOT EXISTS ENCOMENDAS_PRODUTOS(
ID_ENCOMENDAS INT,
ID_PRODUTOS INT,
PRIMARY KEY(ID_ENCOMENDAS,ID_PRODUTOS),
QTD_PRODUTOS DECIMAL(10,2),
CONSTRAINT ENCPROD_FK_ENCOMENDAS FOREIGN KEY(ID_ENCOMENDAS) REFERENCES ENCOMENDAS(ID_ENCOMENDAS),
CONSTRAINT ENCPROD_FK_PRODUTOS FOREIGN KEY(ID_PRODUTOS) REFERENCES PRODUTOS(ID_PRODUTO)
);

CREATE TABLE IF NOT EXISTS FUNCIONARIOS_PRODUTOS(
ID_FUNCIONARIO INT,
ID_PRODUTO INT,
PRIMARY KEY(ID_FUNCIONARIO,ID_PRODUTO),
QTD_PRODUTO DECIMAL(10,2),
CONSTRAINT FUNCPROD_FK_PRODUTOS FOREIGN KEY(ID_PRODUTO) REFERENCES PRODUTOS(ID_PRODUTO),
CONSTRAINT FUNCPROD_FK_FUNCIONARIOS FOREIGN KEY(ID_FUNCIONARIO) REFERENCES FUNCIONARIOS(ID_FUNC)
);

insert into telefones values
(1, '999999999', '11', '55'),
(2, '988888888', '21', '55'),
(3, '977777777', '31', '55'),
(4, '966666666', '41', '55'),
(5, '955555555', '51', '55');

update telefones
set ddd_tel = '27'
where num_tel = '999999999';

update telefones
set num_tel = '988887777'
where id_tel = 5;

insert into tipo_endereco values
(1, 'Residencial'),
(2, 'Comercial'),
(3, 'Industrial'),
(4, 'Rural'),
(5, 'Público');

update tipo_endereco
set nome_tipo_end = 'Fiscal'
where id_tipo_end = 5;

update tipo_endereco
set nome_tipo_end = 'Retirada'
where id_tipo_end = 5;

insert into tipo_componente values
(1, 'Eletrônico'),
(2, 'Mecânico'),
(3, 'Estrutural'),
(4, 'Hidráulico'),
(5, 'Software');

update tipo_componente
set nome_tipo_comp = 'Resistores'
where nome_tipo_comp = 'Software';

update tipo_componente
set nome_tipo_comp = 'Transistores'
where nome_tipo_comp = 'Hidraulico';

insert into maquinas values
(1, 5, '2020-01-10', '2025-01-10'),
(2, 7, '2019-06-15', '2026-06-15'),
(3, 10, '2015-11-20', '2025-11-20'),
(4, 3, '2022-03-01', '2025-03-01'),
(5, 6, '2021-09-05', '2027-09-05');

update maquinas
set data_compra_maq = '2021-10-05'
where data_compra_maq ='2021-09-05';

update maquinas
set tempo_vida_maq = 10
where id_maquina = 1;

insert into recursos_especificos values
(1, 20.50, 'Unidade', 10.00, 5.00),
(2, 15.00, 'Kg', 8.00, 3.50),
(3, 30.00, 'Metros', 12.00, 6.00),
(4, 50.00, 'Litros', 15.00, 7.00),
(5, 25.00, 'Peças', 10.00, 4.50);

update recursos_especificos
set und_comp = 'Quilogramas'
where und_comp = 'Kg';

update recursos_especificos
set und_comp = 'Pacote c/ 5 Unidades'
where und_comp = 'Peças';

insert into registro_suprimentos values
(1, 100.50, '2024-11-15'),
(2, 200.00, '2024-11-20'),
(3, 150.75, '2024-11-18'),
(4, 50.25, '2024-11-25'),
(5, 75.10, '2024-11-30');

update registro_suprimentos
set qtd_suprimento = 100
where id_comp_rs = 5;

update registro_suprimentos
set qtd_suprimento = 75.10
where id_comp_rs = 4;

insert into forma_pagamento values
(1, 'Dinheiro'),
(2, 'Cartão Débito'),
(3, 'Cartão Crédito'),
(4, 'Boleto'),
(5, 'Pix');

update forma_pagamento
set nome_forma_pagt = 'Cheque'
where nome_forma_pagt = 'Pix';

update forma_pagamento
set nome_forma_pagt = 'Credito a Vista'
where nome_forma_pagt = 'Cartão Credito';

insert into enderecos values
(1, 'Rua das Flores', 123, 'Apto 301', '12345-678', 'Centro', 'São Paulo', 'SP', 1),
(2, 'Avenida Paulista', 456, 'Sala 405', '98765-432', 'Bela Vista', 'São Paulo', 'SP', 2),
(3, 'Rua XV de Novembro', 789, 'Casa 7', '54321-987', 'Centro', 'Curitiba', 'PR', 1),
(4, 'Rua das Acácias', 101, 'Casa 15', '45678-123', 'Vila Nova', 'Rio de Janeiro', 'RJ', 3),
(5, 'Avenida Brasil', 2000, 'Loja 22', '78965-432', 'Botafogo', 'Rio de Janeiro', 'RJ', 2);

update enderecos
set tipo_end = 5
where id_endereco = 5;

update enderecos
set logradouro_end = 'Avenida Brasil'
where id_endereco = 3;

insert into empresas values
(1, '12.345.678/0001-90', 'Tech Solutions Ltda.', 'Tecnologia', '2023-03-15', 'Privada', 'Carlos Silva', 1, 1),
(2, '98.765.432/0001-12', 'Distribuidora de Alimentos S.A.', 'Alimentos', '2022-11-01', 'Pública', 'Maria Oliveira', 2, 2),
(3, '23.456.789/0001-23', 'Construtora A.B.C.', 'Construção Civil', '2021-06-25', 'Privada', 'José Santos', 3, 3),
(4, '34.567.890/0001-34', 'Supermercados X Ltda.', 'Varejo', '2024-01-10', 'Privada', 'Ana Souza', 4, 4),
(5, '45.678.901/0001-45', 'Consultoria Empresarial S.A.', 'Consultoria', '2020-05-30', 'Pública', 'Ricardo Lima', 5, 5);

update empresas
set razao_social_emp = 'Construtora Davila'
where razao_social_emp = 'Construtora A.B.C.';

update empresas
set ramo_emp = 'Distribuidora'
where id_emp = 2;

insert into funcionarios values
(1, 'João Silva', 3500.00, '2022-08-15', 'Graduado em Administração', 'Gerente de Vendas', 1, 1),
(2, 'Maria Oliveira', 2800.00, '2021-12-10', 'Técnico em Logística', 'Supervisor de Logística', 2, 2),
(3, 'Carlos Souza', 4500.00, '2019-06-25', 'Mestre em Engenharia', 'Engenheiro Civil', 3, 3),
(4, 'Ana Costa', 3200.00, '2023-02-01', 'Bacharel em Psicologia', 'Analista de Recursos Humanos', 4, 4),
(5, 'Ricardo Lima', 5000.00, '2020-04-30', 'Mestre em Marketing', 'Diretor de Marketing', 5, 5);

update funcionarios
set qualific_func = 'Bacharel em Administração'
where nome_func = 'João Silva';

update funcionarios
set cargo_func = 'Diretor de Vendas'
where cargo_func = 'Gerente de Vendas';

insert into encomendas values
(1, '2024-11-01', 1000.00, 100.00, 900.00, 3, 1, 1),
(2, '2024-11-03', 500.00, 50.00, 450.00, 2, 2, 2),
(3, '2024-11-05', 1200.00, 150.00, 1050.00, 5, 3, 1),
(4, '2024-11-07', 700.00, 70.00, 630.00, 4, 4, 3),
(5, '2024-11-10', 1500.00, 200.00, 1300.00, 6, 5, 2);

update encomendas
set qtd_parcelas_encomenda = 3
where id_encomendas = 5;

update encomendas
set valor_desc_encomenda = 100
where id_encomendas = 5;

insert into produtos values
(1, 'Celular A', 'Vermelho', '10x10x10', 2.50, 5.00, NULL, 10.00, 1, 1),
(2, 'Notebook B', 'Azul', '15x15x15', 3.75, 6.00, NULL, 12.50, 2, 2),
(3, 'CPU C', 'Verde', '20x20x20', 5.00, 7.50, NULL, 15.00, 3, 3),
(4, 'Teclado Mecanico', 'Amarelo', '25x25x25', 7.25, 8.00, NULL, 18.00, 4, 4),
(5, 'Mouse', 'Preto', '30x30x30', 10.00, 9.00, NULL, 20.00, 5, 5);

update produtos
set nome_prod = 'Celular B'
where nome_prod = 'Celular A';

update produtos
set cor_prod = 'Laranja'
where nome_prod = 'Notebook B';

insert into componentes values
(1, 'Martelo', 100.00, 10.50, 'Unidade', 1),
(2, 'Porca', 200.00, 20.75, 'Unidade', 2),
(3, 'Prego', 150.00, 30.00, 'Pacote', 3),
(4, 'Chave de Fenda', 50.00, 15.00, 'Unidade', 4),
(5, 'Parafuso', 300.00, 25.50, 'Pacote', 1);

update componentes
set qtd_comp = 50
where nome_comp = 'Martelo';

update componentes
set qtd_comp = 110
where nome_comp = 'Parafuso';

insert into registro_manutencao values
(1, '2024-11-01 08:00:00', 'Troca de peças e calibração de sistema', 1),
(2, '2024-11-05 10:30:00', 'Manutenção preventiva do motor', 2),
(3, '2024-11-08 14:15:00', 'Substituição do filtro de ar', 3),
(4, '2024-11-10 16:00:00', 'Ajuste de calibragem e troca de óleo', 4),
(5, '2024-11-12 09:30:00', 'Verificação geral e testes de operação', 5);

update registro_manutencao
set desc_manutencao = 'Verificação geral de funcionalidades'
where id_rm = 5;

update registro_manutencao
set data_manutencao = '2024-11-02 09:30:10'
where id_rm = 1;

insert into empresas_componentes values
(1, 1, 150.00),
(2, 2, 300.00),
(3, 3, 500.00),
(4, 4, 200.00),
(5, 5, 100.00);

update empresas_componentes
set id_componentes = 2
where id_empresas = 1;

update empresas_componentes
set qtd_componentes = 100
where id_componentes = 3;

insert into componentes_produtos values
(1, 1, 50.00),
(2, 1, 30.00),
(3, 2, 20.00),
(4, 3, 10.00),
(5, 4, 15.00);

update componentes_produtos
set id_componentes = 1
where id_produtos = 2;

update componentes_produtos
set qtd_componentes = 5
where id_componentes = 3;

insert into maquinas_produtos values
(1, 1, 100.00),
(2, 1, 150.00),
(3, 2, 200.00),
(4, 3, 250.00),
(5, 4, 300.00);

update maquinas_produtos
set qtd_prod_produzido = 110
where id_produtos = 2;

update maquinas_produtos
set id_produtos = 5
where id_maquinas = 5;

insert into encomendas_produtos values
(1, 1, 10.00),
(1, 2, 5.00),
(2, 1, 15.00),
(3, 3, 8.00),
(4, 4, 20.00);

update encomendas_produtos
set qtd_produtos = 50
where id_produtos = 2;

update encomendas_produtos
set qtd_produtos = 18
where id_encomendas = 3;

insert into funcionarios_produtos values
(1, 1, 10.00),
(1, 2, 5.00),
(2, 1, 8.00),
(3, 3, 15.00),
(4, 4, 12.00);

update funcionarios_produtos
set id_produto = 2
where id_funcionario = 2;

update funcionarios_produtos
set qtd_produto = 15
where id_produto = 1;

delete from funcionarios_produtos
where id_produto = 4;

delete from encomendas_produtos
where id_encomendas = 4;

delete from maquinas_produtos
where id_maquinas = 5;

delete from componentes_produtos
where id_componentes = 5;

delete from empresas_componentes
where id_componentes = 5;

delete from registro_manutencao
where id_rm = 5;

delete from componentes
where id_comp = 5;

delete from produtos
where id_produto = 5;

delete from encomendas
where id_encomendas = 5;

delete from funcionarios
where id_func = 5;

delete from empresas
where id_emp = 5;

delete from enderecos
where id_endereco = 5;

delete from forma_pagamento
where id_forma_pagt = 5;

delete from registro_suprimentos
where id_comp_rs = 5;

delete from recursos_especificos
where id_comp_re = 5;

delete from maquinas
where id_maquina = 5;

delete from tipo_componente
where id_tipo_comp = 5;

delete from tipo_endereco
where id_tipo_end = 5;

delete from telefones
where id_tel = 5;