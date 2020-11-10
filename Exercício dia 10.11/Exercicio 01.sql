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
	values ('José',	'Silva',	'Almirante Noronha',	236,	'Jardim São Paulo',	'1589000',	'69875287')
	,('José', 'Silva', 'Almirante Noronha', 236, 'Jardim São Paulo', '1589000', '69875287')
	,('Ana', 'Maria Bastos', 'Anhaia', 1568, 'Barra Funda', '3569000', '25698526')
	,( 'Mario', 'Santos', 'XV de Novembro', 1841, 'Centro', '1020030', null)
	,( 'Marcia', 'Neves', 'Voluntários da Patria', 225, 'Santana', '2785090', '78964152')


insert into tbCurso(nome, cargaHoraria, turno)
	values ('Informática', 2800, 'Tarde')
	,('Informática', 2800, 'Noite')
	,('Logística', 2650, 'Tarde')
	,('Logística', 2650, 'Noite')
	,('Plásticos', 2500, 'Tarde')
	,('Plásticos', 2500, 'Noite')

insert into tbDisciplinas(nome, cargaHoraria, turno, semestre)
	values ('Informática', 4, 'Tarde', 1)
	,('Informática', 4, 'Noite', 1)
	,('Quimica', 4, 'Tarde', 1)
	,('Quimica', 4, 'Noite', 1)
	,('Banco de Dados I', 2, 'Tarde', 3)
	,('Banco de Dados I', 2, 'Noite', 3)
	,('Estrutura de Dados', 4, 'Tarde', 4)
	,('Estrutura de Dados', 4, 'Noite', 4)


select nome + ' ' + sobrenome as 'Nome Completo' from tbAluno


select rua + ', ' + CAST(numero as varchar(5)) + ' - ' + bairro + ' - ' + cep  as 'Endereço Completo' from tbAluno
where telefone IS NULL

select telefone from tbAluno
where ra = 12349

select semestre from tbDisciplinas
where nome like 'Banco de Dados I' and turno = 'Noite'