CREATE DATABASE mercadinho
USE mercadinho

/* CRIA TABELAS  */
CREATE TABLE TB_Cliente
( CodCliente INT IDENTITY(1,1) PRIMARY KEY,
  NomeCliente VARCHAR(50),
  TelefoneCliente VARCHAR(15),
  DataCadastroCliente DATE)

CREATE TABLE TB_Pagamento
( CodPagamento INT IDENTITY(1,1) PRIMARY KEY,
  CodCliente INT,
  CodPedido INT,
  ValorPagamento DECIMAL(8,2),
  DataPagamento DATE)

CREATE TABLE TB_Vendedor
(CodVendedor INT IDENTITY(1,1) PRIMARY KEY,
  NomeVendedor VARCHAR(50),
  RGVendedor   VARCHAR(15),
  DataAdmissaoVendedor DATE)

CREATE TABLE TB_Pedido
( CodPedido   INT IDENTITY(1,1) PRIMARY KEY,
  DataPedido  DATE,
  CodCliente  INT,
  CodVendedor INT)

CREATE TABLE TB_Produto
( CodProduto INT IDENTITY(1,1) PRIMARY KEY,
  NomeProduto VARCHAR(50),
  ValorProduto DECIMAL(5,2))

CREATE TABLE TB_PedidoItem
( CodPedidoItem INT IDENTITY(1,1) PRIMARY KEY,
  CodPedido INT,
  CodProduto INT)

ALTER TABLE TB_Pagamento  WITH CHECK 
ADD  CONSTRAINT FK_TBPagamento_TBCliente
FOREIGN KEY(CodCliente) REFERENCES TB_Cliente (CodCliente)

ALTER TABLE TB_Pagamento  WITH CHECK 
ADD  CONSTRAINT FK_TBPagamento_TBPedido
FOREIGN KEY(CodPedido) REFERENCES TB_Pedido (CodPedido)

ALTER TABLE TB_Pedido  WITH CHECK 
ADD  CONSTRAINT FK_TBPedido_TBCliente
FOREIGN KEY(CodCliente) REFERENCES TB_Cliente (CodCliente)

ALTER TABLE TB_Pedido  WITH CHECK 
ADD  CONSTRAINT FK_TBPedido_TBVendedor
FOREIGN KEY(CodVendedor) REFERENCES TB_Vendedor (CodVendedor)

ALTER TABLE TB_PedidoItem  WITH CHECK 
ADD  CONSTRAINT FK_TBPedidoItem_TBPedido
FOREIGN KEY(CodPedido) REFERENCES TB_Pedido (CodPedido)

ALTER TABLE TB_PedidoItem  WITH CHECK 
ADD  CONSTRAINT FK_TBPedidoItem_TBProduto
FOREIGN KEY(CodProduto) REFERENCES TB_Produto (CodProduto)

/*  INSERT DE DADOS ALEATORIOS    */
-- 5 vendedores
INSERT INTO TB_Vendedor (NomeVendedor, RGVendedor, DataAdmissaoVendedor)
       VALUES (NEWID(), 
       CONVERT(VARCHAR,(CONVERT(INT,(RAND()*100000000+1)))) , 
       CONVERT(DATE,CONVERT(DATETIME, CONVERT(INT,(RAND()*356)+40710))))
GO 5

-- 1.000 Clientes
INSERT INTO TB_Cliente (NomeCliente, TelefoneCliente, DataCadastroCliente)
       VALUES (NEWID(), '(XX) 1234-5678', CONVERT(DATE,CONVERT(DATETIME, CONVERT(INT,(RAND()*356)+40710))))
GO 1000

-- 100 Produtos
INSERT INTO TB_Produto(NomeProduto, ValorProduto)
VALUES ( NEWID(), CONVERT(DECIMAL(5,2),(RAND()*100)+1,2)  )
GO 100

-- 200 Pedidos por vendedor
WITH Clientes AS
(SELECT CodCliente, CONVERT(DATE, DATEADD(DAY,RAND()*100,CONVERT(DATETIME, DataCadastroCliente))) [DataCadastroCliente]
FROM TB_Cliente
WHERE CodCliente = CONVERT(INT,(RAND()*10000)+1) )
INSERT INTO TB_Pedido(CodCliente,DataPedido,CodVendedor)
SELECT CodCliente, DataCadastroCliente,1 FROM Clientes
GO 200

WITH Clientes AS
(SELECT CodCliente, CONVERT(DATE, DATEADD(DAY,RAND()*100,CONVERT(DATETIME, DataCadastroCliente))) [DataCadastroCliente]
FROM TB_Cliente
WHERE CodCliente = CONVERT(INT,(RAND()*10000)+1) )
INSERT INTO TB_Pedido(CodCliente,DataPedido,CodVendedor)
SELECT CodCliente, DataCadastroCliente,2 FROM Clientes
GO 200

WITH Clientes AS
(SELECT CodCliente, CONVERT(DATE, DATEADD(DAY,RAND()*100,CONVERT(DATETIME, DataCadastroCliente))) [DataCadastroCliente]
FROM TB_Cliente
WHERE CodCliente = CONVERT(INT,(RAND()*10000)+1) )
INSERT INTO TB_Pedido(CodCliente,DataPedido,CodVendedor)
SELECT CodCliente, DataCadastroCliente,3 FROM Clientes
GO 200

-- 1000 Itens nos Pedidos
INSERT INTO TB_PedidoItem(CodPedido, CodProduto)
SELECT (SELECT CONVERT(INT,RAND()*MAX(CodPedido)-1) FROM TB_Pedido)
,(SELECT CONVERT(INT,RAND()*MAX(CodProduto)-1) FROM TB_Produto)
GO 1000

-- Itens de Pagamento
INSERT INTO TB_Pagamento (CodCliente, CodPedido, ValorPagamento, DataPagamento)
   SELECT PE.CodCliente, PE.CodPedido, SUM(PR.ValorProduto), CONVERT(DATE, DATEADD(DAY,RAND()*5, CONVERT(DATETIME,PE.DataPedido))) 
FROM TB_Pedido PE
INNER JOIN TB_PedidoItem PI ON PE.CodPedido = PI.CodPedido
INNER JOIN TB_Produto PR ON PR.CodProduto = PI.CodProduto
GROUP BY PE.CodCliente, PE.CodPedido, CONVERT(DATE, DATEADD(DAY,RAND()*5, CONVERT(DATETIME,PE.DataPedido)))
ORDER BY CodCliente, CodPedido

select top 10 * from TB_Pagamento

--1. Qual o valor total pago por cada cliente? (Criar e  executar uma VIEW para mostrar o total de pagamentos feitos por cada cliente).
CREATE VIEW vw_TotalPagamentosPorCliente AS
SELECT codCliente, codPagamento, valorPagamento
FROM TB_Pagamento;
SELECT * FROM vw_TotalPagamentosPorCliente;
--2. Quais produtos foram comprados em cada pedido? (Criar e executar uma VIEW para listar os produtos incluídos em cada pedido com os respectivos nomes).
DROP VIEW vw_ProdutosPorCliente
CREATE VIEW vw_ProdutosPorCliente AS
SELECT 
    --c.NomeCliente,
    p.CodPedido,
    pr.CodProduto,
    pr.NomeProduto
FROM TB_Cliente AS c
INNER JOIN TB_Pedido AS p 
    ON c.CodCliente = p.CodCliente
INNER JOIN TB_PedidoItem AS pi 
    ON p.CodPedido = pi.CodPedido
INNER JOIN TB_Produto AS pr 
    ON pi.CodProduto = pr.CodProduto;
SELECT * FROM vw_ProdutosPorCliente ORDER BY CodPedido ASC;
--3. Qual o total de pedidos realizados por cada vendedor? (Criar e executar uma VIEW para contar quantos pedidos cada vendedor atendeu).
DROP VIEW vw_PedidosPorVendedor
CREATE VIEW vw_PedidosPorVendedor AS
SELECT
    v.NomeVendedor,
    COUNT(p.CodPedido) AS [Qntde Pedidos]
FROM TB_Vendedor AS v
INNER JOIN TB_Pedido AS p 
    ON v.CodVendedor = p.CodVendedor
INNER JOIN TB_PedidoItem AS pi 
    ON p.CodPedido = pi.CodPedido
GROUP BY v.NomeVendedor;

SELECT * FROM vw_PedidosPorVendedor ORDER BY NomeVendedor;
SELECT * FROM TB_Vendedor


--4. Quais clientes ainda não realizaram nenhum pagamento? (Criar e executar uma VIEW para encontrar clientes que estão cadastrados mas não pagaram nada ainda).
DROP VIEW vw_SemPagamento 
CREATE VIEW vw_SemPagamento AS
SELECT 
    c.CodCliente,
    c.NomeCliente,
    p.ValorPagamento
FROM TB_Cliente AS c
INNER JOIN TB_Pagamento AS p 
    ON c.CodCliente = p.CodCliente
WHERE p.CodPagamento = 0;
SELECT * FROM vw_SemPagamento ORDER BY CodCliente;
SELECT * FROM TB_Pagamento
--5. Qual o valor total de vendas (com base nos pagamentos) por data? (Criar e executar uma VIEW para agrupar os valores pagos por data para visualizar o faturamento diário).
CREATE VIEW vw_TotalPagamento AS
SELECT 
    c.CodCliente,
    c.NomeCliente,
    p.DataPagamento,
    COUNT(p.ValorPagamento) AS [QntdPagamentos],
    SUM(p.ValorPagamento) AS [ValorTotalNoDia]
FROM TB_Cliente AS c
INNER JOIN TB_Pagamento AS p 
    ON c.CodCliente = p.CodCliente
GROUP BY c.CodCliente, c.NomeCliente, p.DataPagamento;

SELECT * FROM vw_TotalPagamento;

SELECT * FROM vw_SemPagamento ORDER BY CodCliente;
SELECT * FROM TB_Pagamento
select * from TB_Vendedor
select * from TB_Pagamento
select * from TB_Pedido where codPedido = 0;
select * from TB_Cliente where CodCliente = 
select * from TB_PedidoItem where CodPedido = 
select * from TB_Produto where CodProduto = 
select * from TB_PedidoItem where CodProduto = 
