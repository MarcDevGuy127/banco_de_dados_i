CREATE DATABASE Editora;
USE Editora;

CREATE TABLE Editora (
	Codigo INT PRIMARY KEY,
	Nome VARCHAR(100) NOT NULL
);

CREATE TABLE Livro (
	Codigo INT PRIMARY KEY,
	Titulo VARCHAR(100) NOT NULL
);

CREATE TABLE Publica (
	Cod_Editora INT FOREIGN KEY REFERENCES Editora(Codigo),
	Cod_Livro INT FOREIGN KEY REFERENCES Livro(Codigo),
	Preco INT NOT NULL,
	Dt_lancamento DATE
);

INSERT INTO Editora
VALUES(1, 'Brasil Cultura'),
(2, 'Phenix Inc.'),
(3, 'JiaJo Dinks');

SELECT * FROM Editora;

INSERT INTO Livro
VALUES(1, 'A Volta Dos Que Não Foram'),
(2, 'A Vingança Dos Derrotados'),
(3, 'O Possível Impossível');

SELECT * FROM Livro;

INSERT INTO Publica
VALUES(1, 1, 50, '2025-04-16'),
(2, 2, 40, '2019-09-11'),
(3, 3, 45, '2017-05-27');

SELECT * FROM Publica;
