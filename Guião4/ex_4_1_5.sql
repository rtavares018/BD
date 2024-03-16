DROP DATABASE IF EXISTS Conferencia;

CREATE DATABASE Conferencia;
GO

DROP TABLE IF EXISTS NAO_ESTUDANTE, ESTUDANTE, PARTICIPANTE , ARTIGO_AUTOR, AUTOR,INSTITUICAO, ARTIGO;
GO


CREATE TABLE ARTIGO(
	Num_registo int not null,
	Titulo varchar(30) not null,
	primary key(Num_registo)
);
 
CREATE TABLE INSTITUICAO(
	nome varchar(30) not null,
	endereco varchar(50) not null,

	primary key(nome),
);


CREATE TABLE AUTOR (
	nome varchar(30) not null,
	email varchar(20) not null,
	nome_instituiçao varchar(30) not null,
	
	primary key(nome),
	foreign key(nome_instituiçao) references INSTITUICAO(nome),

);

CREATE TABLE ARTIGO_AUTOR(
	Num_registo_artigo int not null, 
	nome_autor varchar(30) not null,


	primary key (Num_registo_artigo, nome_autor),
	foreign key(Num_registo_artigo) references ARTIGO(Num_registo),
	foreign key(nome_autor) references AUTOR(nome),
);

CREATE TABLE PARTICIPANTE(
	nome varchar(30) not null,
	data_inscricao date not null,
	email varchar(20) not null,
	morada varchar(50)not null,
	nome_instituicao varchar(30) not null,

	primary key(nome),
	foreign key (nome_instituicao) references INSTITUICAO(nome),

	
);

CREATE TABLE ESTUDANTE(
	nome varchar(30) not null,
	comprovativo_instituicao varchar(100) not null,
	primary key(nome),
	foreign key (nome) references PARTICIPANTE(nome),

);

CREATE TABLE NAO_ESTUDANTE(
	nome varchar(30) not null,
	referencia varchar(20) not null,
	primary key(nome),
	foreign key (nome) references PARTICIPANTE(nome),

);