use ec4_si1n;

insert into alunos(NOME_ALUNO, CPF_ALUNO, DATA_NASC_ALUNO, RUA_ALUNO, BAIRRO_ALUNO, CIDADE_ALUNO, NUM_CASA_ALUNO, UF_ALUNO, CEP_ALUNO, EMAIL_ALUNO, TEL_ALUNO) values
('Alice Silva', '123.456.789-00', '2000-05-15', 'Rua das Flores', 'Centro', 'São Paulo', '123', 'SP', '01000-000', 'alice.silva@email.com', '(11) 91234-5678'),
('Bruno Oliveira', '234.567.890-01', '1998-11-20', 'Avenida Paulista', 'Bela Vista', 'São Paulo', '456', 'SP', '01310-000', 'bruno.oliveira@email.com', '(11) 92345-6789'),
('Carla Souza', '345.678.901-02', '2001-03-10', 'Rua das Palmeiras', 'Centro', 'Rio de Janeiro', '789', 'RJ', '20000-000', 'carla.souza@email.com', '(21) 93456-7890'),
('Diego Costa', '456.789.012-03', '1999-07-25', 'Rua do Sol', 'Boa Vista', 'Belo Horizonte', '321', 'MG', '30130-000', 'diego.costa@email.com', '(31) 94567-8901'),
('Elena Martins', '567.890.123-04', '2002-01-30', 'Avenida das Américas', 'Copacabana', 'Rio de Janeiro', '654', 'RJ', '22000-000', 'elena.martins@email.com', '(21) 95678-9012');

insert into instrutores (NOME_INSTRUTOR, CPF_INSTRUTOR) values
('Carlos Silva', '123.456.789-00'),
('Mariana Oliveira', '234.567.890-11'),
('Pedro Santos', '345.678.901-22'),
('Ana Paula Souza', '456.789.012-33'),
('Lucas Almeida', '567.890.123-44');

insert into modalidades (NOME_MODALIDADE) values
('Musculação'),
('Yoga'),
('Pilates'),
('Natação'),
('Boxe');

insert into pagamentos(ID_ALUNO, DATA_PAGT, VALOR_PAGT, STATUS_PAGT) values
(1, '2024-01-15', 250.00, 'Pago'),
(2, '2024-02-10', 300.00, 'Pendente'),
(3, '2024-02-20', 275.00, 'Pago'),
(4, '2024-03-05', 320.00, 'Atrasado'),
(5, '2024-03-15', 250.00, 'Pago');

insert into plano_treino values
(1, 1, 'Em progresso'),
(2, 2, 'Finalizado'),
(3, 3, 'Em progresso'),
(4, 4, 'Aguardando início'),
(5, 5, 'Em progresso');

insert into instrutores_modalidades values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

insert into aulas(HORA_AULA, CAPC_AULA, ID_INSTRUTOR_MOD, ID_MODALIDADE_INST) values
('08:00', 20, 1, 1),
('10:00', 25, 2, 2),
('12:00', 15, 3, 3),
('14:00', 30, 4, 4),
('16:00', 20, 5, 5);

insert into aulas_alunos values
(1, 5, 1, 5),
(2, 4, 2, 4),
(3, 3, 3, 3),
(4, 2, 4, 2),
(5, 1, 5, 1);