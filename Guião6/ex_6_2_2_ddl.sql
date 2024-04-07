CREATE TABLE fornecedor (
    nif INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    fax VARCHAR(20),
    endereco VARCHAR(200),
    tipo VARCHAR(50),
    condpag VARCHAR(50)
);

CREATE TABLE encomenda (
    numero INT PRIMARY KEY,
    nif INT,
    FOREIGN KEY (nif) REFERENCES fornecedor(nif)
);

CREATE TABLE produto (
    codigo INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE item (
    numEnc INT NOT NULL,
    codProd INT NOT NULL,
    unidades INT,
    FOREIGN KEY (numEnc) REFERENCES encomenda(numero),
    FOREIGN KEY (codProd) REFERENCES produto(codigo),
    PRIMARY KEY (numEnc, codProd) -- Chave primária composta
);

CREATE TABLE tipo_fornecedor (
    tipo VARCHAR(50) PRIMARY KEY
);
