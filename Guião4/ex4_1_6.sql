--DROP DATABASE IF EXISTS ATL;

--CREATE DATABASE ATL;
--GO 

DROP TABLE IF EXISTS AUTORIZADO, RECEBE, ALUNO, ENCARREGADO_EDU, TEM, PROFESSOR, PROCESSAMENTO_ATIVIDADE, ATIVIDADE, TURMA, PESSOA;


CREATE TABLE PESSOA(
	Num_CC char(9) not null primary key,
	Nome varchar(30) not null,
	Morada varchar(100) not null,
	Data_nasci date not null,
	Email varchar(50),
	Relaçao_c_aluno varchar(30),
	Telefone varchar(15) NOT NULL,
    CHECK (Telefone BETWEEN '900000000' AND '999999999')
);

CREATE TABLE TURMA(
	Id char(2) not null primary key, --considerando que o id é composto por 2 digitos
	Ano_letivo date not null,
	Designação varchar(50) not null,
	Escolaridade varchar(30) not null,
	Num_max_alunos int not null
)

CREATE TABLE ATIVIDADE(
	Id char(3) not null primary key, --considerando que o id é composto por 3 digitos
	Custo int not null,
	Designação varchar(50) not null
);

CREATE TABLE PROCESSAMENTO_ATIVIDADE(
	Id_atividade char(3) not null REFERENCES ATIVIDADE(Id),
	Id_turma char(2) not null REFERENCES TURMA(Id)

	primary key(Id_atividade, Id_turma)
);

CREATE TABLE PROFESSOR(
	Num_CC char(9) not null REFERENCES PESSOA(Num_CC),
	Num_funcionario int not null

	primary key(Num_CC)
);

CREATE TABLE TEM(
	Num_CC_prof char(9) not null REFERENCES PROFESSOR(Num_CC),
	Id_turma char(2) not null REFERENCES TURMA(Id)

	primary key(Num_CC_prof, Id_turma)
);

CREATE TABLE ENCARREGADO_EDU(
	Num_CC char(9) not null REFERENCES PESSOA(Num_CC)

	primary key(Num_CC)
);

CREATE TABLE ALUNO(
	Num_CC char(9) not null REFERENCES PESSOA(Num_CC),
	Num_CC_EE char(9) not null REFERENCES ENCARREGADO_EDU(Num_CC)

	primary key(Num_CC) --se fizer primary key(Num_CC, Num_CC_EE) senão dá erro
);

CREATE TABLE RECEBE(
	Num_CC_aluno char(9) not null REFERENCES ALUNO(Num_CC),
	Id_atividade char(3) not null REFERENCES ATIVIDADE(Id)

	primary key(Num_CC_aluno, Id_atividade)
);

CREATE TABLE AUTORIZADO(
	Num_CC char(9) not null REFERENCES PESSOA(Num_CC)

	primary key(Num_CC)
);