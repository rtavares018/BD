DROP DATABASE IF EXISTS Encomendas;

CREATE DATABASE Encomendas;
GO

DROP TABLE IF EXISTS ENCOMENDA_CONTEM_PRODUTOS, ENCOMENDA,FORNECEDOR,TIPO_FORNECEDOR,PRODUTO;
GO


CREATE TABLE PRODUTO(
	codigo int not null ,
	nome varchar(30) not null,
	preco decimal(10,2) not null,
	taxa decimal(5, 2) not null, -- Como percentagem
	num_em_armazem int not null,
	primary key(codigo),
);
CREATE TABLE TIPO_FORNECEDOR(
	designacao varchar(20) not null,
	primary key(designacao)
);
CREATE TABLE FORNECEDOR (
	NIF char(9) not null,
	endereco varchar(50)not null,
	nome varchar(30) not null,
	cond_pagamento varchar(30) not null,
	fax varchar(25) not null,
	tipo_fornecedor varchar(20) not null,
	foreign key(tipo_fornecedor) references TIPO_FORNECEDOR(designacao),

	primary key(NIF),

);

CREATE TABLE ENCOMENDA(
	num int not null,
	data_ date not null,
	NIF_fornecedor char(9) not null,
	foreign key (NIF_fornecedor) references FORNECEDOR (NIF),
	primary key(num),
);


CREATE TABLE ENCOMENDA_CONTEM_PRODUTOS(
	codigo int not null,
	num_encomenda int not null,
	num_unidades int not null,
	primary key(codigo, num_encomenda),
	foreign key (codigo) references PRODUTO (codigo),
	foreign key (num_encomenda) references ENCOMENDA(num),


);





