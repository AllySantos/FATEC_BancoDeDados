/*create database exercicio07
go
*/
use exercicio07
go

create table tbCliente(

	rgCliente varchar(9) primary key not null
	,cpfCliente char(11) not null
	,nomeCliente varchar(150) not null
	,logCliente varchar(200) not null
	,numLogCliente int
)

create table tbPedido(
	notaFiscal int primary key identity (1001, 1)
	,valorPedido int not null
	,dtPedido datetime not null
	,rgCliente varchar(9) foreign key references tbCliente (rgCliente)
)

create table tbFornecedor(
	codFornecedor int primary key identity
	,nomeFornecedor varchar(50) not null unique
	,logFornecedor varchar(200) not null
	,numFornecedor int not null
	,telFornecedor char(10) 
	,cgcFornecedor varchar(13) 
	,cidadeFornecedor varchar(100) 
	,transporteFornecedor varchar(100)
	,paisFornecedor varchar(250) 
	,moedaFornecedor varchar(3)
)


create table tbMercadoria(
	codMercadoria int primary key identity(10, 1)
	,descMercadoria varchar(200) not null
	,precoMercadoria int not null
	,qtdeMercadoria int not null
	,codFornecedor int foreign key references tbFornecedor(codFornecedor)
	)

insert into tbCliente 
	values ('29531844', '34519878040', 'Luiz André', 'R. Astorga', 500)
	,('13514996x', '8498428560', 'Maria Luiza', 'R. Piauí', 174)
	,('121985541', '23354997310', 'Ana Barbara', 'Av. Jaceguai', 1141)
	,('23987746x', '43587669920', 'Marcos Alberto', 'R. Quinze', 22)
