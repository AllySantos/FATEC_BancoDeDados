
create database bdExQueriesDinamicas

use bdExQueriesDinamicas

create table tb_produto(
	cod_produto int primary key,
	nome_produto varchar(255) not null,
	valor_produto smallmoney not null	
)

--(Codigo_Transacao | Codigo_Produto | Quantidade | Valor_Total)
create table tb_entrada(
	cod_transacao int primary key ,
	cod_produto int foreign key references tb_produto(cod_produto),
	qtde int not null,
	valor_total smallmoney not null
)

create table tb_saida(
	cod_transacao int primary key,
	cod_produto int foreign key references tb_produto(cod_produto),
	qtde int not null,
	valor_total smallmoney not null
)


insert into tb_produto values 
	(1, 'Notebook', 3000.00)
	,(2, 'Celular', 1000.00)
	,(3, 'Monitor', 800.50)

	select * from  tb_produto