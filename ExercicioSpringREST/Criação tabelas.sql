create database campeonatobasquete
go

create table times(
	id int not null identity(4000, 1),
	nome varchar(50) not null unique,
	cidade varchar(80) not null

	primary key(id)
)

create table jogador(

	codigo int not null identity(900101, 1),
	nomeJogador varchar(60) not null unique,
	sexo char(1) null default('M') check(sexo = 'M'or sexo = 'F'),
	altura decimal(7,2),
	dt_nasc datetime not null check(dt_nasc < '01/01/2000'),
	id_time int not null

	primary key(codigo),
	foreign key(id_time) references times(id),
	constraint chk_sx_alt
		check((sexo = 'M' and altura >=1.7) or 
				(sexo = 'F' and altura >=1.6))
)


