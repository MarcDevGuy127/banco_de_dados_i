CREATE DATABASE BD_RH;
USE BD_RH;

CREATE TABLE Departamento (
	id_departamento INT NOT NULL PRIMARY KEY,
	ramo varchar(25) NOT NULL
);

CREATE TABLE Empregado (
	id_empregado INT NOT NULL PRIMARY KEY,
	cod_departamento INT NOT NULL FOREIGN KEY REFERENCES Departamento(id_departamento),
	nome varchar(255) NOT NULL,
	telefone varchar(11) NOT NULL,
	salario INT NOT NULL,
	cargo varchar(25) NOT NULL
);

-- Inserindo Departamentos
INSERT INTO Departamento(id_departamento, ramo)
VALUES (1, 'Logística'), (2, 'TI'), (3, 'Legislativo'), (4, 'Comercial'), (5, 'Recursos Humanos');

SELECT * FROM Departamento;

-- Empregados do Departamento Logística
INSERT INTO Empregado (id_empregado, cod_departamento, nome, cargo, telefone, salario)
VALUES
(1, 1, 'Ana Silva', 'Assistente de Logística', '41988112233', 1500.00),
(2, 1, 'Carlos Souza', 'Analista de Transporte', '41997223344', 1800.00),
(3, 1, 'Fernanda Lima', 'Conferente de Carga', '41996334455', 1300.00),
(4, 1, 'Rafael Gomes', 'Auxiliar de Almoxarifado', '41995445566', 1200.00);

SELECT * FROM Empregado;

-- Empregados do Departamento Tecnologia da Informação
INSERT INTO Empregado (id_empregado, cod_departamento, nome, cargo, telefone, salario)
VALUES
(5, 2, 'Lucas Pereira', 'Desenvolvedor Jr', '11988771122', 1900.00),
(6, 2, 'Mariana Costa', 'Analista de Suporte', '11987662233', 1600.00),
(7, 2, 'João Santos', 'Testador de Software', '11986553344', 1400.00),
(8, 2, 'Patrícia Oliveira', 'Estagiária de TI', '11985444455', 1100.00);

INSERT INTO Empregado (id_empregado, cod_departamento, nome, cargo, telefone, salario)
VALUES (9, 2, 'Bruno Almeida', 'Programador Web', '41990001122', 1800.00);

-- Ordem alfabética
SELECT Empregado.nome AS Nome_Funcionario, Empregado.salario AS Salario, Departamento.ramo AS Ramo_Departamento
FROM Empregado
INNER JOIN 
    Departamento ON Empregado.cod_departamento = Departamento.id_departamento
	ORDER BY Empregado.nome ASC;

--Média
SELECT d.ramo AS Ramo_Departamento, AVG(e.salario) AS Media_Salarial
FROM Empregado e
	INNER JOIN Departamento d ON e.cod_departamento = d.id_departamento
	GROUP BY d.ramo
	ORDER BY d.ramo ASC;

--Quantidade de Empregados
SELECT d.ramo AS Ramo_Departamento, COUNT(e.id_empregado) AS Quantidade_Empregados FROM Departamento d 
	INNER JOIN Empregado e ON d.id_departamento = e.cod_departamento 
	GROUP BY d.ramo ORDER BY d.ramo;

--Ganham mais que a media salarial da empresa
SELECT nome AS Nome_Funcionario, salario AS Salario FROM Empregado
WHERE  salario > (SELECT AVG(salario) FROM Empregado)
ORDER BY salario DESC;

--Departamentos vazios
SELECT d.id_departamento, d.ramo FROM Departamento d
LEFT JOIN 
    Empregado e ON d.id_departamento = e.cod_departamento WHERE e.id_empregado IS NULL;

--Departamentos com 3 empregados ou mais
SELECT d.ramo AS Ramo_Departamento, COUNT(e.id_empregado) AS Total_Empregados FROM Departamento d 
INNER JOIN Empregado e ON d.id_departamento = e.cod_departamento 
GROUP BY d.ramo HAVING COUNT(e.id_empregado) > 3;

--Empregados com mesmo salario em diferentes departamentos
SELECT 
    e.nome,
    d.ramo,
    e.salario
FROM Empregado e
JOIN Departamento d ON e.cod_departamento = d.id_departamento
WHERE e.salario IN (
    SELECT salario
    FROM Empregado
    GROUP BY salario
    HAVING COUNT(DISTINCT cod_departamento) > 1
)
ORDER BY e.salario, d.ramo;

--Evitando perda de dados
EXEC sp_rename 'Empregado.cod_departamento', 'cod_departamento_antigo', 'COLUMN';

--Criando tabela associativa da relacao
CREATE TABLE Empregado_Departamento (
    id_empregado INT NOT NULL FOREIGN KEY REFERENCES Empregado(id_empregado),
    id_departamento INT NOT NULL FOREIGN KEY REFERENCES Departamento(id_departamento),
    PRIMARY KEY (id_empregado, id_departamento)
);
SELECT * FROM Empregado_Departamento
--Migrando dados
INSERT INTO Empregado_Departamento (id_empregado, id_departamento)
SELECT id_empregado, cod_departamento_antigo
FROM Empregado;

--Removendo coluna antiga
ALTER TABLE Empregado
DROP COLUMN cod_departamento_antigo;

SELECT * FROM Empregado_Departamento;
SELECT * FROM Empregado

-- Quantidade de empregados por departamento
SELECT d.ramo AS Ramo_Departamento, COUNT(ed.id_empregado) AS Quantidade_Empregados
FROM Departamento d
LEFT JOIN Empregado_Departamento ed ON d.id_departamento = ed.id_departamento
GROUP BY d.ramo ORDER BY d.ramo ASC;


--Ganham mais que a media salarial da empresa
SELECT nome AS Nome_Funcionario, salario AS Salario FROM Empregado
WHERE  salario > (SELECT AVG(salario) FROM Empregado)
ORDER BY salario DESC;

--Departamentos vazios
SELECT d.id_departamento, d.ramo
FROM Departamento d
LEFT JOIN Empregado_Departamento ed ON d.id_departamento = ed.id_departamento
WHERE ed.id_empregado IS NULL;


--Departamentos com 3 empregados ou mais
SELECT 
    d.ramo AS Ramo_Departamento, 
    COUNT(ed.id_empregado) AS Total_Empregados
FROM 
    Departamento d
INNER JOIN 
    Empregado_Departamento ed ON d.id_departamento = ed.id_departamento
GROUP BY 
    d.ramo
HAVING 
    COUNT(ed.id_empregado) >= 3;


--Empregados com mesmo salario em diferentes departamentos
SELECT 
    e.nome AS Nome_Funcionario, 
    d.ramo AS Departamento, 
    e.salario AS Salario
FROM 
    Empregado e
JOIN 
    Empregado_Departamento ed ON e.id_empregado = ed.id_empregado
JOIN 
    Departamento d ON ed.id_departamento = d.id_departamento
WHERE 
    e.salario IN (
        SELECT e2.salario
        FROM Empregado e2
        JOIN Empregado_Departamento ed2 ON e2.id_empregado = ed2.id_empregado
        GROUP BY e2.salario
        HAVING COUNT(DISTINCT ed2.id_departamento) > 1
    )
ORDER BY 
    e.salario, d.ramo;
