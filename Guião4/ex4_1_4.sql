--DROP DATABASE IF EXISTS Medicamentos;

--CREATE DATABASE Medicamentos;
--GO 

DROP TABLE IF EXISTS PERSCRICAO, FARMACO, VENDA_FARMACOS, PRODUCAO_FARMACOS, COMPANHIA_FARMACEUTICA, FARMACIA, PACIENTE, MEDICO;

CREATE TABLE MEDICO ( 
    Num_SNS char(5) NOT NULL PRIMARY KEY, 
    Nome varchar(30) NOT NULL, 
    Especialidade varchar(30)
);

CREATE TABLE PACIENTE(
    Num_utente char(10) NOT NULL PRIMARY KEY, 
    Nome varchar(30) NOT NULL,
    Data_nascimento date NOT NULL,
    Endereco varchar(100) NOT NULL,
    Num_SNS_medico char(5) NOT NULL,
    FOREIGN KEY (Num_SNS_medico) REFERENCES MEDICO(Num_SNS)
);

CREATE TABLE PERSCRICAO(
    Numero char(6) NOT NULL PRIMARY KEY, 
    Data_ date NOT NULL,
    Num_utente char(10) NOT NULL,
    Num_id char(5) NOT NULL,
    FOREIGN KEY (Num_utente) REFERENCES PACIENTE(Num_utente),
    FOREIGN KEY (Num_id) REFERENCES MEDICO(Num_SNS)
);

CREATE TABLE FARMACO(
    Formula varchar(500) NOT NULL PRIMARY KEY, 
    Nome_comercial varchar(30) NOT NULL,
    Num_perscricao char(6) NOT NULL,
    FOREIGN KEY (Num_perscricao) REFERENCES PERSCRICAO(Numero)
);

CREATE TABLE FARMACIA(
    Nif char(9) NOT NULL PRIMARY KEY,
    Nome varchar(30) NOT NULL,
    Endereco varchar(100) NOT NULL,
    Telefone varchar(15) NOT NULL,
    CHECK (Telefone BETWEEN '900000000' AND '999999999')
);

CREATE TABLE COMPANHIA_FARMACEUTICA(
    Num_regis_naci char(6) NOT NULL PRIMARY KEY, 
    Nome varchar(30) NOT NULL,
    Endereco varchar(100) NOT NULL,
    Telefone varchar(15) NOT NULL
);

CREATE TABLE VENDA_FARMACOS(
    Nif_farmacia char(9) NOT NULL REFERENCES FARMACIA(Nif),
    Formula_farmaco varchar(500) NOT NULL REFERENCES FARMACO(Formula),
    PRIMARY KEY (Nif_farmacia, Formula_farmaco)
);

CREATE TABLE PRODUCAO_FARMACOS(
    Formula_farmaco varchar(500) NOT NULL REFERENCES FARMACO(Formula),
    Num_regis_farmaceutica char(6) NOT NULL REFERENCES COMPANHIA_FARMACEUTICA(Num_regis_naci),
    PRIMARY KEY (Formula_farmaco, Num_regis_farmaceutica)
);
