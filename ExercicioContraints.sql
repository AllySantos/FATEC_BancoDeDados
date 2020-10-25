/*create database bdLivrariaConstraints
go
*/
use bdLivrariaConstraints
go

create table tbLivro(

	Codigo_Livro int primary key identity (1001,1)
	,Nome varchar(100) not null
	,Lingua varchar(50) default ('PT - BR')
	,Ano int not null

constraint AnoLivro_Lingua
	check ((Ano > 1990) AND (Lingua = 'PT - BR' OR Lingua = 'DE'))
)

create table tbAutor (
	Codigo_Autor int primary key identity(10001,1)
	,Nome varchar(100) unique not null
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
	,AnoEdicao int not null
	,Num_Paginas int not null
	,Qtd_Estoque int not null 

constraint Preco_NumPagina_Ano
	check((Ano > 1993) AND (Preco > 0.0) AND (Num_Paginas > 0))
)

create table tbEditora(
	Codigo_Editora int primary key identity(1,1)
	,Nome varchar(50) unique not null
	,Logradouro varchar(255) not null
	,Numero int not null
	,CEP char(8) not null
	,Telefone char(11) not null

constraint Numero
	check(Numero > 0)
)

create table tbLivro_Edicoes_Editora(
	EdicoesISBN int
	,Codigo_Editora int


primary key(EdicoesISBN, Codigo_Editora)

foreign key(EdicoesISBN) references tbEdicoes(isbn)
,foreign key (Codigo_Editora) references tbEditora(Codigo_Editora)
)

