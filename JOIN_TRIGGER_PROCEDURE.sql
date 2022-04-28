
DROP PROCEDURE IF EXISTS sp_friendship_recommendations;
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

/*Посчитать популярность пользователя как отношения заявок в друзья.
ппулярность = (кол-во входящих заявок)/(кол-во исходящих заявок)*/

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
	THEN 
		RETURN cnt_to_user;
	ELSE
		RETURN cnt_to_user / cnt_from_user;
	END IF;
END//

DELIMITER ; 


SELECT TRUNCATE(func_user_popularity(1), 1);
SELECT id, firstname, lastname, func_user_popularity(id) AS popularity 
FROM users
ORDER BY func_user_popularity(id) DESC;

/*выведем друзей пользователя 1, отранжировав их по популярности*/
SELECT DISTINCT u.id 
FROM friend_requests fr 
JOIN users u 
ON fr.from_user_id = u.id OR fr.to_user_id = u.id 
WHERE (fr.from_user_id = 1 OR fr.to_user_id = 1) 
AND fr.request_type = 1 
AND u.id != 1
ORDER BY func_user_popularity(u.id) DESC;

/*
 *Добавим нового пользователя через транзакцию.
*/

START TRANSACTION; 

INSERT INTO users (firstname, lastname, email, phone)
VALUES ('Transaction', 'User', 'new@mail.com', 89111234567);

INSERT INTO profiles (user_id, gender, birthday, city, country)
VALUES (last_insert_id(), 'm', '1999-10-10', 'Moscow', 'Russia');

-- ROLLBACK; -- 

COMMIT; 

/*Добавим нового пользователя через процедуру и транзакцию.*/
DROP PROCEDURE IF EXISTS sp_add_user;

DELIMITER //

CREATE PROCEDURE sp_add_user(firstname VARCHAR(145), lastname VARCHAR(145), email VARCHAR(145), phone CHAR(11),
							gender CHAR(1), birthday DATE, city VARCHAR(130), country VARCHAR(130), OUT tran_result VARCHAR(200))
BEGIN 
	DECLARE tran_rollback BOOL DEFAULT 0;
	DECLARE code VARCHAR(100);
	DECLARE error_string VARCHAR(100);

	
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
	BEGIN 
		SET tran_rollback = 1;
		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT; 
		SET tran_result := CONCAT(code, ': ', error_string); 
	END;

	START TRANSACTION;  
	
	INSERT INTO users (firstname, lastname, email, phone)
	VALUES (firstname, lastname, email, phone);

	INSERT INTO profiles (user_id, gender, birthday, city, country)
	VALUES (last_insert_id(), gender, birthday, city, country);

	IF tran_rollback 
	THEN 
		ROLLBACK;
	ELSE
		SET tran_result := 'ok'; 
		COMMIT; 
	END IF;
END//

DELIMITER ;


CALL sp_add_user('Transaction2', 'User2', 'new2@mail.com', 89303099090, 
				 'm', '1990-11-11',  'Moscow', 'Russia', @tran_result);
	
SELECT @tran_result;

CALL sp_add_user('Transaction3', 'User3', 'new3@mail.com', 83303099090, 
				 'm', '1990-11-11',  'Moscow', 'Russia', @tran_result);
				
SELECT @tran_result;

/* Представление для вывода всех друзей пользователя.*/


CREATE OR REPLACE VIEW view_friends AS
SELECT u.id, u1.id AS friend_id, u1.firstname, u1.lastname 
FROM friend_requests fr 
JOIN users u 
ON (fr.from_user_id = u.id OR fr.to_user_id = u.id)
JOIN users u1 
ON (fr.from_user_id = u1.id OR fr.to_user_id = u1.id)
WHERE u.id != u1.id 
ORDER BY u.id;

SELECT * FROM view_friends;


SELECT friend_id, firstname, lastname 
FROM view_friends 
WHERE id = 1;
-- DROP VIEW view_friends;

/*Вывести рекомендации друзей для пользователя без его друзей.*/
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

/*Создать триггер для контроля даты рождения пользователя.*/

DELIMITER //

CREATE TRIGGER check_birthday_before_insert BEFORE INSERT ON profiles 
FOR EACH ROW 
BEGIN 
	IF NEW.birthday >= CURRENT_DATE() THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. Birthday must be in the past!';
	END IF;
END//

DELIMITER ;

-- неудача с добавлением пользователя с днем рождения больше текущей даты
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

-- неудача с обновлением даты рождения на больше текущей 
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