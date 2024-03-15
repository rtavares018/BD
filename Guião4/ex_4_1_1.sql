DROP DATABASE IF EXISTS Rent_car;

CREATE DATABASE Rent_car;
GO

DROP TABLE IF EXISTS ALUGUER, VEICULO, LIGEIRO, PESADO, SIMILARIDADE, CLIENTE, BALCAO, TIPO_VEICULO;
GO

CREATE TABLE CLIENTE(
	NIF char(9) not null primary key,
	nome varchar(30) not null,
	endereco varchar(30) not null,
	num_carta int unique not null,
	);


CREATE TABLE BALCAO(
	numero int not null primary key,
	nome varchar(30) not null,
	endereco varchar(30) not null,
	);
CREATE TABLE TIPO_VEICULO(
	codigo int not null primary key,
	designaçao varchar(30) not null,
	arcondicionado bit not null, 
);
CREATE TABLE VEICULO(
	matricula char(6) not null primary key,
	ano date not null,
	marca varchar(30) ,
	tipo_codigo int not null references TIPO_VEICULO(codigo),
);
CREATE TABLE ALUGUER(
	numero int not null primary key,
	duracao int not null, --duraçao em dias
	data_ date not null,
	n_balcao int not null references BALCAO(numero),
	matricula_veiculo char(6) not null references VEICULO(matricula),
	NIF_cliente char(9) not null references CLIENTE(NIF),
	)
	;


CREATE TABLE SIMILARIDADE(
	tipo_codigoA int not null references TIPO_VEICULO(codigo),
	tipo_codigoB int not null references TIPO_VEICULO(codigo),

	primary key(tipo_codigoA,tipo_codigoB)


);

CREATE TABLE LIGEIRO(
	portas int not null,
	combustivel varchar(15) not null,
	numlugares int not null,
	tipo_codigo int not null references TIPO_VEICULO(codigo),
);

CREATE TABLE PESADO(
	peso int not null,
	pasageiros int not null,
	combustivel varchar(15) not null,
	tipo_codigo int not null references TIPO_VEICULO(codigo),
);
