USE Imobiliaria;

CREATE TABLE Pessoa (
	ID_Pessoa INT NOT NULL PRIMARY KEY,
	Nome VARCHAR(35) NOT NULL,
	RG VARCHAR(10) NOT NULL
);

CREATE TABLE Imovel (
	Identificacao_Fiscal INT FOREIGN KEY REFERENCES Pessoa(ID_Pessoa),
	Endereco VARCHAR(255)
);

INSERT INTO Pessoa
VALUES(1, 'Marcos Paulo da Silva','1111111111'), 
(2, 'Mariano Almeida','2222222222'), 
(3, 'Cleíton Schmitz','3333333333');

INSERT INTO Imovel
VALUES(1, 'Rua Floriano Peixoto, 135 - apto. 90 - Bairro Alto - Curitiba/PR'), 
(2, 'Rua Almeida dos Anjos, 7 - Jardim das Américas - Curitiba/PR'), 
(3, NULL);

SELECT * FROM Pessoa;
SELECT * FROM Imovel;
