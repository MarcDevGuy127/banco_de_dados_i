USE BD_Pedido_Marcelo;

SELECT * FROM cliente;

--Testando update para Fermann
UPDATE cliente
SET nome_do_cliente='Fermann'
WHERE codigo_do_cliente=1;

--1) Dando update de Fermann para Marcelo
UPDATE cliente
SET nome_do_cliente='Marcelo'
WHERE codigo_do_cliente=1;

--Verificando quantidade de pedidos
SELECT * FROM item_do_pedido;

--2) Exibindo a quantidade de linhas de item_do_pedido
SELECT COUNT(*) FROM item_do_pedido;

--3) Exibindo a quantidade de linhas de item_do_pedido com ALIAS
SELECT COUNT(*) AS 'Quantidade de registros' FROM item_do_pedido;

SELECT * FROM pedido;
SELECT * FROM item_do_pedido;

--atualizando quantidade de um item_pedido
insert into item_do_pedido values(1, 2, 3);

--4) Totalizando a quantidade de pedidos por código de cliente
SELECT numero_do_pedido, COUNT(quantidade) AS 'Quantidade de pedidos' FROM item_do_pedido
GROUP BY numero_do_pedido;

UPDATE item_do_pedido
SET quantidade=4
WHERE numero_do_pedido=2;

select * from item_do_pedido;

--5) Exibindo apenas pedidos com quantidade maior que 1.
SELECT numero_do_pedido, COUNT(quantidade) AS 'Quantidade de pedidos' FROM item_do_pedido
GROUP BY numero_do_pedido
HAVING COUNT(quantidade) > 1;

--6) Listando informações dos vendedores que tem salários entre R$ 1.000 e R$ 2.000,00 
SELECT * FROM vendedor
WHERE salario_fixo BETWEEN 1000 AND 2000;

--7) Listando todas as informações dos 3 maiores salários - usar comando TOP
SELECT * FROM vendedor;
SELECT TOP 3 nome_do_vendedor, salario_fixo AS 'Maiores salários' FROM vendedor
ORDER BY salario_fixo DESC;

--8) Listando nome de cliente e endereço (apenas em 2 colunas) - usar comando CONCAT ou +
SELECT nome_do_cliente + ' - ' + endereco FROM cliente
ORDER BY nome_do_cliente DESC;

--9) Inserindo novo registro de vendedor e não preencher o salário - usar comando INSERT
SELECT * FROM vendedor;
INSERT INTO vendedor(codigo_do_vendedor, nome_do_vendedor, faixa_de_comissao) VALUES(7, 'Caio', 'D');

--10) Atualizando os salários de todos vendedores que não têm salário preenchido - usar comando UPDATE com IS NULL
UPDATE vendedor
SET salario_fixo=900
WHERE salario_fixo IS NULL;

--Ajustando numero de pedido 1-codigo de produto 1-quantidade 6 para numero de pedido 7
select * from item_do_pedido;
UPDATE item_do_pedido
SET numero_do_pedido=7
WHERE codigo_do_produto=1 AND quantidade=6;

--11) Explicando o resultado do comando DROP TABLE na tabela Pedido
SELECT * FROM pedido;
DROP TABLE pedido;

--Resposta: Não foi possível descartar a tabela 'pedido' porque ele é referenciado por uma FOREIGN KEY, impedindo a sua exclusão.