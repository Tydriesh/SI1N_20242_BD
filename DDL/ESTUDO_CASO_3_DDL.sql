#FASE 1: CRIAR O BANCO DE DADOS:
CREATE SCHEMA EC3_SI1N;

#FASE 2: SELECIONAR O NOVO ESQUEMA/DATABASE PARA USO:
USE EC3_SI1N;

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
UND_COMP VARCHAR(10) NOT NULL,
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
CNPJ_EMP VARCHAR(15) NOT NULL,
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
DESENHO_PROD BLOB NOT NULL,
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

#ADICIONANDO ALTER TABLE E DROP
# ALTER ADD - adiciona uma coluna TIPO_TEL na tabela TELEFONES
ALTER TABLE TELEFONES
ADD TIPO_TEL VARCHAR(20) NOT NULL;

# ALTER DROP COLUMN - remove a coluna QUALIFIC_FUNC da tabela FUNCIONARIOS
ALTER TABLE FUNCIONARIOS
DROP COLUMN QUALIFIC_FUNC;

# ALTER MODIFY COLUMN - alterando a coluna LOGRADOURO_END para varchar(150)
ALTER TABLE ENDERECOS
MODIFY COLUMN LOGRADOURO_END VARCHAR(150) NOT NULL;

# ALTER CHANGE COLUMN - renomeia a coluna RAMO_EMP para SETOR_EMP
ALTER TABLE EMPRESAS
CHANGE COLUMN RAMO_EMP SETOR_EMP VARCHAR(30) NOT NULL;

# DROP TABLE - removendo a tabela FUNCIONARIOS_PRODUTOS
DROP TABLE IF EXISTS FUNCIONARIOS_PRODUTOS;
