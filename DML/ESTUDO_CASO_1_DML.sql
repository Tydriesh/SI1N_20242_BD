use ec1_si1n;

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