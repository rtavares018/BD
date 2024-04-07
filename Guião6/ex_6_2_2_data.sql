INSERT INTO tipo_fornecedor (codigo, designacao) VALUES
(1, 'Eletrónica'),
(2, 'Moda'),
(3, 'Alimentação'),
(4, 'Desporto'),
(5, 'Jardinagem'),
(6, 'Brinquedos');

INSERT INTO fornecedor (nif, nome, fax, endereco, condpag, tipo) VALUES
(123456789, 'Fornecedora XPTO', '123456789', 'Avenida Principal, Lisboa', 30, 1),
(987654321, 'Loja Moda & Cia', '987654321', 'Rua da Moda, Porto', 45, 2),
(654987321, 'Mercado Fresco', '654987321', 'Praça do Mercado, Braga', 60, 3),
(111222333, 'SportsWorld', '111222333', 'Rua dos Desportistas, Faro', 30, 4),
(444555666, 'Jardim Feliz', '444555666', 'Avenida das Flores, Coimbra', 45, 5),
(777888999, 'BrincaMundo', '777888999', 'Rua dos Brinquedos, Aveiro', 60, 6);


INSERT INTO produto (codigo, nome, preco, iva, unidades) VALUES
(1, 'Telemóvel', 500, 0.23, 100),
(2, 'Camisola', 20, 0.15, 200),
(3, 'Arroz', 2, 0.05, 500),
(4, 'Bola de Futebol', 15, 0.23, 50),
(5, 'Vaso de Flores', 10, 0.15, 100),
(6, 'Boneca', 30, 0.05, 80);


INSERT INTO encomenda (numero, data, fornecedor) VALUES
(1, '2024-04-07', 123456789),
(2, '2024-04-07', 987654321),
(3, '2024-04-07', 654987321),
(4, '2024-04-08', 111222333),
(5, '2024-04-08', 444555666),
(6, '2024-04-08', 777888999);

INSERT INTO item (numEnc, codProd, unidades) VALUES
(1, 1, 10),
(1, 2, 20),
(2, 3, 30),
(2, 4, 5),
(3, 5, 15),
(3, 6, 10);
