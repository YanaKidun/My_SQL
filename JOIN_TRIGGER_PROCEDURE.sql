<<<<<<< HEAD

DROP PROCEDURE IF EXISTS sp_friendship_recommendations;
=======
/* ���� � 10. ����������, ����������, �������������. �����������������. 
 * 			  �������� ��������� � �������, ��������.
* ������� 1. �������� ��������� ��� ������������ ������������ ����� ������ (����� � ����� ������, ������� � ����� ����������)
*/

DROP PROCEDURE IF EXISTS sp_friendship_recommendations;
-- ������ ����� ����������� ��������� ������� (�����������)
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
=======
	FROM profiles p1 -- �� ������ ������
	JOIN profiles p2 
	ON p1.city = p2.city  -- �������� ������������� p2 �� ���� �� ������, ��� � �������� ������������
	WHERE p1.user_id = for_user_id -- ������� � p1 ����� ��������� ������������
	AND p2.user_id != for_user_id -- ��������� ��������� ������������ �� p2   
	UNION -- ���������� ��� ��������� ����
	SELECT cu2.user_id 
	FROM communities_users cu1 -- �� ������ ����������
	JOIN communities_users cu2 
	ON cu1.community_id = cu2.community_id -- �������� ������������� uc2 �� ��� �� ���������, ��� � �������� ������������
	WHERE cu1.user_id = for_user_id  -- ������� � uc1 ���������� ��������� ������������
	AND cu2.user_id != for_user_id -- ��������� ��������� ������������ �� uc2
	ORDER BY RAND() -- ����� ��������� ������
	LIMIT 5; -- ������� ������ 5 ������� �� ������������
END// -- ���������� ����� ��������� ����� ������������

-- ���������� ����������� �����������
DELIMITER ;

-- �������� ������� ��� ������������ 2
CALL sp_friendship_recommendations(2);

/*
 * ������� 2. ��������� ������������ ������������ ��� ��������� ������ � ������.
 * 			  ������������ = (���-�� �������� ������)/(���-�� ��������� ������)
*/

DROP FUNCTION IF EXISTS func_user_popularity;

DELIMITER // -- �������� �����������
CREATE FUNCTION func_user_popularity(for_user_id BIGINT UNSIGNED)
RETURNS FLOAT READS SQL DATA -- ��� ��� �� ������ ������ ������
BEGIN 
	DECLARE cnt_to_user INT;
	DECLARE cnt_from_user INT;
	
	-- ��������� ���������� �������� ������
	SET cnt_to_user = (SELECT COUNT(*) FROM friend_requests WHERE to_user_id = for_user_id);

	-- ��������� ���������� ��������� ������ ������ ��������
	SELECT COUNT(*) INTO cnt_from_user FROM friend_requests WHERE from_user_id = for_user_id;

    -- ����� �������� ��������� ���� ��� ��������� ��������� ������

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
DELIMITER ; -- ���������� �������� �����������

-- ����� �������
SELECT TRUNCATE(func_user_popularity(1), 1);

>>>>>>> main
SELECT id, firstname, lastname, func_user_popularity(id) AS popularity 
FROM users
ORDER BY func_user_popularity(id) DESC;

<<<<<<< HEAD
/*выведем друзей пользователя 1, отранжировав их по популярности*/
=======
-- ������������� �������: ������� ������ ������������ 1, ������������ �� �� ������������
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
 *Добавим нового пользователя через транзакцию.
*/

START TRANSACTION; 
=======
 * ������� 3. ������� ������ ������������ ����� ����������.
*/

START TRANSACTION; -- ������ ����������
>>>>>>> main

INSERT INTO users (firstname, lastname, email, phone)
VALUES ('Transaction', 'User', 'new@mail.com', 89111234567);

INSERT INTO profiles (user_id, gender, birthday, city, country)
VALUES (last_insert_id(), 'm', '1999-10-10', 'Moscow', 'Russia');

<<<<<<< HEAD
-- ROLLBACK; -- 

COMMIT; 

/*Добавим нового пользователя через процедуру и транзакцию.*/
=======
-- ROLLBACK; -- ������ ����������, ����� ����� ��������� �� �����

COMMIT; -- �������� ���������� ����������, ���� ��������� ������ � users � profiles

/*
 * ������� 4. ������� ������ ������������ ����� ��������� � ����������.
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
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  -- ��������� ������
	BEGIN 
		SET tran_rollback = 1; -- ���� ������ exception ������ ������
		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT; -- �������� ��� ������ � ���������
		SET tran_result := CONCAT(code, ': ', error_string); -- �������� � ���������
	END;

	START TRANSACTION;  -- ��������� ���������� ���������� ������������
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
	IF tran_rollback  -- ���� ���� �������� ������ ���������� ���������
	THEN 
		ROLLBACK;
	ELSE
		SET tran_result := 'ok'; -- ���� ������������ ��������, ������� ��
		COMMIT; -- ������� ��������� ����������
>>>>>>> main
	END IF;
END//

DELIMITER ;

<<<<<<< HEAD

CALL sp_add_user('Transaction2', 'User2', 'new2@mail.com', 89303099090, 
				 'm', '1990-11-11',  'Moscow', 'Russia', @tran_result);
	
=======
-- �������� ���������
CALL sp_add_user('Transaction2', 'User2', 'new2@mail.com', 89303099090, 
				 'm', '1990-11-11',  'Moscow', 'Russia', @tran_result);
-- ������� ���������� ����������		
>>>>>>> main
SELECT @tran_result;

CALL sp_add_user('Transaction3', 'User3', 'new3@mail.com', 83303099090, 
				 'm', '1990-11-11',  'Moscow', 'Russia', @tran_result);
				
SELECT @tran_result;

<<<<<<< HEAD
/* Представление для вывода всех друзей пользователя.*/


=======
/*
 * ������� 5. ������������� ��� ������ ���� ������ ������������.
*/

-- �������������, ���������� ������ �������������
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

/*Вывести рекомендации друзей для пользователя без его друзей.*/
=======
 -- ������� �� ���������� �������������
SELECT * FROM view_friends;

 -- ������ ����� ������������ 1
SELECT friend_id, firstname, lastname 
FROM view_friends 
WHERE id = 1;

-- ������� �������������
-- DROP VIEW view_friends;

/*
 * ������� 6. ������� ������������ ������ ��� ������������ ��� ��� ������.
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
/*Создать триггер для контроля даты рождения пользователя.*/
=======
/*
 * ������� 7. ������� ������� ��� �������� ���� �������� ������������.
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
-- неудача с добавлением пользователя с днем рождения больше текущей даты
=======
-- ������� � ����������� ������������ � ���� �������� ������ ������� ����
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
=======
-- ������� � ����������� ���� �������� �� ������ ������� 
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

SELECT p2.user_id FROM profiles p1 -- �� ������ ������
	JOIN profiles p2 ON p1.city = p2.city  -- �������� ������������� p2 �� ���� �� ������, ��� � �������� ������������
	WHERE p1.user_id = for_user_id -- ������� � p1 ����� ��������� ������������
	AND p2.user_id != for_user_id -- ��������� ��������� ������������ �� p2   
	UNION -- ���������� ��� ��������� ����
	SELECT cu2.user_id FROM communities_users cu1 -- �� ������ ����������
	JOIN communities_users cu2 ON cu1.community_id = cu2.community_id -- �������� ������������� uc2 �� ��� �� ���������, ��� � �������� ������������
	WHERE cu1.user_id = for_user_id  -- ������� � uc1 ���������� ��������� ������������
	AND cu2.user_id != for_user_id -- ��������� ��������� ������������ �� uc2
	ORDER BY RAND() -- ����� ��������� ������
	LIMIT 3; -- ������� ������ 5 ������� �� ������������
>>>>>>> main
