DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

DROP TABLE IF EXISTS rubrics;
CREATE TABLE rubrics (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO rubrics VALUES
  (NULL, 'Видеокарты'),
  (NULL, 'Память');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';


CREATE TABLE tbl1 (
  value VARCHAR(255)
);
INSERT INTO tbl1
VALUES ('fst1'), ('fst2'), ('fst3');

CREATE TABLE tbl2 (
  value VARCHAR(255)
);
INSERT INTO tbl2
VALUES ('snd1'), ('snd2'), ('snd3');


SELECT c.name 
FROM catalogs c
UNION ALL
SELECT r.name 
FROM rubrics r 
ORDER BY name;

SELECT c.name 
	FROM catalogs c
UNION 
SELECT r.name 
	FROM rubrics r 
ORDER BY name;

(SELECT c.name 
	FROM catalogs c 
	ORDER BY c.name 
	LIMIT 2)
UNION ALL 
(SELECT r.name 
	FROM rubrics r 
	ORDER BY r.name DESC LIMIT 2);


SELECT*
FROM catalogs c
UNION
SELECT p.id ,p.name 
FROM products p ;

SELECT*
FROM catalogs c
UNION
SELECT p.id ,p.name 
FROM products p 
UNION
SELECT u.id, u.name 
FROM users u ;

SELECT*FROM catalogs c ;

SELECT p.id, p.name, p.catalog_id 
FROM products p ;

SELECT p.id, p.name, p.catalog_id 
from products p  
WHERE p.catalog_id =1;

SELECT c.id 
FROM catalogs c  
WHERE c.name ='Процессоры';

SELECT p.id, p.name, p.catalog_id 
from products p  
WHERE p.catalog_id =(SELECT c.id 
						FROM catalogs c  
						WHERE c.name ='Процессоры');
					
SELECT max(p.price) 
FROM products p ;

SELECT p.id, p.name, p.catalog_id 
from products p  
WHERE p.price =(SELECT max(p.price) 
						FROM products p );
					
SELECT p.id, p.name, p.catalog_id, p.price 
from products p  
WHERE p.price <(SELECT avg(p.price) 
						FROM products p );			/*среднее значение*/

						
SELECT p.id, p.name, p.catalog_id 
from products p;
						
SELECT p.id, p.name, 
	(SELECT c.name
	FROM catalogs c 
	WHERE c.id =p.catalog_id) 
FROM products p ;

SELECT p.id ,p.name,
					(SELECT max(p.price) 
					FROM products p
					)AS MAX_PR
FROM products p ;

SELECT p.id, p.name, p.price, p.catalog_id 
FROM products p
WHERE p.catalog_id =2
AND 
p.price < ANY 
			(SELECT p.price 
			FROM products p 
			WHERE p.catalog_id =1); /* любой товарной позиции из другого ираздела*/
			
SELECT p.id, p.name, p.price, p.catalog_id 
FROM products p
WHERE p.catalog_id =2
AND 
p.price < SOME  
			(SELECT p.price 
			FROM products p 
			WHERE p.catalog_id =1); /*если хотя бы одно сравгнение ворзвращает истину = все будет истиной*/
			
SELECT p.id, p.name, p.price, p.catalog_id 
FROM products p
WHERE p.catalog_id =2
AND 
p.price > ALL  
			(SELECT p.price 
			FROM products p 
			WHERE p.catalog_id =1); /* если хотя бы один ложный = все дложь*/
			
SELECT *
FROM catalogs c 
WHERE EXISTS (
				SELECT* 
				FROM products p 
				WHERE c.id= p.catalog_id );

SELECT *
FROM catalogs c 
WHERE NOT EXISTS (
				SELECT* 
				FROM products p 
				WHERE c.id= p.catalog_id );
			
SELECT p.id, p.name, p.price, p.catalog_id  
FROM products p   
WHERE p.catalog_id  =1;

SELECT 
avg(price)
FROM (SELECT * 
		FROM products p   
		WHERE p.catalog_id  =1) AS prod; /* среднее значяение цены*/
		
SELECT AVG(p.price)
FROM  products p 
WHERE p.catalog_id =1;

SELECT p.catalog_id, MIN(p.price)
FROM products p 
GROUP BY p.catalog_id; /*вычислила минимальную цену по категориям*/

SELECT 
AVG(price)
FROM 
(SELECT MIN(p.price) AS price
		FROM products p 
		GROUP BY p.catalog_id) AS prod; 
	
DROP TABLE storehouses;
DROP TABLE storehouses_products ;

SELECT * FROM tbl1
UNION
SELECT * FROM tbl2;

SELECT *
FROM tbl1 t , tbl2 t2 ;

SELECT *
FROM tbl1 t JOIN tbl2 t2  ;

SELECT tbl1.value , tbl2.value from tbl1, tbl2;
SELECT tbl1.* , tbl2.* from tbl1, tbl2;

SELECT
  p.id , p.name, p.price, c.name
FROM
  catalogs c
JOIN
  products p;
 
 SELECT
  p.id , p.name, p.price, c.name
FROM
  catalogs c
JOIN
  products p
  WHERE c.id = p.catalog_id ;
 
 SELECT
  p.name,
  p.price,
  c.name
FROM
  catalogs c
  JOIN products p
ON
  c.id = p.catalog_id; /* on работает в процессе склевиания тбл, where - после склеивания*/
  
  /*самообъединение таблиц*/
SELECT
  *
FROM
  catalogs  AS fst
JOIN
  catalogs  AS snd;
 
 SELECT *
 FROM 
 catalogs AS fst
 JOIN
 catalogs AS dcd
 on 
 fst.id =dcd.id ; /* убрали дубли*/
 
 SELECT *
 FROM 
 catalogs AS fst
 JOIN
 catalogs AS dcd
USING (id);

SELECT
  p.name,
  p.price,
  c.name
FROM
  catalogs c
JOIN
  products p /* основная таблица*/
ON
  c.id = p.catalog_id;
 
 
 SELECT
  p.name,
  p.price,
  c.name
FROM
  catalogs c
LEFT JOIN 
  products p /* стала дополнительной таблица*, каталогс слева от лефт джойн*/
ON
  c.id = p.catalog_id;

 SELECT
  p.name,
  p.price,
  c.name
FROM
  products p  
RIGHT JOIN 
 catalogs c /* стала дополнительной таблица*, каталогс спарва от райт джойн*/
ON
  c.id = p.catalog_id;
 
 UPDATE 
 catalogs c 
 JOIN
 products p 
 on 
 c.id = p.catalog_id 
 SET 
 price = price* 0.9
WHERE 
c.name = 'Материнские платы';

SELECT 
p.price, p.name, c.name
from 
products p 
JOIN
catalogs c ;

DELETE
products, catalogs
FROM
  catalogs
JOIN
  products
ON
  catalogs.id = products.catalog_id
WHERE
  catalogs.name = 'Материнские платы';
 
 
 /*Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.*/
INSERT INTO  orders (id,user_id, created_at, updated_at) 
VALUES
(DEFAULT,1,DEFAULT,DEFAULT),
(DEFAULT,3,DEFAULT,DEFAULT),
(DEFAULT,1,DEFAULT,DEFAULT),
(DEFAULT,6,DEFAULT,DEFAULT);

SELECT * 
FROM orders o ;

SELECT *
FROM 
users u ;
 
 
 SELECT u.name , o.id
 FROM users u 
 JOIN 
 orders o 
 ON u.id=o.user_id 
 ORDER BY o.id ;
 
 
/*Выведите список товаров products и разделов catalogs, который соответствует товару.*/
 
SELECT 
p.price, p.name, c.name
from 
products p 
JOIN
catalogs c 
ON 
p.catalog_id=c.id 
WHERE c.name = 'Процессоры';
 
 
 
/*Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. 
 * Выведите список рейсов flights с русскими названиями городов*/

CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  from1 VARCHAR(255) COMMENT 'from',
  to1 VARCHAR(255) COMMENT 'to');
 
 INSERT INTO flights (id, from1,to1)
 VALUES
 (DEFAULT, 'moscow', 'omsk'),
 (DEFAULT, 'novgorod', 'kazan'),
  (DEFAULT,'irkytsk' ,'moscow' ),
   (DEFAULT, 'omsk', 'irkytsk'),
    (DEFAULT, 'moscow', 'kazan');
   SELECT *
   FROM flights;
  
  CREATE TABLE cities (
  label VARCHAR(255) COMMENT 'eng',
  name1 VARCHAR(255) COMMENT 'rus');
 
 INSERT INTO cities  (label,name1)
 VALUES
 ('moscow', 'Москва'),
 ('novgorod', 'Новгород'),
 ('irkytsk' ,'Иркутск' ),
 ( 'omsk', 'Омс'),
 ( 'kazan', 'Казань');
SELECT *
FROM cities ;


SELECT f.id,c.name1 AS 'откуда' 
FROM flights f 
JOIN
cities c
ON f.from1=c.label;

SELECT f.id,c.name1 AS 'куда'
FROM flights f
JOIN
cities c
ON f.to1=c.label;


SELECT f.id,
			(SELECT c.name1 
			FROM cities c 
			WHERE c.label=f.from1) AS 'from',
				(SELECT c.name1 
				FROM cities c 
				WHERE c.label=f.to1) AS 'to'
FROM flights f;
