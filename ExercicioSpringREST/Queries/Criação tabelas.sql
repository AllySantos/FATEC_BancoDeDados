create database campeonatobasquete
go

create table times(
	id int not null identity(4000, 1),
	nome varchar(50) not null unique,
	cidade varchar(80) not null

	primary key(id)
)