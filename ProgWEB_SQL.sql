-- Criar um banco de dados (se ainda não tiver)
CREATE DATABASE MeuSistemaWeb;
GO

-- Usar o banco de dados
USE MeuSistemaWeb;
GO

-- Criar a tabela Produtos
CREATE TABLE Produtos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0
);
GO

select * from Produtos;
