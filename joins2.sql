/* Практическое задание #7. */

/* Типы JOIN */
/* Выведем имя и фамилию администраторов сообществ. */

SELECT firstname, lastname 
FROM users 
JOIN communities 
ON users.id = communities.admin_id;

/* LEFT JOIN */
/* Вывести всех пользователей и сообщества, где они создатели, если такие есть. */

SELECT users.firstname, users.lastname, communities.name 
FROM users 
LEFT JOIN communities 
ON users.id = communities.admin_id;

/* LEFT JOIN, только без совпадений. */ 
/* Вывести пользователей, которые не создавали сообщества. */

SELECT users.firstname, users.lastname, communities.name 
FROM users 
LEFT JOIN communities 
ON users.id = communities.admin_id
WHERE communities.name IS NULL;

/* RIGHT JOIN */
SELECT * FROM communities;

ALTER TABLE communities MODIFY admin_id BIGINT UNSIGNED;

INSERT INTO communities (name, description) 
VALUES 
('community_name', 'i have no admin');

/* Выводим все сообщества и имена администраторов (если администратор есть) с помощью LEFT JOIN */
SELECT communities.name, users.firstname, users.lastname 
FROM communities 
LEFT JOIN users 
ON communities.admin_id = users.id;


/* Аналогично предыдцщему запросу, но с помощью RIGHT JOIN */
SELECT communities.name, users.firstname, users.lastname 
FROM users 
RIGHT JOIN communities 
ON users.id = communities.admin_id;

SELECT communities.name, users.firstname, users.lastname 
FROM users 
RIGHT JOIN communities 
ON users.id = communities.admin_id 
WHERE users.id IS NULL;

/* FULL OUTER JOIN */
/* Выводим полный список пользователей (даже если у них нет сообщества) и сообществ (даже если у них нет администратора) */

SELECT lastname, firstname, name 
FROM users 
LEFT JOIN communities 
ON users.id = communities.admin_id
UNION
SELECT lastname, firstname, name 
FROM users 
RIGHT JOIN communities 
ON users.id = communities.admin_id;

/* FULL OUTER JOIN, только без совпадений. */
/* Выводим список из пользователей, которых нет сообществ, и сообществ без администратора */
SELECT lastname, firstname, name 
FROM users 
LEFT JOIN communities 
ON users.id = communities.admin_id
WHERE communities.id IS NULL
UNION
SELECT lastname, firstname, name 
FROM users 
RIGHT JOIN communities 
ON users.id = communities.admin_id
WHERE users.id IS NULL;

/* CROSS JOIN */
SELECT * 
FROM users 
JOIN communities;


SELECT * 
FROM users, communities;

/* Задание 1. Выводим данные пользователя: фамилию, имя, дату рождения, пол. */

SELECT firstname, lastname, birthday, gender 
FROM users 
JOIN profiles 
ON users.id = profiles.user_id; 

/* Задание 2. Выводим данные пользователя с красивым полом и возрастом. */

SELECT 
	u.firstname, 
	u.lastname, 
	TIMESTAMPDIFF(YEAR, p.birthday, NOW()) AS age,
	CASE p.gender 
		WHEN 'f' THEN 'female'
		WHEN 'm' THEN 'male'
		WHEN 'x' THEN 'not defined'
	END AS gender
FROM users AS u 
JOIN profiles AS p 
ON u.id = p.user_id;

/* Задание 3. Выводим все медифайлы пользователей. */

SELECT firstname, lastname, file_name, file_size 
FROM users u 
JOIN media m
ON u.id = m.user_id;


SELECT firstname, lastname, file_name, file_size 
FROM users u 
JOIN media m
ON u.id = m.user_id 
WHERE u.id = 2;

/* Задание 6. Выводим изображения пользователей. 'image' */

SELECT u.firstname, u.lastname, m.file_name, m.file_size, mt.name  
FROM users u 
JOIN media m 
ON u.id = m.user_id
JOIN media_types mt 
ON m.media_types_id = mt.id
WHERE mt.name = 'image';

/* Задание 7. Выводим все сообщения, которые ОТПРАВИЛ пользователь с email = greenfelder.antwan@example.org. */

SELECT from_user_id, to_user_id, txt  
FROM messages m 
JOIN users u 
ON m.from_user_id = u.id
WHERE email = 'greenfelder.antwan@example.org';

/* Выводим все сообщения, которые ПОЛУЧИЛ пользователь с email = greenfelder.antwan@example.org. */
SELECT from_user_id, to_user_id, txt 
FROM messages m 
JOIN users u 
ON m.to_user_id = u.id
WHERE email = 'greenfelder.antwan@example.org';

/* Задание 8. Выводим все сообщения (отправленные и полученные) пользователя с email = greenfelder.antwan@example.org. */

SELECT from_user_id, to_user_id, txt, m.created_at 
FROM messages m 
JOIN users u 
ON m.from_user_id = u.id 
OR m.to_user_id = u.id 
WHERE email = 'greenfelder.antwan@example.org'
ORDER BY m.created_at DESC;

/* Задание 9. Выводим все сообщения пользователя с email = greenfelder.antwan@example.org c именем получателя. */
SELECT from_user.firstname, from_user.lastname, m.txt, m.created_at, to_user.firstname, to_user.lastname 
FROM messages m
JOIN users AS from_user 
ON m.from_user_id = from_user.id 
JOIN users AS to_user ON m.to_user_id = to_user.id
WHERE from_user.email = 'greenfelder.antwan@example.org' OR to_user.email = 'greenfelder.antwan@example.org'
ORDER BY m.created_at DESC;

/* Задание 10. Выводим диалог между пользователями с id = 1 и id = 2. */

SELECT 
	u1.firstname, u1.lastname,
	m.txt, m.created_at,
	u2.firstname, u2.lastname  
FROM messages m
JOIN users u1 
	ON m.from_user_id = u1.id 
JOIN users u2 
	ON m.to_user_id = u2.id 
		WHERE from_user_id = 1 
			AND to_user_id = 2 
				OR from_user_id = 2 
				AND to_user_id = 1
ORDER BY m.created_at DESC;

/* Задание 11. Выводим количество друзей для каждого подьзователя. */

SELECT u.id, u.lastname, u.firstname, COUNT(*) AS total_friends FROM users u 
JOIN friend_requests fr ON fr.from_user_id = u.id OR fr.to_user_id = u.id
WHERE request_type = 1
GROUP BY u.id, u.lastname, u.firstname
ORDER BY u.id;

/* Задание 12. Выводим пользователей с количеством друзей больше 5. */
SELECT u.id, u.lastname, u.firstname, COUNT(*) AS total_friends FROM users u 
JOIN friend_requests fr ON fr.from_user_id = u.id OR fr.to_user_id = u.id
JOIN friend_requests_types frt ON fr.request_type = frt.id 
WHERE frt.name = 'accepted'
GROUP BY u.id
HAVING total_friends > 5;


/* Задание 13. Выводим все посты пользователя с email = greenfelder.antwan@example.org с количеством лайков. */

SELECT p.id, p.txt, COUNT(*) AS total_likes FROM posts p 
JOIN posts_likes pl ON p.id = pl.post_id
JOIN users u ON u.id = p.user_id
WHERE u.email = 'greenfelder.antwan@example.org' AND pl.like_type = 1
GROUP BY p.id;

/* Задание 14. Выводим имена всех друзей пользователя с id = 1. */

SELECT CONCAT(u.firstname, ' ', u.lastname) AS friend_name FROM friend_requests fr 
JOIN users u ON fr.from_user_id = u.id OR fr.to_user_id = u.id 
JOIN friend_requests_types frt ON fr.request_type = frt.id 
WHERE (fr.from_user_id = 1 OR fr.to_user_id = 1) AND frt.name = 'accepted' AND u.id != 1;


/*Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
который больше всех общался с выбранным пользователем (написал ему сообщений).*/


SELECT 
m.from_user_id, m.to_user_id, count(*) AS 'количество'
FROM messages m
JOIN users u 
ON  m.to_user_id  =u.id  
WHERE email ='linwood.medhurst@example.org'
GROUP BY m.from_user_id;



/*Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..*/
 
SELECT sum(MS.total_likes)
FROM (
SELECT 
pl.user_id, count(*) AS total_likes
FROM posts_likes pl 
JOIN profiles p 
ON p.user_id =pl.user_id
WHERE pl.like_type =1 AND ( TIMESTAMPDIFF (YEAR, p.birthday, NOW())<10)
GROUP BY p.user_id) MS ;




/*Определить кто больше поставил лайков (всего): мужчины или женщины.*/
SELECT 
	pl.post_id 
	, pl.user_id
	, p1.gender AS man
	, p2.gender AS female  
FROM 
	posts_likes pl 
		LEFT JOIN profiles p1 ON p1.user_id =pl.user_id AND p1.gender ='m'
		LEFT JOIN profiles p2 ON p2.user_id =pl.user_id AND p2.gender ='f'
WHERE 
	pl.like_type =1 
;

/*Определить кто больше поставил лайков (всего): мужчины или женщины.*/
SELECT ttt.gender, max(cnt)
FROM (
		SELECT 
			/*pl.post_id 
			, pl.user_id*/
			p1.gender
			, count(*) AS cnt
		FROM 
			posts_likes pl 
			JOIN profiles p1 ON p1.user_id = pl.user_id
		WHERE 
			pl.like_type = 1 
		AND p1.gender <> 'x'
		GROUP BY 
			p1.gender
		ORDER BY cnt DESC) ttt;
;



