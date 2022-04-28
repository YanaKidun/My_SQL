
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  user_id INT,
<<<<<<< HEAD
  total DECIMAL (11,2) COMMENT 'Ã‘Ã·Ã¥Ã²',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Ã‘Ã·Ã¥Ã²Ã  Ã¯Ã®Ã«Ã¼Ã§Ã®Ã¢Ã Ã²Ã¥Ã«Ã¥Ã© Ã¨ Ã¨Ã­Ã²Ã¥Ã°Ã­Ã¥Ã² Ã¬Ã Ã£Ã Ã§Ã¨Ã­Ã ';
=======
  total DECIMAL (11,2) COMMENT 'Ñ÷åò',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Ñ÷åòà ïîëüçîâàòåëåé è èíòåðíåò ìàãàçèíà';
>>>>>>> main

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

<<<<<<< HEAD
PREPARE prd FROM 'SELECT id, name, price FROM products WHERE catalog_id = ?';
SET @catalog_id = 1;
EXECUTE prd USING @catalog_id;

DROP PREPARE prd;



/*Ð¿Ñ€ÐµÐ´ÑÑ‚Ð°Ð²Ð»ÐµÐ½Ð¸Ñ*/
=======
PREPARE prd FROM 'SELECT id, name, price FROM products WHERE catalog_id = ?'; /*äàíèì çàïðîñ òîëüêî îäíîãî èç ðàçäåëîâ*/
SET @catalog_id = 1;
EXECUTE prd USING @catalog_id;

DROP PREPARE prd;/* óäàëèòü äëèíàìè÷åñêóþ çàïðîñ*/



/*ïðåäñòàâëåíèÿ*/
>>>>>>> main
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

<<<<<<< HEAD
/*Ð’ Ð±Ð°Ð·Ðµ Ð´Ð°Ð½Ð½Ñ‹Ñ… shop Ð¸ sample Ð¿Ñ€Ð¸ÑÑƒÑ‚ÑÑ‚Ð²ÑƒÑŽÑ‚ Ð¾Ð´Ð½Ð¸ Ð¸ Ñ‚Ðµ Ð¶Ðµ Ñ‚Ð°Ð±Ð»Ð¸Ñ†Ñ‹, ÑƒÑ‡ÐµÐ±Ð½Ð¾Ð¹ Ð±Ð°Ð·Ñ‹ Ð´Ð°Ð½Ð½Ñ‹Ñ…. 
 * ÐŸÐµÑ€ÐµÐ¼ÐµÑÑ‚Ð¸Ñ‚Ðµ Ð·Ð°Ð¿Ð¸ÑÑŒ id = 1 Ð¸Ð· Ñ‚Ð°Ð±Ð»Ð¸Ñ†Ñ‹ shop.users Ð² Ñ‚Ð°Ð±Ð»Ð¸Ñ†Ñƒ sample.users. Ð˜ÑÐ¿Ð¾Ð»ÑŒÐ·ÑƒÐ¹Ñ‚Ðµ Ñ‚Ñ€Ð°Ð½Ð·Ð°ÐºÑ†Ð¸Ð¸.*/
=======


/*Â áàçå äàííûõ shop è sample ïðèñóòñòâóþò îäíè è òå æå òàáëèöû, ó÷åáíîé áàçû äàííûõ. 
 * Ïåðåìåñòèòå çàïèñü id = 1 èç òàáëèöû shop.users â òàáëèöó sample.users. Èñïîëüçóéòå òðàíçàêöèè.*/
>>>>>>> main


SELECT *FROM shop.users; 
SELECT *FROM sample.users;

SELECT id,lastname
FROM shop.users;

start TRANSACTION;
INSERT INTO sample.users
SELECT shop.users.id, shop.users.firstname FROM shop.users
WHERE id=11;
<<<<<<< HEAD

COMMIT;

/*Ð¡Ð¾Ð·Ð´Ð°Ð¹Ñ‚Ðµ Ð¿Ñ€ÐµÐ´ÑÑ‚Ð°Ð²Ð»ÐµÐ½Ð¸Ðµ, ÐºÐ¾Ñ‚Ð¾Ñ€Ð¾Ðµ Ð²Ñ‹Ð²Ð¾Ð´Ð¸Ñ‚ Ð½Ð°Ð·Ð²Ð°Ð½Ð¸Ðµ name Ñ‚Ð¾Ð²Ð°Ñ€Ð½Ð¾Ð¹ Ð¿Ð¾Ð·Ð¸Ñ†Ð¸Ð¸ Ð¸Ð· Ñ‚Ð°Ð±Ð»Ð¸Ñ†Ñ‹ products
 *  Ð¸ ÑÐ¾Ð¾Ñ‚Ð²ÐµÑ‚ÑÑ‚Ð²ÑƒÑŽÑ‰ÐµÐµ Ð½Ð°Ð·Ð²Ð°Ð½Ð¸Ðµ ÐºÐ°Ñ‚Ð°Ð»Ð¾Ð³Ð° name Ð¸Ð· Ñ‚Ð°Ð±Ð»Ð¸Ñ†Ñ‹ catalogs.*/
=======
/*DELETE FROM shop.users /*íå óäàëÿåò èç-çà êëþ÷à
WHERE id=11 LIMIT 1;*/
COMMIT;

/*Ñîçäàéòå ïðåäñòàâëåíèå, êîòîðîå âûâîäèò íàçâàíèå name òîâàðíîé ïîçèöèè èç òàáëèöû products
 *  è ñîîòâåòñòâóþùåå íàçâàíèå êàòàëîãà name èç òàáëèöû catalogs.*/
>>>>>>> main

SELECT * FROM catalogs;

CREATE VIEW task3 (name, name1)
AS SELECT c.name, p.name  
FROM catalogs c, products p 
ORDER BY c.name;
SELECT * FROM task3;


SELECT p.name AS product_name, c.name AS catalog_name 
FROM products p
JOIN catalogs c;


<<<<<<< HEAD
/*ÐŸÑƒÑÑ‚ÑŒ Ð¸Ð¼ÐµÐµÑ‚ÑÑ Ñ‚Ð°Ð±Ð»Ð¸Ñ†Ð° Ñ ÐºÐ°Ð»ÐµÐ½Ð´Ð°Ñ€Ð½Ñ‹Ð¼ Ð¿Ð¾Ð»ÐµÐ¼ created_at. 
 Ð’ Ð½ÐµÐ¹ Ñ€Ð°Ð·Ð¼ÐµÑ‰ÐµÐ½Ñ‹ Ñ€Ð°Ð·Ñ€ÑÐ¶ÐµÐ½Ñ‹Ðµ ÐºÐ°Ð»ÐµÐ½Ð´Ð°Ñ€Ð½Ñ‹Ðµ Ð·Ð°Ð¿Ð¸ÑÐ¸ Ð·Ð° Ð°Ð²Ð³ÑƒÑÑ‚ 2018 Ð³Ð¾Ð´Ð° '2018-08-01', '2016-08-04', '2018-08-16' 
 Ð¸ 2018-08-17. Ð¡Ð¾ÑÑ‚Ð°Ð²ÑŒÑ‚Ðµ Ð·Ð°Ð¿Ñ€Ð¾Ñ, ÐºÐ¾Ñ‚Ð¾Ñ€Ñ‹Ð¹ Ð²Ñ‹Ð²Ð¾Ð´Ð¸Ñ‚ Ð¿Ð¾Ð»Ð½Ñ‹Ð¹ ÑÐ¿Ð¸ÑÐ¾Ðº Ð´Ð°Ñ‚ Ð·Ð° Ð°Ð²Ð³ÑƒÑÑ‚, 
 Ð²Ñ‹ÑÑ‚Ð°Ð²Ð»ÑÑ Ð² ÑÐ¾ÑÐµÐ´Ð½ÐµÐ¼ Ð¿Ð¾Ð»Ðµ Ð·Ð½Ð°Ñ‡ÐµÐ½Ð¸Ðµ 1, ÐµÑÐ»Ð¸ Ð´Ð°Ñ‚Ð° Ð¿Ñ€Ð¸ÑÑƒÑ‚ÑÑ‚Ð²ÑƒÐµÑ‚ Ð² Ð¸ÑÑ…Ð¾Ð´Ð½Ð¾Ð¼ Ñ‚Ð°Ð±Ð»Ð¸Ñ†Ðµ Ð¸ 0, ÐµÑÐ»Ð¸ Ð¾Ð½Ð° Ð¾Ñ‚ÑÑƒÑ‚ÑÑ‚Ð²ÑƒÐµÑ‚.*/
=======
/*Ïóñòü èìååòñÿ òàáëèöà ñ êàëåíäàðíûì ïîëåì created_at. 
 Â íåé ðàçìåùåíû ðàçðÿæåíûå êàëåíäàðíûå çàïèñè çà àâãóñò 2018 ãîäà '2018-08-01', '2016-08-04', '2018-08-16' 
 è 2018-08-17. Ñîñòàâüòå çàïðîñ, êîòîðûé âûâîäèò ïîëíûé ñïèñîê äàò çà àâãóñò, 
 âûñòàâëÿÿ â ñîñåäíåì ïîëå çíà÷åíèå 1, åñëè äàòà ïðèñóòñòâóåò â èñõîäíîì òàáëèöå è 0, åñëè îíà îòñóòñòâóåò.*/
>>>>>>> main

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



<<<<<<< HEAD
/*ÐŸÑƒÑÑ‚ÑŒ Ð¸Ð¼ÐµÐµÑ‚ÑÑ Ð»ÑŽÐ±Ð°Ñ Ñ‚Ð°Ð±Ð»Ð¸Ñ†Ð° Ñ ÐºÐ°Ð»ÐµÐ½Ð´Ð°Ñ€Ð½Ñ‹Ð¼ Ð¿Ð¾Ð»ÐµÐ¼ created_at. 
Ð¡Ð¾Ð·Ð´Ð°Ð¹Ñ‚Ðµ Ð·Ð°Ð¿Ñ€Ð¾Ñ, ÐºÐ¾Ñ‚Ð¾Ñ€Ñ‹Ð¹ ÑƒÐ´Ð°Ð»ÑÐµÑ‚ ÑƒÑÑ‚Ð°Ñ€ÐµÐ²ÑˆÐ¸Ðµ Ð·Ð°Ð¿Ð¸ÑÐ¸ Ð¸Ð· Ñ‚Ð°Ð±Ð»Ð¸Ñ†Ñ‹, Ð¾ÑÑ‚Ð°Ð²Ð»ÑÑ Ñ‚Ð¾Ð»ÑŒÐºÐ¾ 5 ÑÐ°Ð¼Ñ‹Ñ… ÑÐ²ÐµÐ¶Ð¸Ñ… Ð·Ð°Ð¿Ð¸ÑÐµÐ¹.*/
/* ÑÐ¼Ñ‹ÑÐ» Ñ‚Ð°ÐºÐ¾Ð¹ Ð²Ð²ÐµÑÑ‚Ð¸ Ð¿ÐµÑ€ÐµÐ¼ÐµÐ½Ð½ÑƒÑŽ, ÐºÐ¾Ñ‚Ð¾Ñ€Ð°Ñ Ð¿Ð¾ÐºÐ°Ð¶ÐµÑ‚ Ð¼Ð°ÐºÑÐ¸Ð¼Ð°Ð»ÑŒÐ½Ð¾Ðµ ÐºÐ¾Ð»-Ð²Ð¾ ÑÑ‚Ñ€Ð¾ÐºÐ¸(Ð¿Ð¾ÑÐ»ÐµÐ´Ð½ÑŽÑŽ ÑÑ‚Ñ€Ð¾ÐºÑƒ) Ð¾Ñ‚ Ð½ÐµÐµ Ð¸ Ð±ÑƒÐ´ÐµÐ¼ Ð¾Ñ‚Ñ‚Ð°Ð»ÐºÐ¸Ð²Ð°Ñ‚ÑŒÑÑ,
 * ÐµÑÐ»Ð¸ Ð½Ð°Ð¼ Ð½Ð°Ð´Ð¾ ÑƒÐ²ÑŽÑ€Ð°Ñ‚ÑŒ 5 Ð¿Ð¾ÑÐ»ÐµÐ´Ð½Ð¸Ñ… Ð¸Ð»Ð¸ 5 Ð¿ÐµÑ€Ð²Ñ‹Ñ… Ð·Ð°Ð¿Ð¸ÑÐµÐ¹ - ÑÐ´ÐµÐ»Ð°Ð¸Ñ‚ ÑÐ¾Ñ‚Ñ€Ð¸Ñ‚Ð¸Ñ€Ð¾Ð²Ðº Ð¸ ÑƒÐ´Ð°Ð»Ð¸Ñ‚ÑŒ Ð¸Ð»Ð¸ Ð²Ñ‹Ð²ÐµÑÑ‚Ð¸ Ð½ÐµÐ¾Ð±Ñ…Ð¾Ð´Ð¸Ð¼Ñ‹Ðµ Ð´Ð°Ð½Ð½Ñ‹Ðµ*/
=======
/*Ïóñòü èìååòñÿ ëþáàÿ òàáëèöà ñ êàëåíäàðíûì ïîëåì created_at. 
Ñîçäàéòå çàïðîñ, êîòîðûé óäàëÿåò óñòàðåâøèå çàïèñè èç òàáëèöû, îñòàâëÿÿ òîëüêî 5 ñàìûõ ñâåæèõ çàïèñåé.*/
/* ñìûñë òàêîé ââåñòè ïåðåìåííóþ, êîòîðàÿ ïîêàæåò ìàêñèìàëüíîå êîë-âî ñòðîêè(ïîñëåäíþþ ñòðîêó) îò íåå è áóäåì îòòàëêèâàòüñÿ,
 * åñëè íàì íàäî óâþðàòü 5 ïîñëåäíèõ èëè 5 ïåðâûõ çàïèñåé - ñäåëàèò ñîòðèòèðîâê è óäàëèòü èëè âûâåñòè íåîáõîäèìûå äàííûå*/
>>>>>>> main

SELECT *
FROM orders o ;

SELECT @total := COUNT(*) FROM orders o ;
SELECT *
FROM orders o 
WHERE id>=@total-2
ORDER BY created_at ASC ;


<<<<<<< HEAD

/*Ð¡Ð¾Ð·Ð´Ð°Ð¹Ñ‚Ðµ Ñ…Ñ€Ð°Ð½Ð¸Ð¼ÑƒÑŽ Ñ„ÑƒÐ½ÐºÑ†Ð¸ÑŽ hello(), ÐºÐ¾Ñ‚Ð¾Ñ€Ð°Ñ Ð±ÑƒÐ´ÐµÑ‚ Ð²Ð¾Ð·Ð²Ñ€Ð°Ñ‰Ð°Ñ‚ÑŒ Ð¿Ñ€Ð¸Ð²ÐµÑ‚ÑÑ‚Ð²Ð¸Ðµ, 
 * Ð² Ð·Ð°Ð²Ð¸ÑÐ¸Ð¼Ð¾ÑÑ‚Ð¸ Ð¾Ñ‚ Ñ‚ÐµÐºÑƒÑ‰ÐµÐ³Ð¾ Ð²Ñ€ÐµÐ¼ÐµÐ½Ð¸ ÑÑƒÑ‚Ð¾Ðº. Ð¡ 6:00 Ð´Ð¾ 12:00 Ñ„ÑƒÐ½ÐºÑ†Ð¸Ñ Ð´Ð¾Ð»Ð¶Ð½Ð° Ð²Ð¾Ð·Ð²Ñ€Ð°Ñ‰Ð°Ñ‚ÑŒ Ñ„Ñ€Ð°Ð·Ñƒ "Ð”Ð¾Ð±Ñ€Ð¾Ðµ ÑƒÑ‚Ñ€Ð¾", 
 * Ñ 12:00 Ð´Ð¾ 18:00 Ñ„ÑƒÐ½ÐºÑ†Ð¸Ñ Ð´Ð¾Ð»Ð¶Ð½Ð° Ð²Ð¾Ð·Ð²Ñ€Ð°Ñ‰Ð°Ñ‚ÑŒ Ñ„Ñ€Ð°Ð·Ñƒ "Ð”Ð¾Ð±Ñ€Ñ‹Ð¹ Ð´ÐµÐ½ÑŒ", Ñ 18:00 Ð´Ð¾ 00:00 â€” "Ð”Ð¾Ð±Ñ€Ñ‹Ð¹ Ð²ÐµÑ‡ÐµÑ€", 
 * Ñ 00:00 Ð´Ð¾ 6:00 â€” "Ð”Ð¾Ð±Ñ€Ð¾Ð¹ Ð½Ð¾Ñ‡Ð¸".*/
=======
/*Ñîçäàéòå õðàíèìóþ ôóíêöèþ hello(), êîòîðàÿ áóäåò âîçâðàùàòü ïðèâåòñòâèå, 
 * â çàâèñèìîñòè îò òåêóùåãî âðåìåíè ñóòîê. Ñ 6:00 äî 12:00 ôóíêöèÿ äîëæíà âîçâðàùàòü ôðàçó "Äîáðîå óòðî", 
 * ñ 12:00 äî 18:00 ôóíêöèÿ äîëæíà âîçâðàùàòü ôðàçó "Äîáðûé äåíü", ñ 18:00 äî 00:00 — "Äîáðûé âå÷åð", 
 * ñ 00:00 äî 6:00 — "Äîáðîé íî÷è".*/
>>>>>>> main

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


<<<<<<< HEAD
/*Ð’ Ñ‚Ð°Ð±Ð»Ð¸Ñ†Ðµ products ÐµÑÑ‚ÑŒ Ð´Ð²Ð° Ñ‚ÐµÐºÑÑ‚Ð¾Ð²Ñ‹Ñ… Ð¿Ð¾Ð»Ñ: name Ñ Ð½Ð°Ð·Ð²Ð°Ð½Ð¸ÐµÐ¼ Ñ‚Ð¾Ð²Ð°Ñ€Ð° Ð¸ description Ñ ÐµÐ³Ð¾ Ð¾Ð¿Ð¸ÑÐ°Ð½Ð¸ÐµÐ¼. 
 Ð”Ð¾Ð¿ÑƒÑÑ‚Ð¸Ð¼Ð¾ Ð¿Ñ€Ð¸ÑÑƒÑ‚ÑÑ‚Ð²Ð¸Ðµ Ð¾Ð±Ð¾Ð¸Ñ… Ð¿Ð¾Ð»ÐµÐ¹ Ð¸Ð»Ð¸ Ð¾Ð´Ð½Ð¾ Ð¸Ð· Ð½Ð¸Ñ…. Ð¡Ð¸Ñ‚ÑƒÐ°Ñ†Ð¸Ñ, ÐºÐ¾Ð³Ð´Ð° Ð¾Ð±Ð° Ð¿Ð¾Ð»Ñ Ð¿Ñ€Ð¸Ð½Ð¸Ð¼Ð°ÑŽÑ‚ Ð½ÐµÐ¾Ð¿Ñ€ÐµÐ´ÐµÐ»ÐµÐ½Ð½Ð¾Ðµ 
 Ð·Ð½Ð°Ñ‡ÐµÐ½Ð¸Ðµ NULL Ð½ÐµÐ¿Ñ€Ð¸ÐµÐ¼Ð»ÐµÐ¼Ð°. Ð˜ÑÐ¿Ð¾Ð»ÑŒÐ·ÑƒÑ Ñ‚Ñ€Ð¸Ð³Ð³ÐµÑ€Ñ‹, Ð´Ð¾Ð±ÐµÐ¹Ñ‚ÐµÑÑŒ Ñ‚Ð¾Ð³Ð¾, Ñ‡Ñ‚Ð¾Ð±Ñ‹ Ð¾Ð´Ð½Ð¾ Ð¸Ð· ÑÑ‚Ð¸Ñ… Ð¿Ð¾Ð»ÐµÐ¹ Ð¸Ð»Ð¸ Ð¾Ð±Ð° Ð¿Ð¾Ð»Ñ 
 Ð±Ñ‹Ð»Ð¸ Ð·Ð°Ð¿Ð¾Ð»Ð½ÐµÐ½Ñ‹. ÐŸÑ€Ð¸ Ð¿Ð¾Ð¿Ñ‹Ñ‚ÐºÐµ Ð¿Ñ€Ð¸ÑÐ²Ð¾Ð¸Ñ‚ÑŒ Ð¿Ð¾Ð»ÑÐ¼ NULL-Ð·Ð½Ð°Ñ‡ÐµÐ½Ð¸Ðµ Ð½ÐµÐ¾Ð±Ñ…Ð¾Ð´Ð¸Ð¼Ð¾ Ð¾Ñ‚Ð¼ÐµÐ½Ð¸Ñ‚ÑŒ Ð¾Ð¿ÐµÑ€Ð°Ñ†Ð¸ÑŽ.*/
=======
/*Â òàáëèöå products åñòü äâà òåêñòîâûõ ïîëÿ: name ñ íàçâàíèåì òîâàðà è description ñ åãî îïèñàíèåì. 
 Äîïóñòèìî ïðèñóòñòâèå îáîèõ ïîëåé èëè îäíî èç íèõ. Ñèòóàöèÿ, êîãäà îáà ïîëÿ ïðèíèìàþò íåîïðåäåëåííîå 
 çíà÷åíèå NULL íåïðèåìëåìà. Èñïîëüçóÿ òðèããåðû, äîáåéòåñü òîãî, ÷òîáû îäíî èç ýòèõ ïîëåé èëè îáà ïîëÿ 
 áûëè çàïîëíåíû. Ïðè ïîïûòêå ïðèñâîèòü ïîëÿì NULL-çíà÷åíèå íåîáõîäèìî îòìåíèòü îïåðàöèþ.*/
>>>>>>> main

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





