
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  user_id INT,
  total DECIMAL (11,2) COMMENT '����',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '����� ������������� � �������� ��������';

INSERT INTO accounts (user_id, total) VALUES
  (4, 5000.00),
  (3, 0.00),
  (2, 200.00),
  (NULL, 25000.00);
 SELECT * FROM accounts;
 
START TRANSACTION;
SELECT total FROM accounts WHERE user_id = 4;
UPDATE accounts SET total = total - 2000 WHERE user_id = 4;
UPDATE accounts SET total = total + 2000 WHERE user_id IS NULL;
SELECT * FROM accounts;
COMMIT;

START TRANSACTION;
SELECT total FROM accounts WHERE user_id = 4;
UPDATE accounts SET total = total - 2000 WHERE user_id = 4;
UPDATE accounts SET total = total + 2000 WHERE user_id IS NULL;
ROLLBACK;


START TRANSACTION;
SELECT total FROM accounts WHERE user_id = 4;
SAVEPOINT accounts_4;
UPDATE accounts SET total = total - 2000 WHERE user_id = 4;
ROLLBACK TO SAVEPOINT accounts_4;

SELECT @total := COUNT(*) FROM products;
SELECT @total;
SELECT @price := MAX(price) FROM products;
SELECT * FROM products WHERE price = @price;

SELECT @id := id FROM products;
SELECT @id;

SELECT @id := 5, @ID := 3;
SELECT @id, @ID;

SET @last = NOW() - INTERVAL 7 DAY;
SELECT CURDATE(), @last;

SELECT * FROM tbl1;
SET @start := 0;
SELECT @start := @start + 1 AS id, value FROM tbl1;

CREATE TEMPORARY TABLE temp (id INT, name VARCHAR(255));
SHOW TABLES;
DESCRIBE temp;

PREPARE ver FROM 'SELECT VERSION()';
EXECUTE ver;

PREPARE prd FROM 'SELECT id, name, price FROM products WHERE catalog_id = ?'; /*����� ������ ������ ������ �� ��������*/
SET @catalog_id = 1;
EXECUTE prd USING @catalog_id;

DROP PREPARE prd;/* ������� ������������� ������*/



/*�������������*/
SELECT * FROM catalogs;
CREATE VIEW cat AS SELECT * FROM catalogs ORDER BY name;
SELECT * FROM cat;
SHOW TABLES;

CREATE VIEW cat_reverse (catalog, catalog_id)
AS SELECT name, id FROM catalogs;
SELECT * FROM cat_reverse;

CREATE OR REPLACE VIEW namecat (id, name, total)
AS SELECT id, name, LENGTH(name) FROM catalogs;
SELECT * FROM namecat ORDER BY total DESC;

CREATE ALGORITHM = TEMPTABLE VIEW cat2 AS SELECT * FROM catalogs;

CREATE ALGORITHM = TEMPTABLE VIEW cat2 AS SELECT * FROM catalogs;
DESCRIBE products;

CREATE OR REPLACE VIEW prod AS
SELECT id, name, price, catalog_id
FROM products
ORDER BY catalog_id, name;

SELECT * FROM prod;

SELECT * FROM prod ORDER BY name DESC;

CREATE OR REPLACE VIEW processors AS
SELECT id, name, price, catalog_id
FROM products
WHERE catalog_id = 1;

SELECT * FROM processors;

CREATE VIEW v1 AS
SELECT * FROM tbl1 WHERE value < 'fst5'
WITH CHECK OPTION;

INSERT INTO v1 VALUES ('fst4');
INSERT INTO v1 VALUES ('fst5');
ALTER VIEW v1 AS
SELECT * FROM tbl1 WHERE value > 'fst4'
WITH CHECK OPTION;
CREATE OR REPLACE VIEW v1 AS
SELECT * FROM tbl1 WHERE value > 'fst4'
WITH CHECK OPTION;
DROP VIEW cat, cat_reverse, namecat, prod, processors, v1;
DROP VIEW IF EXISTS cat, cat_reverse, namecat, prod, processors, v1;



/*� ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. 
 * ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.*/


SELECT *FROM shop.users; 
SELECT *FROM sample.users;

SELECT id,lastname
FROM shop.users;

start TRANSACTION;
INSERT INTO sample.users
SELECT shop.users.id, shop.users.firstname FROM shop.users
WHERE id=11;
/*DELETE FROM shop.users /*�� ������� ��-�� �����
WHERE id=11 LIMIT 1;*/
COMMIT;

/*�������� �������������, ������� ������� �������� name �������� ������� �� ������� products
 *  � ��������������� �������� �������� name �� ������� catalogs.*/

SELECT * FROM catalogs;

CREATE VIEW task3 (name, name1)
AS SELECT c.name, p.name  
FROM catalogs c, products p 
ORDER BY c.name;
SELECT * FROM task3;


SELECT p.name AS product_name, c.name AS catalog_name 
FROM products p
JOIN catalogs c;


/*����� ������� ������� � ����������� ����� created_at. 
 � ��� ��������� ���������� ����������� ������ �� ������ 2018 ���� '2018-08-01', '2016-08-04', '2018-08-16' 
 � 2018-08-17. ��������� ������, ������� ������� ������ ������ ��� �� ������, 
 ��������� � �������� ���� �������� 1, ���� ���� ������������ � �������� ������� � 0, ���� ��� �����������.*/

SELECT *
FROM orders o ;

CREATE TEMPORARY TABLE last_days_feb(
DAY int);

INSERT INTO last_days_feb VALUES
(0),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),
(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28);

SELECT * FROM last_days_feb;

SELECT 
date (date('2022-02-28') - INTERVAL l.day DAY )AS Days
FROM 
last_days_feb l
ORDER BY DAY desc;

SELECT o.id AS orderss,
date (date('2022-02-28') - INTERVAL l.day DAY )AS Days
FROM 
last_days_feb l
LEFT JOIN 
orders o
ON (date('2022-02-28') - INTERVAL l.day DAY ) = o.created_at
ORDER BY o.created_at ;



/*����� ������� ����� ������� � ����������� ����� created_at. 
�������� ������, ������� ������� ���������� ������ �� �������, �������� ������ 5 ����� ������ �������.*/
/* ����� ����� ������ ����������, ������� ������� ������������ ���-�� ������(��������� ������) �� ��� � ����� �������������,
 * ���� ��� ���� ������� 5 ��������� ��� 5 ������ ������� - ������� ����������� � ������� ��� ������� ����������� ������*/

SELECT *
FROM orders o ;

SELECT @total := COUNT(*) FROM orders o ;
SELECT *
FROM orders o 
WHERE id>=@total-2
ORDER BY created_at ASC ;


/*�������� �������� ������� hello(), ������� ����� ���������� �����������, 
 * � ����������� �� �������� ������� �����. � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", 
 * � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", � 18:00 �� 00:00 � "������ �����", 
 * � 00:00 �� 6:00 � "������ ����".*/

SELECT now(), HOUR (now());

delimiter //
SELECT now(), HOUR (now())//

CREATE FUNCTION get_hour()
RETURNS int NOT DETERMINISTIC 
BEGIN
	RETURN HOUR (now());
end 

CREATE FUNCTION hello ()
RETURNS tinytext NOT DETERMINISTIC
BEGIN
	DECLARE HOUR int 
	SET HOUR = HOUR (now());
	CASE
	WHEN HOUR BETWEEN 0 AND 5
		THEN 
		RETURN "good night"
	WHEN HOUR BETWEEN 6 AND 11
		THEN 
		RETURN "good morning"
	WHEN HOUR BETWEEN 12 AND 17
		THEN 
		RETURN "good day"
	WHEN HOUR BETWEEN 17 AND 23
		THEN 
		RETURN "good evening"
END CASE;
END//


/*� ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. 
 ��������� ����������� ����� ����� ��� ���� �� ���. ��������, ����� ��� ���� ��������� �������������� 
 �������� NULL �����������. ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� 
 ���� ���������. ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.*/

CREATE TRIGGER validate_name_description_insert BEFORE INSERT ON products 
FOR EACH ROW BEGIN 
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
	SIGNAL SQLSTATE '45000'
	SET message_text = 'name and description is null';
END if;
END

INSERT INTO products 
(name, description, price, catalog_id)
VALUES
(NULL, NULL, 93600.00, 2);

CREATE TRIGGER validate_name_description_update BEFORE UPDATE ON products 
FOR EACH ROW BEGIN 
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
	SIGNAL SQLSTATE '45000'
	SET message_text = 'name and description is null';
END if;
END





