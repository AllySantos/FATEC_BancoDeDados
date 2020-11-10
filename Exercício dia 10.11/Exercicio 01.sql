/*create database exercicio01
go
*/
use exercicio01
go

create table tbAluno(
	ra int primary key identity (12345, 1)
	,nome varchar (50) not null
	,sobrenome varchar(100) not null
	,rua varchar(200) not null
	,numero int not null
	,bairro varchar(150) not null
	,cep char(8) not null
	,telefone char(8)
)

create table tbCurso(
	cod int primary key identity (1,1)
	,nome varchar(100) not null
	,cargaHoraria int not null
	,turno varchar(50)
)

create table tbDisciplinas(
	cod int primary key identity (1,1)
	,nome varchar(100) not null
	,cargaHoraria int not null
	,turno varchar(50)
	,semestre int not null
)

insert into tbAluno (nome, sobrenome, rua, numero, bairro, cep, telefone)
	values ('Jos�',	'Silva',	'Almirante Noronha',	236,	'Jardim S�o Paulo',	'1589000',	'69875287')
	,('Jos�', 'Silva', 'Almirante Noronha', 236, 'Jardim S�o Paulo', '1589000', '69875287')
	,('Ana', 'Maria Bastos', 'Anhaia', 1568, 'Barra Funda', '3569000', '25698526')
	,( 'Mario', 'Santos', 'XV de Novembro', 1841, 'Centro', '1020030', null)
	,( 'Marcia', 'Neves', 'Volunt�rios da Patria', 225, 'Santana', '2785090', '78964152')


insert into tbCurso(nome, cargaHoraria, turno)
	values ('Inform�tica', 2800, 'Tarde')
	,('Inform�tica', 2800, 'Noite')
	,('Log�stica', 2650, 'Tarde')
	,('Log�stica', 2650, 'Noite')
	,('Pl�sticos', 2500, 'Tarde')
	,('Pl�sticos', 2500, 'Noite')

insert into tbDisciplinas(nome, cargaHoraria, turno, semestre)
	values ('Inform�tica', 4, 'Tarde', 1)
	,('Inform�tica', 4, 'Noite', 1)
	,('Quimica', 4, 'Tarde', 1)
	,('Quimica', 4, 'Noite', 1)
	,('Banco de Dados I', 2, 'Tarde', 3)
	,('Banco de Dados I', 2, 'Noite', 3)
	,('Estrutura de Dados', 4, 'Tarde', 4)
	,('Estrutura de Dados', 4, 'Noite', 4)


select nome + ' ' + sobrenome as 'Nome Completo' from tbAluno


select rua + ', ' + CAST(numero as varchar(5)) + ' - ' + bairro + ' - ' + cep  as 'Endere�o Completo' from tbAluno
where telefone IS NULL

select telefone from tbAluno
where ra = 12349

select semestre from tbDisciplinas
where nome like 'Banco de Dados I' and turno = 'Noite'