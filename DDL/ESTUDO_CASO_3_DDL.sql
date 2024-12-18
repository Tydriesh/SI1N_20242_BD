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

# ALTER para TABELA TELEFONES
ALTER TABLE TELEFONES
ADD TEL_OBS VARCHAR(100) NOT NULL;

ALTER TABLE TELEFONES
MODIFY COLUMN NUM_TEL VARCHAR(20);

ALTER TABLE TELEFONES
CHANGE COLUMN NUM_TEL TELEFONE VARCHAR(20);

ALTER TABLE TELEFONES
ADD INDEX IDX_TELEFONE (TELEFONE);

ALTER TABLE TELEFONES
DROP COLUMN TEL_OBS;

# ALTER para TABELA TIPO_ENDERECO
ALTER TABLE TIPO_ENDERECO
ADD TIPO_DESC VARCHAR(100) NOT NULL;

ALTER TABLE TIPO_ENDERECO
MODIFY COLUMN NOME_TIPO_END VARCHAR(60);

ALTER TABLE TIPO_ENDERECO
CHANGE COLUMN NOME_TIPO_END NOME_TIPO VARCHAR(60);

ALTER TABLE TIPO_ENDERECO
ADD INDEX IDX_NOME_TIPO (NOME_TIPO);

ALTER TABLE TIPO_ENDERECO
DROP COLUMN TIPO_DESC;

# ALTER para TABELA TIPO_COMPONENTE
ALTER TABLE TIPO_COMPONENTE
ADD COMP_DESC VARCHAR(100) NOT NULL;

ALTER TABLE TIPO_COMPONENTE
MODIFY COLUMN NOME_TIPO_COMP VARCHAR(60);

ALTER TABLE TIPO_COMPONENTE
CHANGE COLUMN NOME_TIPO_COMP NOME_COMPONENTE VARCHAR(60);

ALTER TABLE TIPO_COMPONENTE
ADD INDEX IDX_COMPONENTE (NOME_COMPONENTE);

ALTER TABLE TIPO_COMPONENTE
DROP COLUMN COMP_DESC;

# ALTER para TABELA MAQUINAS
ALTER TABLE MAQUINAS
ADD MAQ_OBSERVACOES VARCHAR(100) NOT NULL;

ALTER TABLE MAQUINAS
MODIFY COLUMN TEMPO_VIDA_MAQ VARCHAR(10);

ALTER TABLE MAQUINAS
CHANGE COLUMN TEMPO_VIDA_MAQ TEMPO_VIDA VARCHAR(10);

ALTER TABLE MAQUINAS
ADD INDEX IDX_TEMPO_VIDA (TEMPO_VIDA);

ALTER TABLE MAQUINAS
DROP COLUMN MAQ_OBSERVACOES;

# ALTER para TABELA RECURSOS_ESPECIFICOS
ALTER TABLE RECURSOS_ESPECIFICOS
ADD DESC_COMP_RE VARCHAR(100) NOT NULL;

ALTER TABLE RECURSOS_ESPECIFICOS
MODIFY COLUMN QNTD_COMP VARCHAR(50);

ALTER TABLE RECURSOS_ESPECIFICOS
CHANGE COLUMN QNTD_COMP QUANTIDADE_COMP VARCHAR(50);

ALTER TABLE RECURSOS_ESPECIFICOS
ADD INDEX IDX_QUANTIDADE_COMP (QUANTIDADE_COMP);

ALTER TABLE RECURSOS_ESPECIFICOS
DROP COLUMN DESC_COMP_RE;

# ALTER para TABELA REGISTRO_SUPRIMENTOS
ALTER TABLE REGISTRO_SUPRIMENTOS
ADD DESC_SUPRIMENTO VARCHAR(100) NOT NULL;

ALTER TABLE REGISTRO_SUPRIMENTOS
MODIFY COLUMN QTD_SUPRIMENTO VARCHAR(50);

ALTER TABLE REGISTRO_SUPRIMENTOS
CHANGE COLUMN QTD_SUPRIMENTO QUANTIDADE_SUPRIMENTO VARCHAR(50);

ALTER TABLE REGISTRO_SUPRIMENTOS
ADD INDEX IDX_QTD_SUPRIMENTO (QUANTIDADE_SUPRIMENTO);

ALTER TABLE REGISTRO_SUPRIMENTOS
DROP COLUMN DESC_SUPRIMENTO;

# ALTER para TABELA FORMA_PAGAMENTO
ALTER TABLE FORMA_PAGAMENTO
ADD DESC_FORMA_PAGT VARCHAR(100) NOT NULL;

ALTER TABLE FORMA_PAGAMENTO
MODIFY COLUMN NOME_FORMA_PAGT VARCHAR(30);

ALTER TABLE FORMA_PAGAMENTO
CHANGE COLUMN NOME_FORMA_PAGT FORMA_PAGAMENTO_NOME VARCHAR(30);

ALTER TABLE FORMA_PAGAMENTO
ADD INDEX IDX_FORMA_PAGAMENTO (FORMA_PAGAMENTO_NOME);

ALTER TABLE FORMA_PAGAMENTO
DROP COLUMN DESC_FORMA_PAGT;

# ALTER para TABELA ENDERECOS
ALTER TABLE ENDERECOS
ADD END_OBS VARCHAR(100) NOT NULL;

ALTER TABLE ENDERECOS
MODIFY COLUMN LOGRADOURO_END VARCHAR(120);

ALTER TABLE ENDERECOS
CHANGE COLUMN LOGRADOURO_END RUA_ENDERECO VARCHAR(120);

ALTER TABLE ENDERECOS
ADD INDEX IDX_ENDERECO (RUA_ENDERECO);

ALTER TABLE ENDERECOS
DROP COLUMN END_OBS;

# ALTER para TABELA EMPRESAS
ALTER TABLE EMPRESAS
ADD EMAIL_EMP VARCHAR(100) NOT NULL;

ALTER TABLE EMPRESAS
MODIFY COLUMN CNPJ_EMP VARCHAR(18);

ALTER TABLE EMPRESAS
CHANGE COLUMN CNPJ_EMP CNPJ_EMPRESA VARCHAR(18);

ALTER TABLE EMPRESAS
ADD INDEX IDX_CNPJ_EMPRESA (CNPJ_EMPRESA);

ALTER TABLE EMPRESAS
DROP COLUMN EMAIL_EMP;

# ALTER para TABELA FUNCIONARIOS
ALTER TABLE FUNCIONARIOS
ADD EMAIL_FUNC VARCHAR(100) NOT NULL;

ALTER TABLE FUNCIONARIOS
MODIFY COLUMN NOME_FUNC VARCHAR(60);

ALTER TABLE FUNCIONARIOS
CHANGE COLUMN NOME_FUNC NOME_COMPLETO_FUNC VARCHAR(60);

ALTER TABLE FUNCIONARIOS
ADD INDEX IDX_NOME_FUNCIONARIO (NOME_COMPLETO_FUNC);

ALTER TABLE FUNCIONARIOS
DROP COLUMN EMAIL_FUNC;

# ALTER para TABELA ENCOMENDAS
ALTER TABLE ENCOMENDAS
ADD OBS_ENCOMENDA VARCHAR(100) NOT NULL;

ALTER TABLE ENCOMENDAS
MODIFY COLUMN VALOR_TOT_ENCOMENDA DECIMAL(12,2);

ALTER TABLE ENCOMENDAS
CHANGE COLUMN VALOR_TOT_ENCOMENDA TOTAL_ENCOMENDA DECIMAL(12,2);

ALTER TABLE ENCOMENDAS
ADD INDEX IDX_TOTAL_ENCOMENDA (TOTAL_ENCOMENDA);

ALTER TABLE ENCOMENDAS
DROP COLUMN OBS_ENCOMENDA;

# ALTER para TABELA PRODUTOS
ALTER TABLE PRODUTOS
ADD CODIGO_PRODUTO VARCHAR(100) NOT NULL;

ALTER TABLE PRODUTOS
MODIFY COLUMN NOME_PROD VARCHAR(60);

ALTER TABLE PRODUTOS
CHANGE COLUMN NOME_PROD NOME_PRODUTO VARCHAR(60);

ALTER TABLE PRODUTOS
ADD INDEX IDX_NOME_PRODUTO (NOME_PRODUTO);

ALTER TABLE PRODUTOS
DROP COLUMN CODIGO_PRODUTO;

# ALTER para TABELA COMPONENTES
ALTER TABLE COMPONENTES
ADD DESC_COMPONENTE VARCHAR(100) NOT NULL;

ALTER TABLE COMPONENTES
MODIFY COLUMN NOME_COMP VARCHAR(60);

ALTER TABLE COMPONENTES
CHANGE COLUMN NOME_COMP NOME_COMPLETO_COMP VARCHAR(60);

ALTER TABLE COMPONENTES
ADD INDEX IDX_COMPONENTE (NOME_COMPLETO_COMP);

ALTER TABLE COMPONENTES
DROP COLUMN DESC_COMPONENTE;

# ALTER para TABELA REGISTRO_MANUTENCAO
ALTER TABLE REGISTRO_MANUTENCAO
ADD OBS_MANUTENCAO VARCHAR(100) NOT NULL;

ALTER TABLE REGISTRO_MANUTENCAO
MODIFY COLUMN DESC_MANUTENCAO VARCHAR(200);

ALTER TABLE REGISTRO_MANUTENCAO
CHANGE COLUMN DESC_MANUTENCAO DESCRICAO_MANUTENCAO VARCHAR(200);

ALTER TABLE REGISTRO_MANUTENCAO
ADD INDEX IDX_DESC_MANUTENCAO (DESCRICAO_MANUTENCAO);

ALTER TABLE REGISTRO_MANUTENCAO
DROP COLUMN OBS_MANUTENCAO;

# ALTER para TABELA EMPRESAS_COMPONENTES
ALTER TABLE EMPRESAS_COMPONENTES
ADD OBS_EMPCOMP VARCHAR(100) NOT NULL;

ALTER TABLE EMPRESAS_COMPONENTES
MODIFY COLUMN QTD_COMPONENTES DECIMAL(12,2);

ALTER TABLE EMPRESAS_COMPONENTES
CHANGE COLUMN QTD_COMPONENTES QUANTIDADE_COMPONENTES DECIMAL(12,2);

ALTER TABLE EMPRESAS_COMPONENTES
ADD INDEX IDX_COMPONENTES (QUANTIDADE_COMPONENTES);

ALTER TABLE EMPRESAS_COMPONENTES
DROP COLUMN OBS_EMPCOMP;

# ALTER para TABELA COMPONENTES_PRODUTOS
ALTER TABLE COMPONENTES_PRODUTOS
ADD OBS_COMPPROD VARCHAR(100) NOT NULL;

ALTER TABLE COMPONENTES_PRODUTOS
MODIFY COLUMN QTD_COMPONENTES DECIMAL(12,2);

ALTER TABLE COMPONENTES_PRODUTOS
CHANGE COLUMN QTD_COMPONENTES QUANTIDADE_COMPONENTES DECIMAL(12,2);

ALTER TABLE COMPONENTES_PRODUTOS
ADD INDEX IDX_COMPPROD (QUANTIDADE_COMPONENTES);

ALTER TABLE COMPONENTES_PRODUTOS
DROP COLUMN OBS_COMPPROD;

# ALTER para TABELA MAQUINAS_PRODUTOS
ALTER TABLE MAQUINAS_PRODUTOS
ADD OBS_MAQPROD VARCHAR(100) NOT NULL;

ALTER TABLE MAQUINAS_PRODUTOS
MODIFY COLUMN QTD_PROD_PRODUZIDO DECIMAL(12,2);

ALTER TABLE MAQUINAS_PRODUTOS
CHANGE COLUMN QTD_PROD_PRODUZIDO QUANTIDADE_PROD_PRODUZIDO DECIMAL(12,2);

ALTER TABLE MAQUINAS_PRODUTOS
ADD INDEX IDX_MAQPROD (QUANTIDADE_PROD_PRODUZIDO);

ALTER TABLE MAQUINAS_PRODUTOS
DROP COLUMN OBS_MAQPROD;

# ALTER para TABELA ENCOMENDAS_PRODUTOS
ALTER TABLE ENCOMENDAS_PRODUTOS
ADD OBS_ENCPROD VARCHAR(100) NOT NULL;

ALTER TABLE ENCOMENDAS_PRODUTOS
MODIFY COLUMN OBS_ENCPROD VARCHAR(150);

ALTER TABLE ENCOMENDAS_PRODUTOS
CHANGE COLUMN OBS_ENCPROD OBS_ENCOMENDAS_PRODUTOS VARCHAR(150);

ALTER TABLE ENCOMENDAS_PRODUTOS
ADD INDEX IDX_ENCPROD (OBS_ENCOMENDAS_PRODUTOS);

ALTER TABLE ENCOMENDAS_PRODUTOS
DROP COLUMN OBS_ENCOMENDAS_PRODUTOS;

# ALTER para TABELA FUNCIONARIOS_PRODUTOS
ALTER TABLE FUNCIONARIOS_PRODUTOS
ADD OBS_FUNCPROD VARCHAR(100) NOT NULL;

ALTER TABLE FUNCIONARIOS_PRODUTOS
MODIFY COLUMN OBS_FUNCPROD VARCHAR(150);

ALTER TABLE FUNCIONARIOS_PRODUTOS
CHANGE COLUMN OBS_FUNCPROD OBS_FUNCIONARIOS_PRODUTOS VARCHAR(150);

ALTER TABLE FUNCIONARIOS_PRODUTOS
ADD INDEX IDX_FUNCPROD (OBS_FUNCIONARIOS_PRODUTOS);

ALTER TABLE FUNCIONARIOS_PRODUTOS
DROP COLUMN OBS_FUNCIONARIOS_PRODUTOS;

DROP TABLE IF EXISTS FUNCIONARIOS_PRODUTOS;

DROP TABLE IF EXISTS ENCOMENDAS_PRODUTOS;

DROP TABLE IF EXISTS MAQUINAS_PRODUTOS;

DROP TABLE IF EXISTS COMPONENTES_PRODUTOS;

DROP TABLE IF EXISTS EMPRESAS_COMPONENTES;

DROP TABLE IF EXISTS REGISTRO_MANUTENCAO;

DROP TABLE IF EXISTS COMPONENTES;

DROP TABLE IF EXISTS PRODUTOS;

DROP TABLE IF EXISTS ENCOMENDAS;

DROP TABLE IF EXISTS FUNCIONARIOS;

DROP TABLE IF EXISTS EMPRESAS;

DROP TABLE IF EXISTS ENDERECOS;

DROP TABLE IF EXISTS FORMA_PAGAMENTO;

DROP TABLE IF EXISTS REGISTRO_SUPRIMENTOS;

DROP TABLE IF EXISTS RECUSOS_ESPECIFICOS;

DROP TABLE IF EXISTS MAQUINAS;

DROP TABLE IF EXISTS TIPO_COMPONENTE;

DROP TABLE IF EXISTS TIPO_ENDERECO;

DROP TABLE IF EXISTS TELEFONES;