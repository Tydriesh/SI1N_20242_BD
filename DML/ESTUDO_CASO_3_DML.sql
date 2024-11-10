use ec3_si1n;

insert into telefones values
(1, '999999999', '11', '55'),
(2, '988888888', '21', '55'),
(3, '977777777', '31', '55'),
(4, '966666666', '41', '55'),
(5, '955555555', '51', '55');

insert into tipo_endereco values
(1, 'Residencial'),
(2, 'Comercial'),
(3, 'Industrial'),
(4, 'Rural'),
(5, 'Público');

insert into tipo_componente values
(1, 'Eletrônico'),
(2, 'Mecânico'),
(3, 'Estrutural'),
(4, 'Hidráulico'),
(5, 'Software');

insert into maquinas values
(1, 5, '2020-01-10', '2025-01-10'),
(2, 7, '2019-06-15', '2026-06-15'),
(3, 10, '2015-11-20', '2025-11-20'),
(4, 3, '2022-03-01', '2025-03-01'),
(5, 6, '2021-09-05', '2027-09-05');

insert into recursos_especificos values
(1, 20.50, 'Unidade', 10.00, 5.00),
(2, 15.00, 'Kg', 8.00, 3.50),
(3, 30.00, 'Metros', 12.00, 6.00),
(4, 50.00, 'Litros', 15.00, 7.00),
(5, 25.00, 'Peças', 10.00, 4.50);

insert into registro_suprimentos values
(1, 100.50, '2024-11-15'),
(2, 200.00, '2024-11-20'),
(3, 150.75, '2024-11-18'),
(4, 50.25, '2024-11-25'),
(5, 75.10, '2024-11-30');

insert into forma_pagamento values
(1, 'Dinheiro'),
(2, 'Cartão Débito'),
(3, 'Cartão Crédito'),
(4, 'Boleto'),
(5, 'Pix');

insert into enderecos values
(1, 'Rua das Flores', 123, 'Apto 301', '12345-678', 'Centro', 'São Paulo', 'SP', 1),
(2, 'Avenida Paulista', 456, 'Sala 405', '98765-432', 'Bela Vista', 'São Paulo', 'SP', 2),
(3, 'Rua XV de Novembro', 789, 'Casa 7', '54321-987', 'Centro', 'Curitiba', 'PR', 1),
(4, 'Rua das Acácias', 101, 'Casa 15', '45678-123', 'Vila Nova', 'Rio de Janeiro', 'RJ', 3),
(5, 'Avenida Brasil', 2000, 'Loja 22', '78965-432', 'Botafogo', 'Rio de Janeiro', 'RJ', 2);

insert into empresas values
(1, '12.345.678/0001-90', 'Tech Solutions Ltda.', 'Tecnologia', '2023-03-15', 'Privada', 'Carlos Silva', 1, 1),
(2, '98.765.432/0001-12', 'Distribuidora de Alimentos S.A.', 'Alimentos', '2022-11-01', 'Pública', 'Maria Oliveira', 2, 2),
(3, '23.456.789/0001-23', 'Construtora A.B.C.', 'Construção Civil', '2021-06-25', 'Privada', 'José Santos', 3, 3),
(4, '34.567.890/0001-34', 'Supermercados X Ltda.', 'Varejo', '2024-01-10', 'Privada', 'Ana Souza', 4, 4),
(5, '45.678.901/0001-45', 'Consultoria Empresarial S.A.', 'Consultoria', '2020-05-30', 'Pública', 'Ricardo Lima', 5, 5);

insert into funcionarios values
(1, 'João Silva', 3500.00, '2022-08-15', 'Graduado em Administração', 'Gerente de Vendas', 1, 1),
(2, 'Maria Oliveira', 2800.00, '2021-12-10', 'Técnico em Logística', 'Supervisor de Logística', 2, 2),
(3, 'Carlos Souza', 4500.00, '2019-06-25', 'Mestre em Engenharia', 'Engenheiro Civil', 3, 3),
(4, 'Ana Costa', 3200.00, '2023-02-01', 'Bacharel em Psicologia', 'Analista de Recursos Humanos', 4, 4),
(5, 'Ricardo Lima', 5000.00, '2020-04-30', 'Mestre em Marketing', 'Diretor de Marketing', 5, 5);

insert into encomendas values
(1, '2024-11-01', 1000.00, 100.00, 900.00, 3, 1, 1),
(2, '2024-11-03', 500.00, 50.00, 450.00, 2, 2, 2),
(3, '2024-11-05', 1200.00, 150.00, 1050.00, 5, 3, 1),
(4, '2024-11-07', 700.00, 70.00, 630.00, 4, 4, 3),
(5, '2024-11-10', 1500.00, 200.00, 1300.00, 6, 5, 2);

insert into produtos values
(1, 'Produto A', 'Vermelho', '10x10x10', 2.50, 5.00, NULL, 10.00, 1, 1),
(2, 'Produto B', 'Azul', '15x15x15', 3.75, 6.00, NULL, 12.50, 2, 2),
(3, 'Produto C', 'Verde', '20x20x20', 5.00, 7.50, NULL, 15.00, 3, 3),
(4, 'Produto D', 'Amarelo', '25x25x25', 7.25, 8.00, NULL, 18.00, 4, 4),
(5, 'Produto E', 'Preto', '30x30x30', 10.00, 9.00, NULL, 20.00, 5, 5);

insert into componentes values
(1, 'Componente A', 100.00, 10.50, 'Unidade', 1),
(2, 'Componente B', 200.00, 20.75, 'Unidade', 2),
(3, 'Componente C', 150.00, 30.00, 'Pacote', 3),
(4, 'Componente D', 50.00, 15.00, 'Unidade', 4),
(5, 'Componente E', 300.00, 25.50, 'Pacote', 1);

insert into registro_manutencao values
(1, '2024-11-01 08:00:00', 'Troca de peças e calibração de sistema', 1),
(2, '2024-11-05 10:30:00', 'Manutenção preventiva do motor', 2),
(3, '2024-11-08 14:15:00', 'Substituição do filtro de ar', 3),
(4, '2024-11-10 16:00:00', 'Ajuste de calibragem e troca de óleo', 4),
(5, '2024-11-12 09:30:00', 'Verificação geral e testes de operação', 5);

insert into empresas_componentes values
(1, 1, 150.00),
(2, 2, 300.00),
(3, 3, 500.00),
(4, 4, 200.00),
(5, 5, 100.00);

insert into componentes_produtos values
(1, 1, 50.00),
(2, 1, 30.00),
(3, 2, 20.00),
(4, 3, 10.00),
(5, 4, 15.00);

insert into maquinas_produtos values
(1, 1, 100.00),
(2, 1, 150.00),
(3, 2, 200.00),
(4, 3, 250.00),
(5, 4, 300.00);

insert into encomendas_produtos values
(1, 1, 10.00),
(1, 2, 5.00),
(2, 1, 15.00),
(3, 3, 8.00),
(4, 4, 20.00);

insert into funcionarios_produtos values
(1, 1, 10.00),
(1, 2, 5.00),
(2, 1, 8.00),
(3, 3, 15.00),
(4, 4, 12.00);