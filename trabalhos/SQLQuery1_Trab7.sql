USE BD_Pedido_Marcelo;

SELECT * FROM cliente;
SELECT * FROM pedido;

--1. Listar todos os dados dos clientes e os números de pedidos já realizados pelos clientes
SELECT * FROM cliente
INNER JOIN pedido
	ON cliente.codigo_do_cliente = numero_do_pedido;
--2. Listar todos os dados dos vendedores e os número de pedidos em que constam esses vendedores
SELECT * FROM vendedor
INNER JOIN pedido
	ON vendedor.codigo_do_vendedor = numero_do_pedido;
--3. Listar os pedidos em ordem crescente de número do pedido, incluindo os nomes de clientes e  de vendedores 

SELECT nome_do_vendedor, nome_do_cliente, numero_do_pedido
FROM vendedor
INNER JOIN pedido
    ON vendedor.codigo_do_vendedor = pedido.codigo_do_vendedor
INNER JOIN cliente
    ON pedido.codigo_do_cliente = cliente.codigo_do_cliente
	ORDER BY numero_do_pedido ASC;
--4. Listar todas as informações dos produtos de cada pedido (em ordem de pedido)
SELECT * FROM item_do_pedido;
SELECT * FROM pedido;
SELECT * FROM produto;

SELECT * FROM pedido
INNER JOIN item_do_pedido
	ON 	pedido.numero_do_pedido = item_do_pedido.codigo_do_produto
INNER JOIN produto
	ON 	produto.codigo_do_produto = produto.unidade
	ORDER BY pedido.numero_do_pedido ASC;
--5. Listar nomes dos clientes e os dados dos produtos já adquiridos por cada cliente
SELECT cliente.nome_do_cliente, pedido.numero_do_pedido, produto.* FROM cliente
INNER JOIN pedido
	ON 	cliente.codigo_do_cliente = pedido.numero_do_pedido
INNER JOIN produto
	ON 	produto.codigo_do_produto = produto.unidade
	ORDER BY cliente.nome_do_cliente ASC;
--6.  Em ordem de nome de produto, listar as informações dos pedidos e respectivos vendedores
SELECT produto.*, pedido.*, pedido.codigo_do_vendedor FROM produto
INNER JOIN pedido
	ON produto.codigo_do_produto = pedido.numero_do_pedido
	ORDER BY produto.descricao ASC;
--7. Para cada pedido, informar o nome do vendedor com o número de produtos incluído
select * from produto
select * from pedido

SELECT pedido.numero_do_pedido, pedido.prazo_de_entrega, vendedor.nome_do_vendedor FROM pedido
INNER JOIN vendedor
	ON pedido.numero_do_pedido = pedido.codigo_do_vendedor
	ORDER BY vendedor.nome_do_vendedor ASC;
--8. Listar os 3 pedidos que têm o maior valor (produto.valor_unitário * item_do_pedido.quantidade)

--9. Atualizar o prazo de entrega de todos os pedidos que têm clientes com UF = 'PR'. Se for maior que 3, atualizar o prazo de entrega para 3
--10. Listar todos os pedidos em ordem de vendedor e de cliente para clientes do PR
--11. Listar nome do cliente, endereço e CEP – formatando o CEP no padrão do Brasil e nome do cliente em maiúsculas
--12. Listar nome do cliente e uma informação ‘Outro Estado’ , quando UF for diferente de PR
--13. Listar os nomes dos clientes que fizeram pedidos de VINHOS
--14. Listar os nomes dos 3 vendedores que fizeram mais pedidos
--15. Apresentar a quantidade de pedidos por nome de cliente em ordem alfabética
--16. Apresentar o nome dos produto que teve mais quantidades vendidas
--17. Apresente o nome do cliente que mais gastou até o momento e qual foi o valor total gasto
--18. Apresente o nome do vendedor que mais vendeu até o momento e qual foi o valor total
