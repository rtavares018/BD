INSERT INTO employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) 
VALUES 
('António', 'J', 'Santos', 444333222, '1984-03-25', 'Rua das Flores, Coimbra, Portugal', 'M', 56000.00, NULL, 3),
('Beatriz', 'K', 'Ferreira', 555666777, '1996-08-12', 'Avenida Central, Porto, Portugal', 'F', 59000.00, 111000111, 3),
('Carlos', 'L', 'Rocha', 666777888, '1989-11-18', 'Rua Principal, Braga, Portugal', 'M', 57000.00, 987654321, 1),
('Daniela', 'M', 'Pereira', 777888999, '1994-05-30', 'Avenida dos Aliados, Lisboa, Portugal', 'F', 62000.00, 555444333, 4),
('Eduardo', 'N', 'Marques', 888999000, '1983-09-09', 'Rua Direita, Faro, Portugal', 'M', 60000.00, 987654321, 2);

INSERT INTO department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) 
VALUES 
('Marketing', 5, 444333222, '2019-04-15'),
('Produção', 6, 555666777, '2018-10-20'),
('Vendas', 7, 666777888, '2020-01-10'),
('Financeiro', 8, 777888999, '2017-12-05'),
('Recursos Humanos', 9, 888999000, '2016-06-20');

INSERT INTO dept_location (Dnumber, Dlocation) 
VALUES 
(5, 'Edifício E'),
(6, 'Edifício F'),
(7, 'Edifício G'),
(8, 'Edifício H'),
(9, 'Edifício I');

INSERT INTO project (Pname, Pnumber, Plocation, Dnum) 
VALUES 
('Campanha Publicitária', 5, 'Lisboa', 5),
('Desenvolvimento de Produto', 6, 'Porto', 6),
('Expansão Internacional', 7, 'Madrid', 7),
('Auditoria de Contas', 8, 'Paris', 8),
('Treinamento de Equipe', 9, 'Berlim', 9);

INSERT INTO works_on (Essn, Pno, Hours) 
VALUES 
(444333222, 5, 35.0),
(555666777, 6, 40.0),
(666777888, 5, 30.0),
(777888999, 6, 45.0),
(888999000, 5, 38.0);

INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) 
VALUES 
(444333222, 'Diana Santos', 'F', '2012-09-20', 'Filha'),
(555666777, 'Gustavo Ferreira', 'M', '2017-06-28', 'Filho'),
(666777888, 'Henrique Rocha', 'M', '2014-03-15', 'Filho'),
(777888999, 'Isabel Pereira', 'F', '2019-10-10', 'Filha'),
(888999000, 'Joaquim Marques', 'M', '2015-12-05', 'Filho');
