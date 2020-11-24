/*create database bdExercicioPreP2
go
*/
use bdExercicioPreP2
go

create table tbCliente(
	cod int not null
	,nome varchar(200) not null
	,logradouro varchar(500)
	,numero int
	,telefone char(9)

primary key(cod)
)


create table tbAutor(
	cod int not null
	,nome varchar(200) not null
	,pais varchar(150) not null
	,biografia varchar(500) not null

primary key(cod)
)

create table tbCorredor(
	cod int
	,tipo varchar(100) not null

primary key(cod)
)



create table tbLivro(
	cod int
	,codAutor int not null
	,codCorredor int not null
	,nome varchar(200) not null
	,pag int not null
	,idioma varchar(150) not null
	

primary key(cod)

foreign key(codAutor) references tbAutor(cod)
,foreign key(codCorredor) references tbCorredor(cod)

)


create table tbEmprestimo(
	codCliente int
	,dtEmprestimo datetime not null
	,codLivro int

primary key(codCliente, codLivro)
foreign key(codCliente) references tbCliente(cod)
,foreign key(codLivro) references tbLivro(cod)
)
	


--SELECTS
-- Fazer uma consulta que retorne o nome do cliente e a data do empr�stimo formatada padr�o BR (dd/mm/yyyy)

select distinct tbCliente.nome ,convert(char(10), dtEmprestimo, 103) as 'Data de Emprestimo' from tbEmprestimo
inner join tbCliente on tbEmprestimo.codCliente = tbCliente.cod

-- Fazer uma consulta que retorne Nome do autor e Quantos livros foram escritos por Cada autor, ordenado pelo n�mero de livros. Se o nome do autor tiver mais de 25 caracteres, mostrar s� os 13 primeiros.

select  
	case when(len(tbAutor.nome) > 25)
		then 
			SUBSTRING(tbAutor.nome, 1, 13)
		else
			tbAutor.nome
		end as 'NomeAutor',
count(tbLivro.codAutor) as qtdeLivro from tbAutor
inner join tbLivro on tbLivro.codAutor = tbAutor.cod
group by tbAutor.nome
order by qtdeLivro desc

-- Fazer uma consulta que retorne o nome do autor e o pa�s de origem do livro com maior n�mero de p�ginas cadastrados no sistema

select tbAutor.nome, tbAutor.pais from tbAutor
inner join tbLivro on tbAutor.cod = tbLivro.codAutor
where tbLivro.pag = (select max(pag) from tbLivro)


-- Fazer uma consulta que retorne nome e endere�o concatenado dos clientes que tem livros emprestados

select distinct tbCliente.nome, tbCliente.logradouro + ' '+ convert(varchar(10), tbCliente.numero) as Endereco from tbCliente
inner join tbEmprestimo on tbCliente.cod = tbEmprestimo.codCliente

/*
Nome dos Clientes, sem repetir e, concatenados como
ender�o_telefone, o logradouro, o numero e o telefone) dos
clientes que N�o pegaram livros. Se o logradouro e o 
n�mero forem nulos e o telefone n�o for nulo, mostrar s� o telefone. 
Se o telefone for nulo e o logradouro e o n�mero n�o forem nulos, mostrar s� logradouro e n�mero. 
Se os tr�s existirem, mostrar os tr�s.
O telefone deve estar mascarado XXXXX-XXXX
*/

select distinct cod, tbCliente.nome,
	case when (tbCliente.logradouro is null and tbCliente.numero is null and tbCliente.telefone is null)
		then
			''
		else
			case when (tbCliente.logradouro is null and tbCliente.numero is null and tbCliente.telefone is  not null)
				then 
					SUBSTRING(tbCliente.telefone, 1, 6) + '-' +SUBSTRING(tbCliente.telefone, 7, 9)
				else
					case when (tbCliente.logradouro is not null and tbCliente.numero is not null and tbCliente.telefone is  null)
						then
							tbCliente.logradouro + ' '+ convert(varchar(10), tbCliente.numero)
						else
						tbCliente.logradouro + ' '+ convert(varchar(10), tbCliente.numero)+ ' ' + SUBSTRING(tbCliente.telefone, 1, 6) + '-' +SUBSTRING(tbCliente.telefone, 7, 9)
					end
				end
			end as endereco_telefone
	from tbCliente
left outer join tbEmprestimo
on tbCliente.cod = tbEmprestimo.codCliente
where tbEmprestimo.codCliente is null


-- Fazer uma consulta que retorne Quantos livros n�o foram emprestados

select count(cod) as 'Livros n�o emprestados' from tbLivro
left outer join tbEmprestimo
on tbEmprestimo.codLivro = tbLivro.cod
where tbEmprestimo.codLivro is null

-- Fazer uma consulta que retorne Nome do Autor, Tipo do corredor e quantos livros, ordenados por quantidade de livro

select tbAutor.nome, tbCorredor.tipo, count (codCorredor) as qtdeLivro from tbLivro
inner join tbAutor
on tbLivro.codAutor = tbAutor.cod
inner join tbCorredor
on tbCorredor.cod = tbLivro.codCorredor
group by tbAutor.nome, tbCorredor.tipo
order by qtdeLivro desc

-- Considere que hoje � dia 18/05/2012, fa�a uma consulta que apresente o nome do cliente, 
--o nome do livro, 
--o total de dias que cada um est� com o livro e, uma coluna que apresente, 
--caso o n�mero de dias seja superior a 4, 
--apresente 'Atrasado', caso contr�rio, apresente 'No Prazo'

select tbCliente.nome, tbLivro.nome, DATEDIFF(dd, dtEmprestimo, '2012-05-18') as dias_empestados,
	case when (DATEDIFF(dd, dtEmprestimo, '2012-05-18') > 4)
		then	
			'Atrasado'
		else
			'No Prazo'
	end as statusEmprestimo	
from tbEmprestimo
inner join tbCliente on tbCliente.cod = tbEmprestimo.codCliente
inner join tbLivro on tbLivro.cod = tbEmprestimo.codLivro

-- Fazer uma consulta que retorne cod de corredores, tipo de corredores e quantos livros tem em cada corredor

select tbCorredor.cod, tipo, count (tbLivro.codCorredor) as 'Qtde de livros' from tbCorredor
inner join tbLivro on tbLivro.codCorredor = tbCorredor.cod
group by  tbCorredor.cod, tipo


-- Fazer uma consulta que retorne o Nome dos autores cuja quantidade de livros cadastrado � maior ou igual a 2.

select tbAutor.nome from tbAutor
inner join tbLivro on tbLivro.codAutor = tbAutor.cod
group by tbAutor.nome
having count(tbLivro.codAutor) >= 2

-- Considere que hoje � dia 18/05/2012, fa�a uma consulta que apresente o nome do cliente, 
--o nome do livro dos empr�stimos que tem 7 dias ou mais

select tbCliente.nome, tbLivro.nome, DATEDIFF(dd, dtEmprestimo, '2012-05-18') as dias_empestados from tbEmprestimo
inner join tbCliente on tbCliente.cod = tbEmprestimo.codCliente
inner join tbLivro on tbLivro.cod = tbEmprestimo.codLivro	
group by tbCliente.nome, tbLivro.nome, tbEmprestimo.dtEmprestimo
having DATEDIFF(dd, dtEmprestimo, '2012-05-18') >= 7






