
/*Criar as tabelas*/

/*Campos: nome tipo (se é nulo ou não) */
create table Curso (
	Codigo_Curso int not null,
	Nome varchar(70) not null,
	Sigla varchar(10) not null,

	primary key(Codigo_Curso)
)

create table Aluno (
	Ra char(7) not null,
	Nome varchar(250) not null,
	Codigo_Curso int not null,

	primary key(Ra),

	/*Chave estrangeira */
	foreign key(Codigo_Curso) references Curso(Codigo_Curso)
)


create table Palestrante(
	Codigo_Palestrante int identity,
	Nome varchar(250) not null,
	Empresa varchar(100) not null,

	primary key(Codigo_Palestrante)
)

create table Palestra(
	Codigo_Palestra int identity,
	Titulo varchar(max) not null,
	Carga_Horaria int null,
	Data_Palestra datetime not null,
	Codigo_Palestrante int not null,

	primary key(Codigo_Palestra),
	foreign key(Codigo_Palestrante) references Palestrante(Codigo_Palestrante)
)

create table Alunos_Inscritos(
	Ra char(7) not null,
	Codigo_Palestra int not null,

	primary key(Ra, Codigo_Palestra),

	foreign key (Ra) references Aluno(Ra),
	foreign key(Codigo_Palestra) references Palestra(Codigo_Palestra)
)

create table Nao_Alunos(
	RG varchar(9) not null,
	Orgao_Exp char(5) not null,
	Nome varchar(250) not null,

	primary key (RG, Orgao_Exp)
)

create table Nao_Alunos_Inscritos(
	Codigo_Palestra int not null,
	RG varchar(9) not null,
	Orgao_Exp char(5) not null,

	primary key(Codigo_Palestra, RG, Orgao_Exp),
	foreign key (Codigo_Palestra) references Palestra(Codigo_Palestra),
	foreign key (RG, Orgao_Exp) references Nao_Alunos(RG, Orgao_Exp)
)