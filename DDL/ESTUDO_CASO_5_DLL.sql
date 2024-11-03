CREATE SCHEMA EC5_SI1N;

USE EC5_SI1N;

CREATE TABLE IF NOT EXISTS CLIENTES(
ID_CLIENTE INT PRIMARY KEY,
NOME_CLIENTE VARCHAR(100) NOT NULL,
CPF_CLIENTE VARCHAR(20) NOT NULL,
TELEFONE_CLIENTE VARCHAR(13) NOT NULL,
DATANASC_CLIENTE VARCHAR(10) NOT NULL,
STATUSFIDELIDADE_CLIENTE VARCHAR(100) NOT NULL,
CEP_CLIENTE VARCHAR(50) NOT NULL,
RUA_CLIENTE VARCHAR(50) NOT NULL,
NUMCASA_CLIENTE VARCHAR(5) NOT NULL,
BAIRRO_CLIENTE VARCHAR(40) NOT NULL,
IDADE_CLIENTE VARCHAR(3) NOT NULL,
UF_CLIENTE CHAR(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS PRODUTOS(
ID_PRODUTO INT PRIMARY KEY,
CATEGORIA_PRODUTO VARCHAR(45) NOT NULL,
QUANTIDADEESTOQUE_PRODUTO VARCHAR(20) NOT NULL,
PREÇO_PRODUTO VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS FORNECEDORES(
ID_FORNECEDOR INT PRIMARY KEY,
NOME_FORNECEDOR VARCHAR(100) NOT NULL,
TELEFONE_FORNECEDOR VARCHAR(13) NOT NULL,
CPF_FORNECEDOR VARCHAR(20) NOT NULL,
EMAIL_FORNECEDOR VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS VENDAS(
ID_VENDA INT PRIMARY KEY,
VALOR_VENDA VARCHAR(45) NOT NULL,
ID_CLIENTE INT,
CONSTRAINT VENDAS_CLIENTES FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTES(ID_CLIENTE)
);

CREATE TABLE IF NOT EXISTS PAGAMENTOS(
FORMA_PAGAMENTO INT PRIMARY KEY,
DATA_PAGAMENTO DATE NOT NULL,
VALOR_PAGAMENTO VARCHAR(45) NOT NULL,
STATUS_PAGAMENTO VARCHAR(30) NOT NULL,
ID_VENDA_PAGT INT,
CONSTRAINT PAGT_VENDAS FOREIGN KEY(ID_VENDA_PAGT) REFERENCES VENDAS(ID_VENDA)
);

CREATE TABLE IF NOT EXISTS PRODUTOS_VENDAS(
ID_PRODUTO INT,
ID_VENDA INT,
PRIMARY KEY(ID_PRODUTO, ID_VENDA),
QNTDPRODUTO_VENDA VARCHAR(30),
CONSTRAINT PRODTVEND_PRODUTO FOREIGN KEY(ID_PRODUTO) REFERENCES PRODUTOS(ID_PRODUTO),
CONSTRAINT PRODTVEND_VENDAS FOREIGN KEY(ID_VENDA) REFERENCES VENDAS(ID_VENDA)
);

CREATE TABLE IF NOT EXISTS PRODUTOS_FORNECEDORES(
ID_PRODUTO INT,
ID_FORNECEDOR INT,
PRIMARY KEY(ID_PRODUTO, ID_FORNECEDOR),
CONSTRAINT PRDFORN_PRODUTO FOREIGN KEY(ID_PRODUTO) REFERENCES PRODUTOS(ID_PRODUTO),
CONSTRAINT PRDFORN_FORNECEDORES FOREIGN KEY(ID_FORNECEDOR) REFERENCES FORNECEDORES(ID_FORNECEDOR)
);

# ALTER ADD: Adiciona uma nova coluna 'EMAIL_CLIENTE' na tabela CLIENTES.
ALTER TABLE CLIENTES 
ADD EMAIL_CLIENTE VARCHAR(100) NOT NULL;

# ALTER MODIFY COLUMN: Modifica o tipo de dado da coluna 'IDADE_CLIENTE' de VARCHAR para INT na tabela CLIENTES.
ALTER TABLE CLIENTES 
MODIFY COLUMN IDADE_CLIENTE INT NOT NULL;

# ALTER CHANGE COLUMN: Renomeia a coluna 'QUANTIDADEESTOQUE_PRODUTO' para 'QUANTIDADE_ESTOQUE' na tabela PRODUTOS.
ALTER TABLE PRODUTOS 
CHANGE COLUMN QUANTIDADEESTOQUE_PRODUTO QUANTIDADE_ESTOQUE VARCHAR(20) NOT NULL;

# ALTER ADD INDEX: Adiciona um índice na coluna 'NOME_FORNECEDOR' na tabela FORNECEDORES para melhorar a performance de busca.
ALTER TABLE FORNECEDORES 
ADD INDEX IDX_NOME_FORNECEDOR (NOME_FORNECEDOR);

# ALTER DROP COLUMN: Remove a coluna 'TELEFONE_FORNECEDOR' da tabela FORNECEDORES.
ALTER TABLE FORNECEDORES 
DROP COLUMN TELEFONE_FORNECEDOR;

# ALTER ADD: Adiciona uma nova coluna 'DATA_VENDA' na tabela VENDAS.
ALTER TABLE VENDAS 
ADD DATA_VENDA DATE NOT NULL;

# ALTER MODIFY COLUMN: Modifica o tipo de dado da coluna 'VALOR_PAGAMENTO' para DECIMAL na tabela PAGAMENTOS.
ALTER TABLE PAGAMENTOS 
MODIFY COLUMN VALOR_PAGAMENTO DECIMAL(10,2) NOT NULL;

# ALTER CHANGE COLUMN: Renomeia a coluna 'QNTDPRODUTO_VENDA' para 'QUANTIDADE_PRODUTO_VENDA' na tabela PRODUTOS_VENDAS.
ALTER TABLE PRODUTOS_VENDAS 
CHANGE COLUMN QNTDPRODUTO_VENDA QUANTIDADE_PRODUTO_VENDA VARCHAR(30);

# ALTER ADD INDEX: Adiciona um índice na coluna 'ID_FORNECEDOR' na tabela PRODUTOS_FORNECEDORES para melhorar a performance de busca.
ALTER TABLE PRODUTOS_FORNECEDORES 
ADD INDEX IDX_ID_FORNECEDOR (ID_FORNECEDOR);

DROP TABLE IF EXISTS PRODUTOS_FORNECEDORES;

DROP TABLE IF EXISTS PRODUTOS_VENDAS;

DROP TABLE IF EXISTS PAGAMENTOS;

DROP TABLE IF EXISTS VENDAS;

DROP TABLE IF EXISTS FORNECEDORES;

DROP TABLE IF EXISTS PRODUTOS;

DROP TABLE IF EXISTS CLIENTES;
