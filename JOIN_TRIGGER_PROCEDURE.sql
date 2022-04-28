<<<<<<< HEAD

DROP PROCEDURE IF EXISTS sp_friendship_recommendations;
=======
/* Урок № 10. Транзакции, переменные, представления. Администрирование. 
 * 			  Хранимые процедуры и функции, триггеры.
* Задание 1. Написать процедуру для рекомендации пользователю новых друзей (живут в одном городе, состоят в одном сообществе)
*/

DROP PROCEDURE IF EXISTS sp_friendship_recommendations;
-- ставим новое обозначение окончания команды (разделитель)
>>>>>>> main
DELIMITER //
CREATE PROCEDURE sp_frs(IN for_user_id BIGINT UNSIGNED)
BEGIN
	SELECT for_user_id ;
END//

CALL sp_frs(2);



DELIMITER //
CREATE PROCEDURE sp_friendship_recommendations(IN for_user_id BIGINT UNSIGNED)
BEGIN
	SELECT p2.user_id 
<<<<<<< HEAD
	FROM profiles p1 
	JOIN profiles p2 
	ON p1.city = p2.city  
	WHERE p1.user_id = for_user_id 
	AND p2.user_id != for_user_id  
	UNION -- 	
    SELECT cu2.user_id 
	FROM communities_users cu1 
	JOIN communities_users cu2 
	ON cu1.community_id = cu2.community_id 
	WHERE cu1.user_id = for_user_id 
	AND cu2.user_id != for_user_id 
	ORDER BY RAND() 
	LIMIT 5; 
END// 


DELIMITER ;
CALL sp_friendship_recommendations(2);

/*РџРѕСЃС‡РёС‚Р°С‚СЊ РїРѕРїСѓР»СЏСЂРЅРѕСЃС‚СЊ РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ РєР°Рє РѕС‚РЅРѕС€РµРЅРёСЏ Р·Р°СЏРІРѕРє РІ РґСЂСѓР·СЊСЏ.
РїРїСѓР»СЏСЂРЅРѕСЃС‚СЊ = (РєРѕР»-РІРѕ РІС…РѕРґСЏС‰РёС… Р·Р°СЏРІРѕРє)/(РєРѕР»-РІРѕ РёСЃС…РѕРґСЏС‰РёС… Р·Р°СЏРІРѕРє)*/

DROP FUNCTION IF EXISTS func_user_popularity;

DELIMITER // 
CREATE FUNCTION func_user_popularity(for_user_id BIGINT UNSIGNED)
RETURNS FLOAT READS SQL DATA 
BEGIN 
	DECLARE cnt_to_user INT;
	DECLARE cnt_from_user INT;
	SET cnt_to_user = (SELECT COUNT(*) FROM friend_requests WHERE to_user_id = for_user_id);
	SELECT COUNT(*) INTO cnt_from_user FROM friend_requests WHERE from_user_id = for_user_id;

    IF cnt_from_user = 0
=======
	FROM profiles p1 -- из одного города
	JOIN profiles p2 
	ON p1.city = p2.city  -- выбираем пользователей p2 из того же города, что и заданный пользователь
	WHERE p1.user_id = for_user_id -- находим в p1 город заданного пользователя
	AND p2.user_id != for_user_id -- исключаем заданного пользователя из p2   
	UNION -- объединяем два найденных сета
	SELECT cu2.user_id 
	FROM communities_users cu1 -- из одного сообщества
	JOIN communities_users cu2 
	ON cu1.community_id = cu2.community_id -- выбираем пользователей uc2 из тех же сообществ, что и заданный пользователь
	WHERE cu1.user_id = for_user_id  -- находим в uc1 сообщества заданного пользователя
	AND cu2.user_id != for_user_id -- исключаем заданного пользователя из uc2
	ORDER BY RAND() -- берем случайные записи
	LIMIT 5; -- выводим только 5 человек из рекомендаций
END// -- обозначаем конец процедуры новым разделителем

-- возвращаем стандартный разделитель
DELIMITER ;

-- вызываем функцию для пользователя 2
CALL sp_friendship_recommendations(2);

/*
 * Задание 2. Посчитать популярность пользователя как отношения заявок в друзья.
 * 			  популярность = (кол-во входящих заявок)/(кол-во исходящих заявок)
*/

DROP FUNCTION IF EXISTS func_user_popularity;

DELIMITER // -- выставим разделитель
CREATE FUNCTION func_user_popularity(for_user_id BIGINT UNSIGNED)
RETURNS FLOAT READS SQL DATA -- так как мы только читаем данные
BEGIN 
	DECLARE cnt_to_user INT;
	DECLARE cnt_from_user INT;
	
	-- посчитаем количество входящих заявок
	SET cnt_to_user = (SELECT COUNT(*) FROM friend_requests WHERE to_user_id = for_user_id);

	-- посчитаем количество исходящих заявок другим способом
	SELECT COUNT(*) INTO cnt_from_user FROM friend_requests WHERE from_user_id = for_user_id;

    -- хотим выводить результат даже при отсутсвии исходящих заявок

	IF cnt_from_user = 0
>>>>>>> main
	THEN 
		RETURN cnt_to_user;
	ELSE
		RETURN cnt_to_user / cnt_from_user;
	END IF;
END//

<<<<<<< HEAD
DELIMITER ; 


SELECT TRUNCATE(func_user_popularity(1), 1);
=======
DELIMITER ; -- возвращаем исходный разделитель

-- вызов функции
SELECT TRUNCATE(func_user_popularity(1), 1);

>>>>>>> main
SELECT id, firstname, lastname, func_user_popularity(id) AS popularity 
FROM users
ORDER BY func_user_popularity(id) DESC;

<<<<<<< HEAD
/*РІС‹РІРµРґРµРј РґСЂСѓР·РµР№ РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ 1, РѕС‚СЂР°РЅР¶РёСЂРѕРІР°РІ РёС… РїРѕ РїРѕРїСѓР»СЏСЂРЅРѕСЃС‚Рё*/
=======
-- Использование функции: выведем друзей пользователя 1, отранжировав их по популярности
>>>>>>> main
SELECT DISTINCT u.id 
FROM friend_requests fr 
JOIN users u 
ON fr.from_user_id = u.id OR fr.to_user_id = u.id 
WHERE (fr.from_user_id = 1 OR fr.to_user_id = 1) 
AND fr.request_type = 1 
AND u.id != 1
ORDER BY func_user_popularity(u.id) DESC;

/*
<<<<<<< HEAD
 *Р”РѕР±Р°РІРёРј РЅРѕРІРѕРіРѕ РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ С‡РµСЂРµР· С‚СЂР°РЅР·Р°РєС†РёСЋ.
*/

START TRANSACTION; 
=======
 * Задание 3. Добавим нового пользователя через транзакцию.
*/

START TRANSACTION; -- начало транзакции
>>>>>>> main

INSERT INTO users (firstname, lastname, email, phone)
VALUES ('Transaction', 'User', 'new@mail.com', 89111234567);

INSERT INTO profiles (user_id, gender, birthday, city, country)
VALUES (last_insert_id(), 'm', '1999-10-10', 'Moscow', 'Russia');

<<<<<<< HEAD
-- ROLLBACK; -- 

COMMIT; 

/*Р”РѕР±Р°РІРёРј РЅРѕРІРѕРіРѕ РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ С‡РµСЂРµР· РїСЂРѕС†РµРґСѓСЂСѓ Рё С‚СЂР°РЅР·Р°РєС†РёСЋ.*/
=======
-- ROLLBACK; -- отмена транзакции, новых строк добавлено не будет

COMMIT; -- успешное завершение транзакции, были добавлены строки в users и profiles

/*
 * Задание 4. Добавим нового пользователя через процедуру и транзакцию.
*/
>>>>>>> main
DROP PROCEDURE IF EXISTS sp_add_user;

DELIMITER //

CREATE PROCEDURE sp_add_user(firstname VARCHAR(145), lastname VARCHAR(145), email VARCHAR(145), phone CHAR(11),
							gender CHAR(1), birthday DATE, city VARCHAR(130), country VARCHAR(130), OUT tran_result VARCHAR(200))
BEGIN 
	DECLARE tran_rollback BOOL DEFAULT 0;
	DECLARE code VARCHAR(100);
	DECLARE error_string VARCHAR(100);

	
<<<<<<< HEAD
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
	BEGIN 
		SET tran_rollback = 1;
		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT; 
		SET tran_result := CONCAT(code, ': ', error_string); 
	END;

	START TRANSACTION;  
=======
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  -- обработка ошибок
	BEGIN 
		SET tran_rollback = 1; -- если пойман exception ставим флажок
		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT; -- выбираем код ошибки и сообщение
		SET tran_result := CONCAT(code, ': ', error_string); -- собираем в результат
	END;

	START TRANSACTION;  -- запускаем транзакцию добавления пользователя
>>>>>>> main
	
	INSERT INTO users (firstname, lastname, email, phone)
	VALUES (firstname, lastname, email, phone);

	INSERT INTO profiles (user_id, gender, birthday, city, country)
	VALUES (last_insert_id(), gender, birthday, city, country);

<<<<<<< HEAD
	IF tran_rollback 
	THEN 
		ROLLBACK;
	ELSE
		SET tran_result := 'ok'; 
		COMMIT; 
=======
	IF tran_rollback  -- если была получена ошибка откатываем изменения
	THEN 
		ROLLBACK;
	ELSE
		SET tran_result := 'ok'; -- если пользователь добавлен, выводим ок
		COMMIT; -- успешно завершаем транзакцию
>>>>>>> main
	END IF;
END//

DELIMITER ;

<<<<<<< HEAD

CALL sp_add_user('Transaction2', 'User2', 'new2@mail.com', 89303099090, 
				 'm', '1990-11-11',  'Moscow', 'Russia', @tran_result);
	
=======
-- вызываем процедуру
CALL sp_add_user('Transaction2', 'User2', 'new2@mail.com', 89303099090, 
				 'm', '1990-11-11',  'Moscow', 'Russia', @tran_result);
-- смотрим отладочную информацию		
>>>>>>> main
SELECT @tran_result;

CALL sp_add_user('Transaction3', 'User3', 'new3@mail.com', 83303099090, 
				 'm', '1990-11-11',  'Moscow', 'Russia', @tran_result);
				
SELECT @tran_result;

<<<<<<< HEAD
/* РџСЂРµРґСЃС‚Р°РІР»РµРЅРёРµ РґР»СЏ РІС‹РІРѕРґР° РІСЃРµС… РґСЂСѓР·РµР№ РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ.*/


=======
/*
 * Задание 5. Представление для вывода всех друзей пользователя.
*/

-- представление, выбирающее друзей пользователей
>>>>>>> main
CREATE OR REPLACE VIEW view_friends AS
SELECT u.id, u1.id AS friend_id, u1.firstname, u1.lastname 
FROM friend_requests fr 
JOIN users u 
ON (fr.from_user_id = u.id OR fr.to_user_id = u.id)
JOIN users u1 
ON (fr.from_user_id = u1.id OR fr.to_user_id = u1.id)
WHERE u.id != u1.id 
ORDER BY u.id;

<<<<<<< HEAD
SELECT * FROM view_friends;


SELECT friend_id, firstname, lastname 
FROM view_friends 
WHERE id = 1;
-- DROP VIEW view_friends;

/*Р’С‹РІРµСЃС‚Рё СЂРµРєРѕРјРµРЅРґР°С†РёРё РґСЂСѓР·РµР№ РґР»СЏ РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ Р±РµР· РµРіРѕ РґСЂСѓР·РµР№.*/
=======
 -- смотрим на содержимое представления
SELECT * FROM view_friends;

 -- список друзе пользователя 1
SELECT friend_id, firstname, lastname 
FROM view_friends 
WHERE id = 1;

-- удаляем представление
-- DROP VIEW view_friends;

/*
 * Задание 6. Вывести рекомендации друзей для пользователя без его друзей.
*/
>>>>>>> main
DROP PROCEDURE IF EXISTS sp_friendship_recommendations_advanced;

DELIMITER //

CREATE PROCEDURE sp_friendship_recommendations_advanced(IN from_user_id BIGINT UNSIGNED)
BEGIN 
	SELECT * FROM 
		(SELECT p2.user_id FROM profiles p1
		JOIN profiles p2 ON p1.city = p2.city 
		WHERE p1.user_id = from_user_id AND p2.user_id != from_user_id
		UNION
		SELECT cu2.user_id FROM communities_users cu1
		JOIN communities_users cu2 ON cu1.community_id = cu2.community_id
		WHERE cu1.user_id = from_user_id AND cu2.user_id != from_user_id) AS t_recommendations
	WHERE t_recommendations.user_id NOT IN (SELECT friend_id FROM view_friends WHERE id = from_user_id) 
	ORDER BY RAND()
	LIMIT 5;	
END//

DELIMITER ;

CALL sp_friendship_recommendations_advanced(10); 

<<<<<<< HEAD
/*РЎРѕР·РґР°С‚СЊ С‚СЂРёРіРіРµСЂ РґР»СЏ РєРѕРЅС‚СЂРѕР»СЏ РґР°С‚С‹ СЂРѕР¶РґРµРЅРёСЏ РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ.*/
=======
/*
 * Задание 7. Создать триггер для контроля даты рождения пользователя.
*/
>>>>>>> main

DELIMITER //

CREATE TRIGGER check_birthday_before_insert BEFORE INSERT ON profiles 
FOR EACH ROW 
BEGIN 
	IF NEW.birthday >= CURRENT_DATE() THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. Birthday must be in the past!';
	END IF;
END//

DELIMITER ;

<<<<<<< HEAD
-- РЅРµСѓРґР°С‡Р° СЃ РґРѕР±Р°РІР»РµРЅРёРµРј РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ СЃ РґРЅРµРј СЂРѕР¶РґРµРЅРёСЏ Р±РѕР»СЊС€Рµ С‚РµРєСѓС‰РµР№ РґР°С‚С‹
=======
-- неудача с добавлением пользователя с днем рождения больше текущей даты
>>>>>>> main
INSERT INTO users (firstname, lastname, email, phone) VALUES 
	('Trigger', 'Check', 'trigger@mail.com', '89111111111');
	
INSERT INTO profiles (user_id, gender, birthday) VALUES 
	(last_insert_id(), 'x', '2030-12-01');

DELIMITER //

CREATE TRIGGER check_birthday_before_update BEFORE UPDATE ON profiles 
FOR EACH ROW 
BEGIN 
	IF NEW.birthday >= current_date() THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Update Canceled. Birthday must be in the past!';
	END IF;
END//

DELIMITER ;

<<<<<<< HEAD
-- РЅРµСѓРґР°С‡Р° СЃ РѕР±РЅРѕРІР»РµРЅРёРµРј РґР°С‚С‹ СЂРѕР¶РґРµРЅРёСЏ РЅР° Р±РѕР»СЊС€Рµ С‚РµРєСѓС‰РµР№ 
UPDATE profiles SET birthday = '2030-01-01' WHERE user_id = 1;


SELECT p2.user_id FROM profiles p1 
	JOIN profiles p2 ON p1.city = p2.city  
	WHERE p1.user_id = for_user_id 
	AND p2.user_id != for_user_id 
	UNION 
	SELECT cu2.user_id FROM communities_users cu1 
	JOIN communities_users cu2 ON cu1.community_id = cu2.community_id 
	WHERE cu1.user_id = for_user_id  
	AND cu2.user_id != for_user_id 
	ORDER BY RAND() -
	LIMIT 3; 
=======
-- неудача с обновлением даты рождения на больше текущей 
UPDATE profiles SET birthday = '2030-01-01' WHERE user_id = 1;


SELECT o.book, b.name,g.name  FROM orders o 
JOIN   books b 
ON o.book =b.id
JOIN   genres g
ON b.genre=g.id
WHERE o.from_user =5

SELECT b.name FROM books b
WHERE b.genre = (SELECT DISTINCT g.id  FROM orders o 
JOIN   books b 
ON o.book =b.id
JOIN   genres g
ON b.genre=g.id
WHERE o.from_user =5)
ORDER BY RAND() 
	LIMIT 2;

SELECT DISTINCT  g.id  FROM orders o 
JOIN   books b 
ON o.book =b.id
JOIN   genres g
ON b.genre=g.id
WHERE o.from_user =5;

SELECT p2.user_id FROM profiles p1 -- из одного города
	JOIN profiles p2 ON p1.city = p2.city  -- выбираем пользователей p2 из того же города, что и заданный пользователь
	WHERE p1.user_id = for_user_id -- находим в p1 город заданного пользователя
	AND p2.user_id != for_user_id -- исключаем заданного пользователя из p2   
	UNION -- объединяем два найденных сета
	SELECT cu2.user_id FROM communities_users cu1 -- из одного сообщества
	JOIN communities_users cu2 ON cu1.community_id = cu2.community_id -- выбираем пользователей uc2 из тех же сообществ, что и заданный пользователь
	WHERE cu1.user_id = for_user_id  -- находим в uc1 сообщества заданного пользователя
	AND cu2.user_id != for_user_id -- исключаем заданного пользователя из uc2
	ORDER BY RAND() -- берем случайные записи
	LIMIT 3; -- выводим только 5 человек из рекомендаций
>>>>>>> main
