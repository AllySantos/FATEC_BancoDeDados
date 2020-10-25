/*Exercicio CRUD*/
create database bdLivraria
go

use bdLivraria
go

create table tbLivro(

	Codigo_Livro int primary key identity (1001,1)
	,Nome varchar(100) not null
	,Lingua varchar(50) not null
	,Ano varchar(10) not null
)

create table tbAutor (
	Codigo_Autor int primary key identity(10001,1)
	,Nome varchar(100) not null
	,Nascimento date not null
	,Pais varchar(50) not null
	,Biografia varchar(max) not null
)


create table tbLivro_Autor(
	Codigo_Livro int 
	,Codigo_Autor int 

primary key(Codigo_Autor, Codigo_Livro)

foreign key (Codigo_Livro) references tbLivro(Codigo_Livro)
,foreign key (Codigo_Autor) references tbAutor(Codigo_Autor)
)


create table tbEdicoes(
	isbn int primary key
	,Preco decimal (7,2) not null
	,Ano int not null
	,Num_Paginas int not null
	,Qtd_Estoque int not null 
)

create table tbEditora(
	Codigo_Editora int primary key identity(1,1)
	,Nome varchar(50) not null
	,Logradouro varchar(255) not null
	,Numero int not null
	,CEP char(8) not null
	,Telefone char(11) not null
)

create table tbLivro_Edicoes_Editora(
	EdicoesISBN int
	,Codigo_Editora int
	,Codigo_Livro int

primary key(EdicoesISBN, Codigo_Editora, Codigo_Livro)

foreign key(EdicoesISBN) references tbEdicoes(isbn)
,foreign key (Codigo_Editora) references tbEditora(Codigo_Editora)
,foreign key (Codigo_Livro) references tbLivro(Codigo_Livro)
)


select * from tbAutor

/*UPDATE

MUDA NOME DA COLUNA
exec sp_RENAME 'tbEdicoes.Ano', 'AnoEdicao', 'COLUMN'

MUDA TAMANHO DO VARCHAR
alter table tbEditora alter column Nome varchar(30) 

MUDA TIPO COLUNA
alter table tbAutor alter column Nascimento int
*/


/*INSERTS*/
INSERT INTO tbLivro (Nome, Lingua, Ano)
values ('ccna 4.1',	'PT - BR', 2015)
	,('HTML 5', 'PT - BR', 2017)
	,('Redes de Computadores', 'EN', 2010)
	,('Android em Ação', 'PT - BR', 2018)


INSERT INTO	tbAutor(Nome, Nascimento, Pais, Biografia)
values ('Inácio da Silva', 1975, 'Brasil', 'Programador Web desde 1995')
	,('Andrew Tannenbaum', 1944, 'EUA', 'Chefe do departartamento de Sistemas de Computação da Universidade de Vrijj')
	,('Luis Rocha', 1967, 'Brasil', 'Programador Mobile desde 2000')
	,('David Halliday', 1916, 'EUA', 'Físico PH.D desde 1941')


INSERT INTO tbLivro_Autor
values (1001, 10001)
	,(1002, 10003)
	,(1003, 10002)
	,(1004, 10003)


INSERT INTO tbEdicoes (isbn, Preco, AnoEdicao, Num_Paginas, Qtd_Estoque)
values (0130661023, 189.99, 2018, 653, 10)

select * from tbLivro
select * from tbAutor
select * from tbLivro_Autor
select * from tbEdicoes


/*UPDATES*/

UPDATE tbAutor 
set Biografia = 'Chefe do departartamento de Sistemas de Computação da Universidade de Vrije'
where Codigo_Autor = 10002
select * from tbAutor

update tbEdicoes
set Qtd_Estoque = Qtd_Estoque - 2
where isbn = 0130661023
select * from tbEdicoes


delete tbLivro_Autor where Codigo_Autor = (select Codigo_Autor from tbAutor where Nome = 'David Halliday')
delete tbAutor where Codigo_Autor = (select Codigo_Autor from tbAutor where Nome = 'David Halliday')