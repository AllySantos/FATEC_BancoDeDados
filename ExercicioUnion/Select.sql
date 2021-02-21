/*
O problema est� no momento de gerar a lista de presen�a. A lista de presen�a dever� vir de uma
consulta que retorna (Num_Documento, Nome_Pessoa, Titulo_Palestra, Nome_Palestrante,
Carga_Hor�ria e Data). A lista dever� ser uma s�, por palestra (
) e contemplar alunos e n�o alunos (O Num_Documento se referencia ao RA para
alunos e RG + Orgao_Exp para n�o alunos) e estar ordenada pelo Nome_Pessoa. 
*/

/*
ALUNO -- ALUNOS INSCRITOS -- PALESTRA -- PALESTRANTE
*/

--SELECT ALUNOS INSCRITOS EM PALESTRAS
select Aluno.Ra as 'Num_Documento', Aluno.Nome as 'Nome_Pessoa', Titulo as 'Titulo_Palestra', 
Palestrante.Nome as 'Nome_Palestrante', Carga_Horaria as 'Carga_Hor�ria', Data_Palestra as 'Data' 
from Aluno 
inner join Alunos_Inscritos on Aluno.Ra = Alunos_Inscritos.Ra
inner join Palestra on Alunos_Inscritos.Codigo_Palestra = Palestra.Codigo_Palestra
inner join Palestrante on Palestra.Codigo_Palestrante = Palestrante.Codigo_Palestrante


--SELECT ALUNOS N�O INSCRITOS MAS EM PALESTRAS
select Nao_Alunos.RG + Nao_Alunos.Orgao_Exp as 'Num_Documento', Nao_Alunos.Nome as 'Nome_Pessoa', Titulo as 'Titulo_Palestra', 
Palestrante.Nome as 'Nome_Palestrante', Carga_Horaria as 'Carga_Hor�ria', Data_Palestra as 'Data' 
from Nao_Alunos 
inner join Nao_Alunos_Inscritos on Nao_Alunos_Inscritos.RG + Nao_Alunos_Inscritos.Orgao_Exp = Nao_Alunos.RG + Nao_Alunos.Orgao_Exp
inner join Palestra on Nao_Alunos_Inscritos.Codigo_Palestra = Palestra.Codigo_Palestra
inner join Palestrante on Palestra.Codigo_Palestrante = Palestrante.Codigo_Palestrante


/* CRIANDO O UNION E VIEW COM OS DOIS SELECTS ACIMA */



CREATE VIEW v_lista
AS

select Aluno.Ra as 'Num_Documento', Aluno.Nome as 'Nome_Pessoa', Titulo as 'Titulo_Palestra', 
Palestrante.Nome as 'Nome_Palestrante', Carga_Horaria as 'Carga_Hor�ria', Data_Palestra as 'Data' 
from Aluno 
inner join Alunos_Inscritos on Aluno.Ra = Alunos_Inscritos.Ra
inner join Palestra on Alunos_Inscritos.Codigo_Palestra = Palestra.Codigo_Palestra
inner join Palestrante on Palestra.Codigo_Palestrante = Palestrante.Codigo_Palestrante 
where Palestra.Codigo_Palestra = 1

UNION

select Nao_Alunos.RG + Nao_Alunos.Orgao_Exp as 'Num_Documento', Nao_Alunos.Nome as 'Nome_Pessoa', Titulo as 'Titulo_Palestra', 
Palestrante.Nome as 'Nome_Palestrante', Carga_Horaria as 'Carga_Hor�ria', Data_Palestra as 'Data' 
from Nao_Alunos 
inner join Nao_Alunos_Inscritos on Nao_Alunos_Inscritos.RG + Nao_Alunos_Inscritos.Orgao_Exp = Nao_Alunos.RG + Nao_Alunos.Orgao_Exp
inner join Palestra on Nao_Alunos_Inscritos.Codigo_Palestra = Palestra.Codigo_Palestra
inner join Palestrante on Palestra.Codigo_Palestrante = Palestrante.Codigo_Palestrante
where Palestra.Codigo_Palestra = 1


--DELETAR VIEW
DROP VIEW v_lista

/*SELECT POR CODIGO DA PALESTRA*/

SELECT * FROM v_lista ORDER BY v_lista.Nome_Pessoa