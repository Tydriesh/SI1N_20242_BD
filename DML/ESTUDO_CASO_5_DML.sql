use ec5_si1n;

INSERT INTO CLIENTES (ID_CLIENTE, NOME_CLIENTE, CPF_CLIENTE, TELEFONE_CLIENTE, DATANASC_CLIENTE, STATUSFIDELIDADE_CLIENTE, CEP_CLIENTE, RUA_CLIENTE, NUMCASA_CLIENTE, BAIRRO_CLIENTE, IDADE_CLIENTE, UF_CLIENTE) VALUES
(1, 'João Silva', '123.456.789-00', '11987654321', '1990-05-15', 'Fidelidade Ouro', '01010-000', 'Rua A', '123', 'Centro', '34', 'SP'),
(2, 'Maria Souza', '234.567.890-11', '11998765432', '1985-10-20', 'Fidelidade Prata', '02020-111', 'Rua B', '456', 'Bairro X', '39', 'RJ'),
(3, 'Carlos Almeida', '345.678.901-22', '11876543210', '2000-02-25', 'Fidelidade Bronze', '03030-222', 'Rua C', '789', 'Bairro Y', '24', 'MG'),
(4, 'Ana Costa', '456.789.012-33', '11765432109', '1995-08-30', 'Fidelidade Ouro', '04040-333', 'Rua D', '101', 'Bairro Z', '29', 'BA'),
(5, 'Paulo Pereira', '567.890.123-44', '11654321098', '1992-04-05', 'Fidelidade Prata', '05050-444', 'Rua E', '202', 'Bairro W', '32', 'PR');

INSERT INTO PRODUTOS (ID_PRODUTO, CATEGORIA_PRODUTO, QUANTIDADEESTOQUE_PRODUTO, PREÇO_PRODUTO) VALUES
(1, 'Eletrônicos', '50', '1000.00'),
(2, 'Roupas', '200', '150.00'),
(3, 'Alimentos', '300', '30.00'),
(4, 'Livros', '150', '50.00'),
(5, 'Móveis', '20', '500.00');

INSERT INTO FORNECEDORES (ID_FORNECEDOR, NOME_FORNECEDOR, TELEFONE_FORNECEDOR, CPF_FORNECEDOR, EMAIL_FORNECEDOR) VALUES
(1, 'Fornecedor A', '11912345678', '987.654.321-00', 'fornecedorA@email.com'),
(2, 'Fornecedor B', '11876543210', '876.543.210-11', 'fornecedorB@email.com'),
(3, 'Fornecedor C', '11765432109', '765.432.109-22', 'fornecedorC@email.com'),
(4, 'Fornecedor D', '11654321098', '654.321.098-33', 'fornecedorD@email.com'),
(5, 'Fornecedor E', '11543210987', '543.210.987-44', 'fornecedorE@email.com');

INSERT INTO VENDAS (ID_VENDA, VALOR_VENDA, ID_CLIENTE) VALUES
(1, '1500.00', 1),
(2, '500.00', 2),
(3, '2000.00', 3),
(4, '300.00', 4),
(5, '1000.00', 5);

INSERT INTO PAGAMENTOS (FORMA_PAGAMENTO, DATA_PAGAMENTO, VALOR_PAGAMENTO, STATUS_PAGAMENTO, ID_VENDA_PAGT) VALUES
(1, '2024-11-01', '1500.00', 'Pago', 1),
(2, '2024-11-02', '500.00', 'Pago', 2),
(3, '2024-11-03', '2000.00', 'Pendente', 3),
(4, '2024-11-04', '300.00', 'Pago', 4),
(5, '2024-11-05', '1000.00', 'Pendente', 5);

INSERT INTO PRODUTOS_VENDAS (ID_PRODUTO, ID_VENDA, QNTDPRODUTO_VENDA) VALUES
(1, 1, '2'),
(2, 2, '3'),
(3, 3, '5'),
(4, 4, '1'),
(5, 5, '4');

INSERT INTO PRODUTOS_FORNECEDORES (ID_PRODUTO, ID_FORNECEDOR) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);