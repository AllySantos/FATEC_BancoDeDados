CREATE PROCEDURE sp_crudtimes(@cod CHAR(1), @id INT, @nome VARCHAR(50),
				@cidade VARCHAR(80), @saida VARCHAR(max) OUTPUT)
AS
	IF (UPPER(@cod) = 'I' OR UPPER(@cod) = 'D' OR UPPER(@cod) = 'U')
	BEGIN
		IF (UPPER(@cod) = 'I' )
		BEGIN
			INSERT INTO times(nome, cidade)
			VALUES (@nome, @cidade)

			SET @saida = 'Inserido com Sucesso'
		END
		IF (UPPER(@cod) = 'U')
		BEGIN
			UPDATE times
			SET nome = @nome, cidade = @cidade
			WHERE id = @id
			
			SET @saida = 'Atualizado com Sucesso'
		END
		IF (UPPER(@cod) = 'D')
		BEGIN
			DELETE times
			WHERE id = @id
			
			SET @saida = 'Excluido com Sucesso'
		END
	END
	ELSE
	BEGIN
		RAISERROR('Operação Inválida', 16, 1)
	END


DECLARE @out VARCHAR(MAX)
EXEC sp_crudtimes 'I', NULL, 'Bulls', 'Anápolis', @out OUTPUT
PRINT @out

DECLARE @out VARCHAR(MAX)
EXEC sp_crudtimes 'I', NULL, 'Bills', 'LOGOALI', @out OUTPUT
PRINT @out

DECLARE @out VARCHAR(MAX)
EXEC sp_crudtimes 'U', 4002, 'Bills', 'MAISLONGE', @out OUTPUT
PRINT @out

DECLARE @out VARCHAR(MAX)
EXEC sp_crudtimes 'I', NULL, 'Thunders', 'Avaré', @out OUTPUT
PRINT @out

DECLARE @out VARCHAR(MAX)
EXEC sp_crudtimes 'D', 4003, NULL, NULL, @out OUTPUT
PRINT @out

SELECT *FROM times

CREATE FUNCTION fn_jogadoridade(@codigo INT)
RETURNS @tabela TABLE (
codigo			INT,
nomeJogador		VARCHAR(60),
sexo			CHAR(1),
altura			DECIMAL(7,2),
dt_nasc			CHAR(10),
idade			INT,
id				INT,
nome			VARCHAR(50),
cidade			VARCHAR(80)
)
AS
BEGIN
	DECLARE @dt_nasc		DATE,
			@idade			INT
	INSERT INTO @tabela(codigo, nomeJogador, sexo, altura, dt_nasc,
				id, nome, cidade)
	SELECT j.codigo, j.nomeJogador, j.sexo, j.altura,
	CONVERT(CHAR(10), j.dt_nasc, 103) AS dt_nasc,
	t.id, t.nome, t.cidade
	FROM jogador j, times t
	WHERE j.id_time = t.id
		AND j.codigo = @codigo

		SET @dt_nasc = (SELECT @dt_nasc FROM jogador WHERE codigo = @codigo)

		SET @idade = (SELECT DATEDIFF(DD, @dt_nasc, GETDATE()) / 365)
		
		UPDATE @tabela
		SET idade = @idade
		RETURN

END

INSERT INTO jogador (nomeJogador, sexo, altura, dt_nasc, id_time)
VALUES
('Fulano', 'M', 1.80, '02/04/1993', 4002)


SELECT * FROM fn_jogadoridade(900103)


select j.codigo, j.nomeJogador, j.sexo, j.altura, convert(char(10), j.dt_nasc, 103) as dt_nasc, j.id_time, t.id, t.nome, t.cidade
from jogador j, times t
where j.id_time = t.id

select j.codigo, j.nomeJogador, j.sexo, j.altura, convert(char(10), j.dt_nasc, 103) as dt_nasc, j.id_time, t.id, t.nome, t.cidade
from jogador j, times t
where j.id_time = t.id
	and j.codigo = 900103