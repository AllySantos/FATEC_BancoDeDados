/*Inserir dados nas tabelas*/

insert into Curso (Codigo_Curso, Nome, Sigla)
values (1, 'Analise e Desenvolvimento de Sistemas', 'ADS'),
(2, 'Logistica', 'LOG'),
(3, 'Comércio Exterior', 'COMEX'),
(4, 'Recursos Humanos', 'RH')

select * from Curso

insert into Aluno (Ra, Nome, Codigo_Curso)
values ('1234567', 'Alicia', 1),
('7654321', 'Karine', 1),
('5552222', 'Adriano', 2),
('3336666', 'Leonardo', 2),
('8885554', 'Roberto', 3),
('7777888', 'Gustavo', 4)

select * from Aluno

insert into Palestrante(Nome, Empresa)
values ('João', 'Google'),
('Maria', 'Avanade')

select * from Palestrante

--DATETIME: YYYY-MM-DD hh:mm:ss

insert into Palestra(Titulo, Carga_Horaria, Data_Palestra, Codigo_Palestrante)
values ('Desafios em TI', 3, '2021-03-20', 1),
('Hackaton', 5, '2021-04-10', 2)

select * from Palestra

insert into Alunos_Inscritos (Ra, Codigo_Palestra)
values ('1234567', 1),
('7654321', 1),
('5552222', 1),
('3336666', 2),
('8885554', 2),
('7777888', 2)


select * from Alunos_Inscritos

insert into Nao_Alunos(RG, Orgao_Exp, Nome)
values ('1234567', 'SP', 'Joao'),
('8888888', 'SP', 'Maria'),
('7777777', 'RJ', 'José'),
('6666666', 'RJ', 'Ana')

select * from Nao_Alunos

insert into Nao_Alunos_Inscritos (Codigo_Palestra, RG, Orgao_Exp)
values (1, '1234567', 'SP'),
(1, '8888888', 'SP'),
(2, '7777777', 'RJ'),
(2, '6666666', 'RJ')

select * from Nao_Alunos_Inscritos