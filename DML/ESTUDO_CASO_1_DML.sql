use ec1_si1n;

insert into fornecedores values
(1,"Queijos LTDA","Rua Quinze de Novembro",600,"Praia da Costa","Vila Velha","ES","Brasil","29100-030","2799999-8888","João Silva"),
(2,"Bom dia & Cia","Rua Carijo",50,"Fluminense","Rio de Janeiro","RJ","Brasil","20010-010","2198899-1234","Pedro Moraes"),
(3, "Supermercado Estrela", "Rua dos Andradas", 120, "Centro", "São Paulo", "SP", "Brasil", "01002-000", "113322-4455", "Maria Souza"),
(4, "Loja do João", "Avenida Paulista", 1500, "Bela Vista", "São Paulo", "SP", "Brasil", "01310-200", "1199988-7766", "João Fernandes"),
(5, "Padaria Pão Quente", "Rua das Flores", 35, "Jardim das Rosas", "Curitiba", "PR", "Brasil", "80520-100", "4198877-3344", "Ana Clara");

insert into filiais values
(1,"Filial São José","Rua Dr Antonio Basilio",31,"Jardim da Penha","Vitoria","ES","Brasil","29060-390",200),
(2, "Filial Zona Sul", "Rua das Laranjeiras", 456, "Laranjeiras", "Rio de Janeiro", "RJ", "Brasil", "22240-003", 350),
(3, "Filial Norte Shopping", "Avenida Dom Hélder Câmara", 5474, "Cachambi", "Rio de Janeiro", "RJ", "Brasil", "20771-004", 500),
(4, "Filial Paulista", "Avenida Brigadeiro Faria Lima", 1010, "Pinheiros", "São Paulo", "SP", "Brasil", "01452-000", 600),
(5, "Filial Centro Histórico", "Rua dos Andradas", 789, "Centro Histórico", "Porto Alegre", "RS", "Brasil", "90020-005", 450);

insert into produtos values
(1,"Celular X","Celular Azul","Produto de 128gb de memoria na cor azul",15,1200.00,"UN",5),
(2, "Notebook Z", "Notebook Cinza", "Laptop com processador i5, 8GB RAM e 256GB SSD", 10, 3500.00, "UN", 3),
(3, "TV Ultra HD", "Televisor 50 polegadas", "Televisor Ultra HD com resolução 4K", 7, 2200.00, "UN", 2),
(4, "Fone de Ouvido", "Fone Bluetooth", "Fone de ouvido Bluetooth com cancelamento de ruído", 50, 200.00, "UN", 10),
(5, "Smartwatch S", "Relógio Inteligente Preto", "Smartwatch com monitoramento de frequência cardíaca", 20, 800.00, "UN", 4);

insert into pedidos values
(1, '2024-11-01', '09:30:00', '2024-11-10', 'PENDENTE',1),
(2, '2024-11-02', '10:15:00', '2024-11-12', 'EM ESPERA',2),
(3, '2024-11-03', '11:45:00', '2024-11-13', 'CONCLUÍDO',3),
(4, '2024-11-04', '13:20:00', '2024-11-14', 'PENDENTE',4),
(5, '2024-11-24', '15:20:10', '2024-11-14', 'CONCLUÍDO',4),
(6, '2024-11-05', '15:00:00', '2024-11-15', 'PENDENTE',5);

insert into recebimentos values
('2024-11-01', '08:30:00', 150, 'Aprovado', 1),
('2024-11-02', '09:45:00', 300, 'Aprovado', 2),
('2024-11-03', '10:15:00', 50, 'Recusado', 3),
('2024-11-04', '11:00:00', 275, 'Aprovado', 4),
('2024-11-05', '14:30:00', 120, 'Em espera', 5);

insert into pedidos_produtos values
(1, 2, 15),
(1, 3, 20),
(2, 5, 50),
(3, 4, 10),
(4, 1, 25);

insert into filiais_produtos values
(1, 1, 100),
(1, 2, 200),
(2, 3, 150),
(3, 4, 300),
(4, 5, 50);

insert into fornecedores_produtos values
(1, 5),
(2, 4),
(3, 3),
(4, 2),
(5, 1),
(1, 2);
