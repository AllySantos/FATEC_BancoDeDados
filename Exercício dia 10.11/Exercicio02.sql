/*create database exercicio02
go*/
use exercicio02
go

create table tbCarro(
	placa char(7) primary key
	,marca varchar(20) not null
	,modelo varchar(30) not null
	,cor varchar(20) not null
	,ano int not null
)

create table tbCliente(
	carro char(7) primary key
	,nome varchar(200) not null
	,logradouro varchar(200) not null
	,bairro varchar(100) not null

foreign key(carro) references tbCarro(placa)

)

create table tbPecas(
	codigo int primary key identity(1,1)
	,nome varchar(100) not null
	,valor smallmoney not null
)

create table tbServicos(
	carro char(7) foreign key references tbCarro(placa) 
	,codPeca int not null
	,qtde int not null
	,valor smallmoney not null
	,dtServico datetime not null

primary key(carro, codPeca, dtServico)
)
