INSERT INTO medico (numSNS, nome, especialidade) VALUES
(123456789, 'Dr. João Silva', 'Cardiologia'),
(987654321, 'Dra. Ana Santos', 'Pediatria'),
(654321987, 'Dr. Pedro Almeida', 'Ortopedia');

INSERT INTO paciente (numUtente, nome, dataNasc, endereco) VALUES
(1, 'Maria Oliveira', '1990-05-15', 'Rua A, Lisboa'),
(2, 'José Santos', '1985-10-20', 'Avenida B, Porto'),
(3, 'Ana Pereira', '2000-02-28', 'Rua C, Braga');

INSERT INTO farmacia (nome, telefone, endereco) VALUES
('Farmácia A', 123456789, 'Rua X, Lisboa'),
('Farmácia B', 987654321, 'Avenida Y, Porto'),
('Farmácia C', 654321987, 'Rua Z, Braga');

INSERT INTO farmaceutica (numReg, nome, endereco) VALUES
(1, 'Laboratório X', 'Avenida Principal, Lisboa'),
(2, 'Laboratório Y', 'Rua das Flores, Porto'),
(3, 'Laboratório Z', 'Praça Central, Braga');

INSERT INTO farmaco (numRegFarm, nome, formula) VALUES
(101, 'Paracetamol', 'C8H9NO2'),
(102, 'Amoxicilina', 'C16H19N3O5S'),
(103, 'Omeprazol', 'C17H19N3O3S');

INSERT INTO prescricao (numPresc, numUtente, numMedico, farmacia, dataProc) VALUES
(1, 1, 123456789, 'Farmácia A', '2024-04-07'),
(2, 2, 987654321, 'Farmácia B', '2024-04-07'),
(3, 3, 654321987, 'Farmácia C', '2024-04-07');

INSERT INTO presc_farmaco (numPresc, numRegFarm, nomeFarmaco) VALUES
(1, 101, 'Paracetamol'),
(2, 102, 'Amoxicilina'),
(3, 103, 'Omeprazol');
