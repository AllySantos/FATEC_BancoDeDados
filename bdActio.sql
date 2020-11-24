/*
use master
drop database bdActio
go

create database bdActio
go
*/

use bdActio
go

create table tbUsuario(
	idUsuario int primary key identity (1,1),
	nomeUsuario varchar(200) not null,
	sobrenomeUsuario varchar(200) not null,
	emailUsuario varchar(250) unique not null,
	senhaUsuario varchar(50) not null,
	fotoPerfil varchar(400) not null
)

create table tbProfessor(
	idProfessor int primary key 

--Herança
foreign key(idProfessor) references tbUsuario(idUsuario)
)


create table tbDisciplina(
	idDisciplina int primary key identity (1,1),
	nomeDisciplina varchar(250) unique not null,
	corDisciplina char(7) not null
)

create table tbTurma(
	idTurma int primary key identity (1,1),
	cursoTurma varchar(100) not null,
	semestreTurma int not null,
	periodoTurma varchar(50) not null,
	constraint chk_semestre
		check(semestreTurma > 0 and semestreTurma <= 6)
)

create table tbDisciplinaTurmaProfessor(
	idDisciplinaTurmaProfessor int primary key identity(1,1)
	,idDisciplina int foreign key references tbDisciplina(idDisciplina)
	,idTurma int foreign key references tbTurma(idTurma)
	,idProfessor  int foreign key references tbProfessor(idProfessor),

)
create table tbAluno(
	idAluno int primary key,
	idTurma int foreign key references tbTurma (idTurma),

--Herança
foreign key(idAluno) references tbUsuario(idUsuario)

)

create table tbTipoAtividade(
	idTipoAtividade int primary key identity(1,1),
	nomeTipoAtividade varchar(10)

)

create table tbAtividade (
	idAtividade int primary key identity (1,1),
	nomeAtividade varchar(150) not null,
	descAtividade varchar(500) not null,
	dtEmissaoAtividade datetime default (getdate()) not null,
	dtPublicacaoAtividade datetime not null,
	dtFechamentoAtividade datetime not null,
	arquivosAtividade varchar(500),
	idTipoAtividade int foreign key references tbTipoAtividade(idTipoAtividade),
	idDisciplinaTurmaProfessor int foreign key references tbDisciplinaTurmaProfessor(idDisciplinaTurmaProfessor),

	constraint chk_data
		check (dtEmissaoAtividade = getdate() and dtPublicacaoAtividade >= getdate() and dtFechamentoAtividade >= dtPublicacaoAtividade)

)

create table tbEntrega(
	idEntrega int primary key identity (1,1),
	arquivosEntrega varchar(500) not null,
	dtEntrega datetime not null,
	nota float not null,

	idAtividade int foreign key references tbAtividade(idAtividade),
	idAluno int foreign key references tbAluno(idAluno),

	constraint chk_nota
		check (nota >= 0 and nota <= 10)
)

--inserts

insert into tbUsuario(nomeUsuario, sobrenomeUsuario, emailUsuario, senhaUsuario, fotoPerfil)
	values 
	('Alicia', 'Santos', 'alichia09@hotmail.com', '123456', 'https://img.ibxk.com.br/2017/06/22/22100428046161.jpg')
	,('Leonardo', 'Mendes', 'leoMendes@hotmail.com', '123456', 'https://img.ibxk.com.br/2017/06/22/22100428046161.jpg')
	,('Adriano', 'Galan', 'adrgalan@hotmail.com', '123456', 'https://img.ibxk.com.br/2017/06/22/22100428046161.jpg')
	,('Roberto', 'Mitsunari', 'robMit@hotmail.com', '123456', 'https://img.ibxk.com.br/2017/06/22/22100428046161.jpg')
	,('Gustavo', 'Narciso', 'souLindo@hotmail.com', '123456', 'https://img.ibxk.com.br/2017/06/22/22100428046161.jpg')
	,('Karine', 'Medeiros', 'kaMedeiros@hotmail.com', '123456', 'https://img.ibxk.com.br/2017/06/22/22100428046161.jpg')

	
select * from tbUsuario


insert into tbProfessor (idProfessor)
values (3)
	  ,(4)
	  ,(6)
	
select * from tbProfessor

insert into tbDisciplina (nomeDisciplina, corDisciplina) 
	values ('Programação Orientada a Odio', '#FF9DBA')
		,('Lógica de Programação', '#9DC4FF')
		,('Banco de Dados', '#9DFFA1')
		,('Engenharia de Software III', '#FFDE9D')
		,('Sistemas da Informação', '#FFBA9D')
	

insert into tbTurma (cursoTurma, semestreTurma, periodoTurma)
	values ('ADS', 2, 'Tarde')
		,('ADS', 2, 'Noite')
		,('ADS', 1, 'Tarde')
		,('ADS', 1, 'Noite')
		
insert into tbDisciplinaTurmaProfessor(idDisciplina, idTurma, idProfessor)
values (1, 1, 3)
	,(2, 1, 4)
	,(1, 2, 6)
	,(3, 1, 4)
	,(3, 2, 4)

insert into tbAluno (idAluno, idTurma)  
	values (1, 1)
	      ,(2, 2)
	      ,(5, 3)

insert into tbTipoAtividade(nomeTipoAtividade)
	values ('Grupo')
		,('Individual')

insert into tbAtividade (nomeAtividade, descAtividade, dtEmissaoAtividade, dtPublicacaoAtividade,
					dtFechamentoAtividade, arquivosAtividade, idTipoAtividade, idDisciplinaTurmaProfessor)				
	values ( 'Lista de Exercícios', 'Entregar pelo site', GETDATE(),  '2021-12-10', '2021-12-12', 'pathArquivo', 2, 1)
			,('Entrega do Sistema', 'Entregar pelo site', GETDATE(), '2020-12-10', '2020-12-12','pathArquivo', 2, 2)
			,('Lote 01', 'Entregar pelo email', GETDATE(),  '2020-12-10', '2020-12-12', 'pathArquivo', 1, 4)
	
select * from tbAtividade
insert into tbEntrega(arquivosEntrega, dtEntrega, nota, idAtividade, idAluno)
	values ('', '2020-11-21', 8.0, 1, 1)
		,('', '2020-11-21', 10.0, 1, 2)
		,('', '2020-11-25', 10.0, 2, 5)


select  tbUsuario.nomeUsuario, tbUsuario.sobrenomeUsuario, 
tbTurma.idTurma, tbTurma.cursoTurma, tbTurma.semestreTurma,
tbDisciplina.idDisciplina, tbDisciplina.nomeDisciplina, tbDisciplina.corDisciplina,
prof.nomeUsuario as nomeProfessor
from tbUsuario 
inner join tbAluno on tbAluno.idAluno = tbUsuario.idUsuario
inner join tbTurma on tbAluno.idTurma = tbTurma.idTurma
inner join tbDisciplinaTurmaProfessor on tbDisciplinaTurmaProfessor.idTurma = tbTurma.idTurma
inner join tbDisciplina on tbDisciplina.idDisciplina = tbDisciplinaTurmaProfessor.idDisciplina
inner join tbUsuario as prof on tbDisciplinaTurmaProfessor.idProfessor = prof.idUsuario
where idAluno = 1


select * from tbAtividade where idTurma = 1


select tbAtividade.*, 
tbDisciplina.nomeDisciplina, tbDisciplina.corDisciplina,
tbTurma.cursoTurma, tbTurma.periodoTurma, tbTurma.semestreTurma 
from tbAtividade
inner join tbDisciplina on tbDisciplina.idDisciplina = tbAtividade.idDisciplina
inner join tbTurma on tbTurma.idTurma = tbAtividade.idTurma
where tbAtividade.idTurma = 1


select tbAtividade.*, 
tbDisciplina.nomeDisciplina, tbDisciplina.corDisciplina,
tbTurma.cursoTurma, tbTurma.periodoTurma, tbTurma.semestreTurma 
from tbAtividade
inner join tbDisciplinaTurmaProfessor on tbAtividade.idDisciplinaTurmaProfessor = tbDisciplinaTurmaProfessor.idDisciplinaTurmaProfessor
inner join tbDisciplina on tbDisciplinaTurmaProfessor.idDisciplina = tbDisciplina.idDisciplina
inner join tbTurma on tbDisciplinaTurmaProfessor.idTurma = tbTurma.idTurma
where tbDisciplinaTurmaProfessor.idTurma = 1

select tbDisciplina.* from tbDisciplina
inner join tbDisciplinaTurmaProfessor
on tbDisciplina.idDisciplina = tbDisciplinaTurmaProfessor.idDisciplina
inner join tbTurma
on tbTurma.idTurma = tbDisciplinaTurmaProfessor.idTurma
inner join tbAluno
on tbTurma.idTurma = tbAluno.idTurma
where idAluno = 1


select tbDisciplina.*, tbTurma.* from tbDisciplinaTurmaProfessor
inner join tbDisciplina on tbDisciplinaTurmaProfessor.idDisciplina = tbDisciplina.idDisciplina
inner join tbTurma on tbDisciplinaTurmaProfessor.idTurma = tbTurma.idTurma
where idProfessor = 4