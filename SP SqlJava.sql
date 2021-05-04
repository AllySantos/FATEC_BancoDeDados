create database bdSqlJava
go

use bdSqlJava
go

create table cliente(
	id int primary key identity(1,1)
	,nome varchar(250) not null
	,telefone char(11) not null
	,dt_registro date not null
	)

create procedure sp_insere_cliente(@nome varchar(250), @telefone char(11), @saida varchar(max) output)
as

	declare @query as varchar(max),
			@dataAtual as date,
			@erro varchar(100)

	set @dataAtual = GETDATE()

	if(@nome is null or @telefone is null)
	begin
		raiserror('Campos não podem ser vazios', 16, 1)
	end
	else
	begin
		set @query = 'insert into cliente (nome, telefone, dt_registro) values (''' + @nome + ''', ''' + @telefone + ''', ''' + cast(@dataAtual as varchar(20)) + ''')'
		print @query
		
		begin try
			exec (@query)
			set @saida = 'OK'
		end try
		begin catch
			set @erro = ERROR_MESSAGE()
			if(@erro like '%primary%')
			begin
				raiserror ('ID duplicado', 16, 1)
			end
			else
			begin
				raiserror ('Erro de processamento', 16, 1)
			end
		end catch
	end

DECLARE @out VARCHAR(MAX)
EXEC sp_insere_cliente 'Ciclano2', '88888888888', @out output
PRINT @out

select * from cliente