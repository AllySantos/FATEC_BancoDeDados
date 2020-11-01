/*create database bdUsuarioProjeto
go
*/
use bdUsuarioProjeto
go

create table users(
 idUser int primary key identity(1,1)
 ,nameUser varchar(45) not null
 ,usernameUser varchar(45) not null unique
 ,passwordUser varchar(45) default ('123mudar')
 ,emailUser varchar(45) not null
 )



 create table project(
	idProject int primary key identity(10001, 1)
	,nameProject varchar(45) not null
	,descriptionProject varchar(45) 
	,dateProject datetime not null

constraint dateProject
	check (dateProject > '2014-09-01')
)

create table usersProject(
	users_id int 
	,project_id int

primary key(users_id, project_id)
foreign key (users_id) references users(idUser)
,foreign key (project_id) references project(idProject)
)

/*Modificar a coluna username da tabela Users para varchar(10) */

alter table users drop constraint [UQ__users__97B199C7E81E6674]
alter table users alter column usernameUser varchar(10) 

CREATE UNIQUE NONCLUSTERED INDEX [UQ__users__97B199C7E81E6674(usernameUser)] 
  ON users([usernameUser] ASC) 

/*Modificar a coluna password da tabela Users para varchar(8) */
alter table users alter column passwordUser varchar(8)


/*INSERTS*/


/*Senha padrão*/
insert into users (nameUser, usernameUser, emailUser)
values ('Maria', 'RH_Maria', 'maria@empresa.com')
	,('Ana', 'RH_ana', 'ana@empresa.com')
	,('Clara', 'Ti_clara', 'clara@empresa.com')
select * from users

/*Senha diferente*/
insert into users (nameUser, usernameUser, passwordUser, emailUser)
values ( 'Paulo', 'Ti_paulo', '123@456' ,'paulo@empresa.com')
	,('Aparecido', 'Ti_apareci','55@!cido', 'aparecido@empresa.com')


insert into project
values ('Re-folha', 'Refatoração das folhas', '2014-09-05')
	,('Manutenção PC´s', 'Manutenção PC´s', '2014-09-06')
	,('Auditoria', null, '2014-09-07')

select * from project

/*Os ids dos usuarios estão "trocados" pois os usuários não foram inseridos em ordem igual ao exemplo*/
insert into usersProject
values (1, 10001)
	,(5, 10001)
	,(2, 10003)
	,(3, 10002)
	,(4, 10002)


/*alterações*/

update project
set dateProject = '2014-09-12'
where idProject = 10002

select * from project


update users
set usernameUser = 'RH_cido'
where nameUser = 'Aparecido'
select * from users

update users
set passwordUser= '888@*'
where nameUser = 'Maria' and passwordUser = '123mudar'
select * from users


delete usersProject
where users_id = 4

select * from usersProject

/*- Adicionar uma coluna budget DECIMAL(7,2) NULL na tabela Project*/
alter table project add budget decimal(7,2) null
select * from project

update project
set budget  = 5750.00
where idProject = 10001

update project
set budget  = 7850.00
where idProject = 10002

update project
set budget  = 9530.00
where idProject = 10003

select * from project


/*Consultas*/

select usernameUser as 'username', passwordUser as 'password' from users
where nameUser = 'Ana'

select nameProject as 'name', budget as 'budget', cast(budget * 1.25 as decimal(7,2)) as 'valor hipotético'  from project

select idUser as 'id', usernameUser as 'username', emailUser as 'email' from users
where passwordUser = '123mudar'

select idProject as 'id', nameProject as 'name', budget as 'budget' from project
where budget between 2000.00 and 8000.00