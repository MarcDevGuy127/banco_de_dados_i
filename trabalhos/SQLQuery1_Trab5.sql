CREATE DATABASE BD_Pedido_Marcelo;
USE BD_Pedido_Marcelo;

create table cliente(
 codigo_do_cliente integer primary key not null,
 nome_do_cliente varchar(20),
 endereco varchar(20),
 cidade varchar(20),
 cep integer,
 UF varchar(20),
 cnpj varchar(20),
 ie varchar(20));

create table vendedor
 (codigo_do_vendedor integer primary key not null,
 nome_do_vendedor varchar(20),
 faixa_de_comissao char(1),
 salario_fixo money);

create table pedido(
 numero_do_pedido integer primary key not null,
 prazo_de_entrega date,
 codigo_do_cliente integer,
 codigo_do_vendedor integer,
 foreign key (codigo_do_cliente) references cliente,
 foreign key (codigo_do_vendedor) references vendedor);

create table produto(
 codigo_do_produto integer primary key not null,
 descricao varchar(20),
 unidade varchar(20),
 val_unit SMALLMONEY);

create table item_do_pedido(
 numero_do_pedido integer not null,
 codigo_do_produto integer,
 quantidade integer,
 foreign key (codigo_do_produto) references produto,
 foreign key (numero_do_pedido) references pedido,
 primary key(numero_do_pedido, codigo_do_produto));

 SELECT * FROM cliente;

 INSERT INTO cliente(codigo_do_cliente, nome_do_cliente, endereco, cidade, cep, UF, cnpj, ie)
 VALUES (1, 'Marcelo', 'Rua Rio Piraquara', 'Pinhais', 1, 'PR', 1, 1),
   (2, 'Marcos', 'Rua Rio Solimões', 'São José dos Pinhais', 2, 'PR', 2, 2),
   (3, 'Jorge', 'Rua Rio Macapá', 'Ponta-Grossa', 3, 'PR', 3, 3),
   (4, 'Chico', 'Rua da Bahia', 'Xique-Xique', 4, 'BA', 4, 4),
   (5, 'Ednaldo', 'Avenida Paulista', 'São-Paulo', 5, 'SP', 5, 5),
   (6, 'Gabriel', 'Rua Sorupê', 'Curitiba', 6, 'PR', 6, 6);

 SELECT * FROM vendedor;

 INSERT INTO vendedor(codigo_do_vendedor, nome_do_vendedor, faixa_de_comissao, salario_fixo)
 VALUES (1, 'Marcos Paulo', 3000, 4000),
 (2, 'Jorge Mateus', 2000, 1000),
 (3, 'Luan Santana', 2500, 5000),
 (4, 'Paula Fernandes', 6000, 4000),
 (5, 'Maiara e Maraísa', 9000, 6000),
 (6, 'Thiago', 6000, 4000);

 update vendedor
 set faixa_de_comissao='A'
 where codigo_do_vendedor = 1;

 SELECT * FROM vendedor;

 update vendedor
 set faixa_de_comissao='B'
 where codigo_do_vendedor >= 2;

 SELECT * FROM vendedor;

 update vendedor
 set faixa_de_comissao='C'
 where codigo_do_vendedor > 4;

 SELECT * FROM vendedor;

 SELECT * FROM produto;
 INSERT INTO produto(codigo_do_produto, descricao, unidade, val_unit)
 VALUES (1,'Bola de Futebol', 2, 35),
 (2, 'Tênis', 2, 100),
 (3, 'Xbox Series X', 1, 5000),
 (4, 'Minecraft', 1, 50),
 (5, 'GTA V', 1, 10000),
 (6, 'Chinelo', 2, 25);

 update produto
 set val_unit = 500
 where val_unit = 10000;

 select * from item_do_pedido;
 INSERT INTO item_do_pedido
 VALUES (1, 1, 2),
 (2, 2, 2),
 (3, 3, 1),
 (4, 4, 1),
 (5, 5, 1),
 (6, 6, 2);

 select * from item_do_pedido;

 update item_do_pedido
 set quantidade = 3
 where numero_do_pedido = 4;

 update item_do_pedido
 set quantidade = 5
 where numero_do_pedido = 3;

 select * from pedido;
 INSERT INTO pedido
 VALUES (1,'2025-08-26', 1, 1),
 (2,'2025-08-26', 2, 2),
 (3,'2025-08-26', 3, 3),
 (4,'2025-08-26', 4, 4),
 (5,'2025-08-26', 5, 5),
 (6,'2025-08-26', 6, 6);

 SELECT * FROM cliente ORDER BY nome_do_cliente ASC;

 SELECT COUNT(*) FROM cliente; --quantidade de clientes

 SELECT * FROM cliente WHERE nome_do_cliente LIKE 'M%'; --selecionando clientes com a letra M

 SELECT * FROM produto ORDER BY val_unit DESC; --filtrando produtos do caro para o barato

 SELECT * FROM pedido WHERE codigo_do_cliente = 3; --exibindo codigo igual a 3

 SELECT * FROM vendedor
 WHERE salario_fixo = (SELECT MIN(salario_fixo) from vendedor); --menor salario

 SELECT * FROM item_do_pedido
 WHERE quantidade = (SELECT MAX(quantidade) from item_do_pedido); --maior quantidade

 SELECT * FROM vendedor;

 update vendedor
 set salario_fixo = 500
 where nome_do_vendedor='Thiago';

 update vendedor
 set salario_fixo = 1500
 where nome_do_vendedor='Marcos Paulo';

 SELECT AVG(salario_fixo) FROM vendedor; --media salarial dos vendedores

 SELECT SUM(salario_fixo) FROM vendedor; --soma dos salarios dos vendedores

 SELECT codigo_do_cliente, COUNT(numero_do_pedido) 
 FROM pedido
 GROUP BY codigo_do_cliente; --quantidade de pedidos por cliente

 select * from pedido;
 INSERT INTO pedido
 VALUES(7, '2025-08-26', 1,3); --alterando a qntde de pedidos de um cliente

 SELECT codigo_do_cliente, COUNT(numero_do_pedido)
 FROM pedido
 GROUP BY codigo_do_cliente
 HAVING COUNT(numero_do_pedido) >= 2; --apenas clientes com mais de um pedido

 SELECT * FROM item_do_pedido;

 SELECT numero_do_pedido, COUNT(quantidade)
 FROM item_do_pedido
 GROUP BY numero_do_pedido;  --quantidade de pedidos por numero_do_pedido

 update item_do_pedido
 set quantidade = 6
 where codigo_do_produto = 1;

 SELECT numero_do_pedido, SUM(quantidade)
 FROM item_do_pedido
 GROUP BY numero_do_pedido
 HAVING SUM(quantidade) > 5;  --quantidade de pedidos acima de 5

 
