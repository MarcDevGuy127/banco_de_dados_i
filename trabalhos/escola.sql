CREATE DATABASE escola;
USE escola;

CREATE TABLE Aluno (
	matricula INT NOT NULL PRIMARY KEY,
	nome varchar(255) NOT NULL,
	sexo varchar(1) NOT NULL,
	cpf varchar(11) NOT NULL,
	rg varchar(9) NOT NULL,
	data_nascimento DATE NOT NULL,
	cidade varchar(50) NOT NULL,
	bairro varchar(30) NOT NULL,
	cep char(9) NOT NULL,
	endereco varchar(100) NOT NULL
);

INSERT INTO Aluno(matricula, nome, sexo, cpf, rg, data_nascimento, cidade, bairro, cep, endereco) 
VALUES(2033, 'Marcelo Henrique Costa da Silva', 'M', 11111111111, 111111111, '2006-04-16', 'Pinhais', 'Weissópolis', 111111111, 'Rua Jorge Almeida, apto 50'),
(2126, 'Maria Matarazo de Oliveira', 'F', 22222222222, 222222222, '1980-07-01', 'Curitiba', 'Jardim das Américas', 222222222, 'Rua Rio Piracicaba, 103'),
(2123, 'Edinéia dos Santos', 'F', 33333333333, 333333333, '1979-02-17', 'Curitiba', 'Hauer', 333333333, 'Rua Rio das Capivaras, 1'),
(1093, 'Marcos Pontes de Almeida Prado', 'M', 44444444444, 444444444, '1999-02-27', 'São José dos Pinhais', 'Afonso Pena', 444444444, 'Rua Pacuiba, 781'),
(2003, 'Edinéia dos Santos', 'F', 55555555555, 555555555, '1999-03-21', 'Colombo', 'Guaraituba', 555555555, 'Rua Rio Tocantins, A12');

SELECT * FROM Aluno;

CREATE TABLE Professor (
	matricula INT NOT NULL PRIMARY KEY,
	nome varchar(255) NOT NULL,
	sexo varchar(1) NOT NULL,
	cpf varchar(11) NOT NULL,
	rg varchar(9) NOT NULL,
	data_nascimento DATE NOT NULL,
	especialidade varchar(25) NOT NULL,
	data_formacao DATE NOT NULL,
	faculdade_formacao varchar(35) NOT NULL,
	cidade varchar(50) NOT NULL,
	bairro varchar(30) NOT NULL,
	cep char(9) NOT NULL,
	endereco varchar(100) NOT NULL
);

INSERT INTO Professor(matricula, nome, sexo, cpf, rg, data_nascimento, especialidade, data_formacao, faculdade_formacao, cidade, bairro, cep, endereco) 
VALUES(1516, 'Jorge Almeida Barros', 'M', 11122211222, 112111122, '1989-02-16', 'Ensino Médio', '2008-06-28', 'PUC-PR', 'Pinhais', 'Weissópolis', 111222211, 'Rua Machado de Almeida, 450'),
(3771, 'Marisa Silva', 'F', 13133211323, 426662722, '1980-12-01', 'Ens. Médio', '2000-01-10', 'Anhanguera-PR', 'Curitiba', 'Jardim das Américas', 222777112, 'Rua Rio das Pratas, 81'),
(5988, 'Edilson dos Santos Prado', 'M', 33335573333, 138797733, '1979-02-17', 'Fundamental I', '2007-06-28', 'UF-PR', 'Curitiba', 'Hauer', 312322211, 'Rua Rio do Capim, 1'),
(4123, 'Márcia de Melo', 'F', 44001412344, 877883211, '1995-05-18',  'Fundamental I', '2015-10-21', 'UNIBRASIL', 'São José dos Pinhais', 'Bairro Alto', 421488741, 'Rua das Palmeiras, 787'),
(4303, 'Murilo Santana', 'M', 55495959445, 443221945, '1999-05-29', 'Fundamental II', '2021-10-17', 'UNIBRASIL', 'Curitiba', 'Centro', 557875325, 'Rua Pastos Longíquos, 37');

SELECT * FROM Professor;

CREATE TABLE Disciplina (
	cod_disciplina INT NOT NULL PRIMARY KEY,
	nome_disciplina varchar(20) NOT NULL,
	carga_horaria INT NOT NULL
);

INSERT INTO Disciplina(cod_disciplina, nome_disciplina, carga_horaria)
VALUES(2115, 'Biologia', 35), (2125, 'Ciências', 25), (2111, 'Matemática', 15), (2341, 'Matemática', 15), (2166, 'Ciências Aplicadas', 15); 

SELECT * FROM Disciplina;

CREATE TABLE Turma (
	cod_turma INT NOT NULL PRIMARY KEY,
	cod_disciplina INT NOT NULL,
	carga_horaria INT NOT NULL
);

INSERT INTO Turma(cod_turma, cod_disciplina, carga_horaria)
VALUES(1021, 2115, 35), (2022, 2125, 25), (2342, 2111, 15), (2144, 2341, 15), (2841, 2166, 15); 

SELECT * FROM Turma;

CREATE TABLE Frequenta (
	matricula INT FOREIGN KEY REFERENCES Aluno(matricula),
	cod_turma INT FOREIGN KEY REFERENCES Turma(cod_turma),
	nota DECIMAL(2,1) NOT NULL,
	falta INT NOT NULL,
	semestre INT NOT NULL,
	ano INT NOT NULL
);

INSERT INTO Frequenta (matricula, cod_turma, nota, falta, semestre, ano)
VALUES(1093, 1021, 9.5, 0, 2, 2025),
(2003, 2022, 6.5, 20, 2, 2024),
(2033, 2144, 3.4, 13, 1, 2025),
(2123, 2342, 6.6, 15, 2, 2025),
(2126, 2841, 7.5, 35, 2, 2025);

SELECT * FROM Frequenta;

--DROP TABLE Ensina;

CREATE TABLE Ensina (
	matricula INT FOREIGN KEY REFERENCES Professor(matricula),
	cod_turma INT FOREIGN KEY REFERENCES Turma(cod_turma)
);

INSERT INTO Ensina (matricula, cod_turma) VALUES 
(1516, 1021),
(3771, 2022),
(4123, 2144),
(4303, 2342),
(5988, 2841);

SELECT * FROM Ensina;