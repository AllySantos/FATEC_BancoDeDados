
create procedure sp_transacao_produto(@operacao char(1), @cod_produto int, 
				@cod_transacao int, @qtde int, @saida varchar(max) output) 
as

	declare @tabela as varchar(20),
			@query varchar(max),
			@erro varchar(max),
			@valor smallmoney


	if(@operacao != 'e'and @operacao != 's')
	begin
		set @erro = 'Operacao invalida'
		raiserror(@erro, 16, 1)
	end
	else
	begin
		if(@operacao = 's')
		begin
			set @tabela = 'tb_saida'
		end
		else
		begin
			set @tabela = 'tb_entrada'
		end

		set @valor = (select valor_produto from tb_produto where cod_produto = @cod_produto)


		SET @query = 'INSERT INTO '+@tabela+' VALUES ('+
				CAST(@cod_transacao AS VARCHAR(5))+','+ 
				CAST(@cod_produto AS VARCHAR(5)) + ', ' + 
				CAST(@qtde as varchar(5)) + ', ' +
				CAST((@valor * @qtde) as varchar(10)) + ')'


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
EXEC sp_transacao_produto 's', 1, 2, 3, @out output
PRINT @out

select * from tb_saida