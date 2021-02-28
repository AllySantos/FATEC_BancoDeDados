-- exercício CPF


declare @cpf as varchar(11),
		@digito1 as int,
		@digito2 as int,
		@i as int,
		@caractere as int,
		@restoDiv as int,
		@cpfDigitado as char(11)

set @cpfDigitado = '50256135070'

-- VE SE TODOS OS ALGARISMOS SÃO IGUAIS
if(@cpfDigitado like '111111111' or @cpfDigitado like '222222222' or @cpfDigitado like '333333333' or
	@cpfDigitado like '444444444' or @cpfDigitado like '555555555' or @cpfDigitado like '666666666' or
	@cpfDigitado like '777777777' or @cpfDigitado like '888888888' or @cpfDigitado like '999999999')
begin
	print 'Inválido - Os algarismos não podem ser iguais'
end
else
begin
	set @cpf =SUBSTRING(@cpfDigitado, 1, 9)
	set @i = 10
	set @caractere = 1
	set @digito1 = 0

	-- DIGITO VERIFICADOR 01
	while (@i >= 1)
	begin
		set @digito1 = @digito1 + ((cast(substring(@cpf, @caractere, 1) as int)) * @i)

		set @caractere = @caractere + 1
		set @i = @i - 1
	end

	set @restoDiv = @digito1 % 11

	if(@restoDiv < 2)
	begin
		set @digito1 = 0
	end
	else
	begin
		set	@digito1 = 11 - @restoDiv
	end

	set @cpf = concat(@cpf, cast(@digito1 as char(1)))

	-- DIGITO VERIFICADOR 02

	set @i = 11
	set @caractere = 1
	set @digito2 = 0

	while (@i >= 2)
	begin
		set @digito2 = @digito2 + ((cast(substring(@cpf, @caractere, 1) as int)) * @i)

		set @caractere = @caractere + 1
		set @i = @i - 1
	end

	set @restoDiv = @digito2 % 11

	if(@restoDiv < 2)
	begin
		set @digito2 = 0
	end
	else
	begin
		set	@digito2 = 11 - @restoDiv
	end

	set @cpf = concat(@cpf, cast(@digito2 as char(1)))

	-- Se o cpf for igual ao calculado com os dígitos é válido
	if(@cpf = @cpfDigitado)
	begin
		print 'Válido'
	end
	else
	begin
		print 'Inválido'
	end
end