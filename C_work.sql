create DATABASE course_work;
USE course_work;


DROP table IF EXISTS books;
CREATE TABLE books (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(150) UNIQUE NOT NULL,
	author INT unsigned  NOT null,
	genre INT unsigned  NOT null,
	FOREIGN KEY (author) REFERENCES authors (id),
	FOREIGN KEY (genre) REFERENCES genres (id)
	);


DROP table IF EXISTS authors;
CREATE TABLE authors (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL 
	);

DROP table IF EXISTS genres;
CREATE TABLE genres (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL 
	);

DROP table IF EXISTS ratings;
CREATE TABLE ratings (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	grade INT unsigned NOT NULL, 
	CHECK (grade >0 and grade <6),
	to_book INT UNSIGNED NOT NULL,
	from_user INT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (to_book) REFERENCES books (id)
	);

DROP table IF EXISTS users;
CREATE TABLE users (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(150) NOT NULL,
	last_name VARCHAR(150) NOT NULL,
	email VARCHAR(150) UNIQUE NOT NULL,
	phone CHAR(11) UNIQUE NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE ratings
ADD FOREIGN KEY (from_user) REFERENCES users(id);

DROP table IF EXISTS rewievs;
CREATE TABLE rewievs (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	to_book INT UNSIGNED NOT NULL,
	from_user INT UNSIGNED NOT NULL,
	rewiev TEXT (350),
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (from_user) REFERENCES users(id)
	);
ALTER TABLE rewievs
ADD FOREIGN KEY (to_book) REFERENCES books (id);	

DROP table IF EXISTS descriptions;
CREATE TABLE descriptions (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	to_book INT UNSIGNED NOT NULL,
	description text (300),
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (to_book) REFERENCES books (id)
	);
	
DROP table IF exists storehouse;
CREATE TABLE storehouse (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	book INT UNSIGNED NOT NULL,
	number_book INT UNSIGNED NOT NULL,
	city varchar (50),
	FOREIGN KEY (book) REFERENCES books (id)
	);

DROP table IF exists orders;
CREATE TABLE orders (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	book INT UNSIGNED NOT NULL,
	from_user INT UNSIGNED NOT NULL,
	number_book INT UNSIGNED NOT NULL,
	price INT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (book) REFERENCES books (id),
	FOREIGN KEY (from_user) REFERENCES users (id)
	);

DROP table IF exists prices;
CREATE TABLE prices (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	book INT UNSIGNED NOT NULL,
	price DECIMAL(5,2) UNSIGNED NOT NULL,
	FOREIGN KEY (book) REFERENCES books (id)
	);
	
ALTER TABLE orders
ADD FOREIGN KEY (price) REFERENCES prices (id);	

ALTER TABLE prices ALTER COLUMN price decimal (10,2);

INSERT INTO genres VALUES
  (1,'story'),
  (2,'fairytall'),
  (3,'romantic'),
  (4,'fantastic'),
  (5,'poem'),
  (6,'life_story'),
  (7,'economic'),
  (8,'politic'),
  (9,'managment'),
  (10,'psychology');
 
SELECT*FROM genres g ;

INSERT INTO authors VALUES
<<<<<<< HEAD
  (1,'Steven Landsburgs'),
=======
  (1,'Steven Landsburg’s'),
>>>>>>> main
  (2,'Hans Christian Andersen'),
  (3,'E. L. James'),
  (4,'Candice Fox'),
  (5,'Claudia Rankine'),
  (6,'Phil Knight'),
  (7,'Ichak Kalderon Adizes'),
<<<<<<< HEAD
  (8,'Cue Steve RichardsÂ’s'),
=======
  (8,'Cue Steve Richards’s'),
>>>>>>> main
  (9,'Dan S. Kennedy'),
  (10,'Jonathan Haidt');
 
 SELECT*FROM authors a  ;
 

INSERT INTO users VALUES
(DEFAULT, 'Anton', 'Ivanov','anon@gmail.com','80291011111',default);

INSERT INTO users VALUES
(DEFAULT, 'Ivan', 'Ivanovs','ivan@gmail.com','80291022222',default),
(DEFAULT, 'Zhenia', 'Lyvala','lyvala@gmail.com','80445055555',default),
(DEFAULT, 'Kseniya', 'Michyrina','ksy@gmail.com','80291023365',default),
(DEFAULT, 'Artur', 'Misnik','misnik@gmail.com','80297045623',default),
(DEFAULT, 'Andrey', 'Karasew','karasew@gmail.com','80445656599',default),
(DEFAULT, 'Anatoliy', 'Minich','minich@gmail.com','80297074658',default),
(DEFAULT, 'Olga', 'Kryteva','o_kryteva@gmail.com','80296060606',default),
(DEFAULT, 'Irina', 'Levina','levina_i@gmail.com','80445123697',default),
(DEFAULT, 'Karolina', 'Manina','manina_kar@gmail.com','80447418523',default),
(DEFAULT, 'Dzmitriy', 'Pavlov','p_dzmitriy@gmail.com','80297894512',default),
(DEFAULT, 'Masha', 'Krishina','krishina@gmail.com','80291234569',default),
(DEFAULT, 'Anton', 'Pertov','petrov@gmail.com','80297412345',default),
(DEFAULT, 'Mikhail', 'Krasin','krasin_m@gmail.com','80294563125',default),
(DEFAULT, 'Kirill', 'Kirik','kirik_k@gmail.com','80336971458',default),
(DEFAULT, 'Vasiliy', 'Maksimow','maksimow@gmail.com','80331259513',default),
(DEFAULT, 'Viktor', 'Mikhalishin','vik_mik@gmail.com','80441234563',default),
(DEFAULT, 'Kirill', 'Zhariw','Zharivk@gmail.com','80441234785',default),
(DEFAULT, 'Lidia', 'Petrova','petrva_l@gmail.com','80446969699',default),
(DEFAULT, 'Masha', 'Miklyshina','m_miklys@gmail.com','80331242321',default),
(DEFAULT, 'Antonina', 'Varvarova','varvarova@gmail.com','80294122112',default),
(DEFAULT, 'Liliya', 'Sparish','sparish_l@gmail.com','80297088555',default);

SELECT *FROM users ;

INSERT  books VALUES 
(DEFAULT, 'The Armchair Economist', 1, 7);

INSERT  books VALUES 
(DEFAULT, 'Fairy Tales and Stories',2,2),
(DEFAULT, 'Fifty Shades of Grey',3,3),
(DEFAULT, 'The Chase', 4, 4),
(DEFAULT, 'Citizen: An American Lyric Paperback', 5, 5),
(DEFAULT, 'Shoe Dog: A Memoir by the Creator of Nike', 6, 6),
(DEFAULT, 'The Ideal Executive', 7, 7),
(DEFAULT, 'The Prime Ministers We Never Had', 8, 8),
(DEFAULT, 'No B.S. Ruthless Management of People and Profits: No Holds Barred, Kick Butt, Take-No-Prisoners Guide to Really Getting Rich', 9, 9),
(DEFAULT, 'The Happiness Hypothesis: Finding Modern Truth in Ancient Wisdom', 10, 10);

SELECT*FROM books b ;

INSERT INTO  descriptions VALUES
<<<<<<< HEAD
(DEFAULT,1,'Steven Landsburgs The Armchair Economist applies real-world situations to economic theory; think: why do celebrity endorsements sell products? Or, do government deficits matter, even why do women pay more at the dry cleaners. The revised edition of this book tackles all this and more, making the economic concepts that much more understandable.',default);
	
INSERT INTO  descriptions VALUES
(DEFAULT,3,'It became the first instalment in the Fifty Shades novel series that follows the deepening relationship between a college graduate, Anastasia Steele, and a young business magnate, Christian Grey. It is notable for its explicitly erotic scenes featuring elements of sexual practices involving BDSM (bondage/discipline, dominance/submission, and sadism/masochism).',default),
(DEFAULT,2,'Andersens tale Danish Popular Legends was first published in The Riverside Magazine for Young People, Vol. IV, pp. 470-474, New York, October 1870. It has never been published in Denmark. The hypertext is based on an etext found in the Andersen Homepage of the Danish National Literary Archive.',default),
(DEFAULT,4,'The Chase is a modern The Fugitive with characters only #1 New York Times and Globe and Mail bestselling author Candice Fox can write.',default),
(DEFAULT,5,'The New Yorker, Boston Globe, The Atlantic, BuzzFeed, NPR. Los Angeles Times, Publishers Weekly, Slate, Time Out New York, Vulture, Refinery 29, and many more.A provocative meditation on race, Claudia Rankine Dont Let Me Be Lonely: An American Lyric.',default),
(DEFAULT,6,'In this candid and riveting memoir, for the first time ever, Nike founder and CEO Phil Knight shares the inside story of the companys early days as an intrepid start-up and its evolution into one of the worlds most iconic, game-changing, and profitable brands.',default),
(DEFAULT,7,'Dr. Adizes premise, developed in this book, is that the ideal leader, manager, or executive-ideal in the sense that he can fulfill by himself all the roles necessary for the long-and short-term effectiveness and efficiency of an organization-does not and cannot exist.',default),
(DEFAULT,8,'A book stuffed full of roads less travelled. His list of politicians who were once widely tipped for Number 10, only to fall short in the end, ranges from Rab Butler to Neil Kinnock to Jeremy Corbyn and if the latter seems a surprise inclusion, then half the point of a list is arguing about who should or shouldnt have been on it',default),
(DEFAULT,9,'Here it is: no warm n fuzzies, no academic theories just hard-core strategies from real world trenches the long-overdue management book no one but Dan Kennedy would dare to write',default),
(DEFAULT,10,'A professor of social psychology, Jonathan Haidt wrote The Happiness Hypothesis as an accessible vessel for his research into moral foundations theory.In this book, Haidt takes the ancient wisdom, or Great Ideas, of historical thinkers  like Buddha, Plato, and even Jesus  and reveals their applications in light of contemporary psychological findings',default);
=======
(DEFAULT,1,'Steven Landsburg’s “The Armchair Economist” applies real-world situations to economic theory; think: why do celebrity endorsements sell products? Or, do government deficits matter, even why do women pay more at the dry cleaners. The revised edition of this book tackles all this and more, making the economic concepts that much more understandable.',default);
	
INSERT INTO  descriptions VALUES
(DEFAULT,3,'It became the first instalment in the Fifty Shades novel series that follows the deepening relationship between a college graduate, Anastasia Steele, and a young business magnate, Christian Grey. It is notable for its explicitly erotic scenes featuring elements of sexual practices involving BDSM (bondage/discipline, dominance/submission, and sadism/masochism).',default),
(DEFAULT,2,'Andersen’s tale “Danish Popular Legends” was first published in The Riverside Magazine for Young People, Vol. IV, pp. 470-474, New York, October 1870. It has never been published in Denmark. The hypertext is based on an etext found in the Andersen Homepage of the Danish National Literary Archive.',default),
(DEFAULT,4,'The Chase is a modern The Fugitive with characters only #1 New York Times and Globe and Mail bestselling author Candice Fox can write.',default),
(DEFAULT,5,'The New Yorker, Boston Globe, The Atlantic, BuzzFeed, NPR. Los Angeles Times, Publishers Weekly, Slate, Time Out New York, Vulture, Refinery 29, and many more.A provocative meditation on race, Claudia Rankine Dont Let Me Be Lonely: An American Lyric.',default),
(DEFAULT,6,'In this candid and riveting memoir, for the first time ever, Nike founder and CEO Phil Knight shares the inside story of the company’s early days as an intrepid start-up and its evolution into one of the world’s most iconic, game-changing, and profitable brands.',default),
(DEFAULT,7,'Dr. Adizes premise, developed in this book, is that the ideal leader, manager, or executive-ideal in the sense that he can fulfill by himself all the roles necessary for the long-and short-term effectiveness and efficiency of an organization-does not and cannot exist.',default),
(DEFAULT,8,'A book stuffed full of roads less travelled. His list of politicians who were once widely tipped for Number 10, only to fall short in the end, ranges from Rab Butler to Neil Kinnock to Jeremy Corbyn and if the latter seems a surprise inclusion, then half the point of a list is arguing about who should or shouldn’t have been on it',default),
(DEFAULT,9,'Here it is: no warm ‘n fuzzies, no academic theories—just hard-core strategies from real world trenches…the long-overdue management book no one but Dan Kennedy would dare to write',default),
(DEFAULT,10,'A professor of social psychology, Jonathan Haidt wrote The Happiness Hypothesis as an accessible vessel for his research into moral foundations theory.In this book, Haidt takes the ancient wisdom, or “Great Ideas”, of historical thinkers — like Buddha, Plato, and even Jesus — and reveals their applications in light of contemporary psychological findings',default);
>>>>>>> main
SELECT *FROM descriptions d ;

INSERT into  ratings VALUES 
(DEFAULT,5 ,1,1,default);

INSERT into  ratings VALUES 
(DEFAULT,4 ,2,4,default),
(DEFAULT,3 ,1,4,default),
(DEFAULT,2 ,4,2,default),
(DEFAULT,4 ,10,3,default),
(DEFAULT,2 ,8,5,default),
(DEFAULT,4 ,6,4,default),
(DEFAULT,3 ,6,6,default),
(DEFAULT,4 ,4,9,default),
(DEFAULT,5 ,4,8,default),
(DEFAULT,5 ,10,8,default),
(DEFAULT,5 ,7,10,default),
(DEFAULT,4 ,9,9,default),
(DEFAULT,4 ,9,7,default),
(DEFAULT,4 ,8,7,default),
(DEFAULT,3 ,4,6,default),
(DEFAULT,4 ,3,5,default),
(DEFAULT,5 ,7,4,default),
(DEFAULT,4 ,4,3,default),
(DEFAULT,3 ,2,2,default),
(DEFAULT,4 ,4,1,default),
(DEFAULT,5 ,6,10,default),
(DEFAULT,5 ,8,9,default),
(DEFAULT,3 ,8,8,default),
(DEFAULT,4,4,7,default),
(DEFAULT,4 ,5,6,default),
(DEFAULT,5 ,6,5,default),
(DEFAULT,5 ,7,4,default),
(DEFAULT,3 ,7,3,default),
(DEFAULT,4 ,9,2,default),
(DEFAULT,5 ,10,1,default);
SELECT*FROM ratings r ;

INSERT INTO rewievs VALUES
(DEFAULT,5 ,10,'Not bad',default);

INSERT INTO rewievs VALUES
(DEFAULT,1 ,1,'Not bad',default),
(DEFAULT,2 ,2,'So cool',default),
(DEFAULT,3 ,3,'One of the best',default),
(DEFAULT,4 ,4,'Want more',default),
(DEFAULT,6 ,5,'I hope it is not the end',default),
(DEFAULT,7 ,6,'Pretty story',default),
(DEFAULT,8 ,7,'Interesting book',default),
(DEFAULT,9 ,8,'Book about life',default),
(DEFAULT,10,9,'I hope it is help me',default),
(DEFAULT,1 ,10,'Not bad',default),
(DEFAULT,2 ,1,'Really, very bad',default),
(DEFAULT,3 ,2,'Interesting',default),
(DEFAULT,4 ,3,'Pretty story',default),
(DEFAULT,5 ,4,'Interesting book',default),
(DEFAULT,6 ,5,'Not bad',default),
(DEFAULT,7 ,6,'Want more',default),
(DEFAULT,8 ,7,'so cool',default),
(DEFAULT,9 ,8,'Not bad',default),
(DEFAULT,10 ,9,'Want more',default),
(DEFAULT,1,10,'I hope it is not the end',default),
(DEFAULT,2,1,'One of the best',default),
(DEFAULT,3 ,2,'Not bad',default),
(DEFAULT,4 ,3,'One of the best',default),
(DEFAULT,5 ,4,'Not bad',default),
(DEFAULT,6 ,5,'One of the best',default),
(DEFAULT,7 ,6,'Really, very good',default),
(DEFAULT,8 ,7,'Not bad',default),
(DEFAULT,9 ,8,'Really, very goog',default),
(DEFAULT,10 ,9,'Nice book',default),
(DEFAULT,1,10,'interesting story',default);

SELECT *FROM rewievs r ;

INSERT into storehouse VALUES 
(DEFAULT,1,10,'Minsk');

INSERT into storehouse VALUES 
(DEFAULT,2,3,'Minsk'),
(DEFAULT,3,4,'Minsk'),
(DEFAULT,4,10,'Minsk'),
(DEFAULT,5,12,'Minsk'),
(DEFAULT,6,15,'Minsk'),
(DEFAULT,7,3,'Minsk'),
(DEFAULT,8,16,'Minsk'),
(DEFAULT,9,8,'Minsk'),
(DEFAULT,10,2,'Minsk'),
(DEFAULT,1,10,'Grodno'),
(DEFAULT,2,1,'Grodno'),
(DEFAULT,3,3,'Grodno'),
(DEFAULT,4,7,'Grodno'),
(DEFAULT,5,2,'Grodno'),
(DEFAULT,6,0,'Grodno'),
(DEFAULT,7,6,'Grodno'),
(DEFAULT,8,0,'Grodno'),
(DEFAULT,9,4,'Grodno'),
(DEFAULT,10,3,'Grodno'),
(DEFAULT,1,0,'Vitebsk'),
(DEFAULT,2,0,'Vitebsk'),
(DEFAULT,3,0,'Vitebsk'),
(DEFAULT,4,0,'Vitebsk'),
(DEFAULT,5,0,'Vitebsk'),
(DEFAULT,6,7,'Vitebsk'),
(DEFAULT,7,7,'Vitebsk'),
(DEFAULT,8,2,'Vitebsk'),
(DEFAULT,9,15,'Vitebsk'),
(DEFAULT,10,6,'Vitebsk');
SELECT*FROM storehouse s ;

INSERT INTO prices VALUES
(DEFAULT, 1, '5.99');

INSERT INTO prices VALUES
(DEFAULT, 2, '18.99'),
(DEFAULT, 3, '20.99'),
(DEFAULT, 4, '35.99'),
(DEFAULT, 5, '25.99'),
(DEFAULT, 6, '15.99'),
(DEFAULT, 7, '13.99'),
(DEFAULT, 8, '38.99'),
(DEFAULT, 9, '45.99'),
(DEFAULT, 10, '36.99');
SELECT *FROM  prices ;

<<<<<<< HEAD
SELECT sum (price) FROM prices p ;
=======
SELECT sum(price) FROM prices p ;
>>>>>>> main



INSERT INTO authors VALUES
  (11,'Crystal Hubbard '),
  (13,' Abhijit V. Banerjee'),
  (14,'Imbolo Mbue'),
  (15,'Walter Isaacson'),
  (16,'Patty McCord'),
<<<<<<< HEAD
  (17,'Gavin Barwells'),
=======
  (17,'Gavin Barwell’s'),
>>>>>>> main
  (18,'Gavin Kennedy'),
  (19,'Jessi Beyer'),
  (12,'Maira Kalman');
 
 INSERT INTO authors VALUES
  (20,'Peter Schnall ');

 
 INSERT  books VALUES 
(DEFAULT, 'Catching the Moon: The Story of a Young Girls Baseball Dream',11,2),
(DEFAULT, 'Best Cerebral Pick: Good Economics for Hard Times',13,7),
(DEFAULT, 'How Beautiful We Were', 14,5),
(DEFAULT, 'Steve Jobs', 15,6),
(DEFAULT, 'Powerful: Building a Culture of Freedom and Responsibility', 16,8),
(DEFAULT, 'Chief of Staff ',  17,8),
(DEFAULT, 'Everything is Negotiable: How to Get the Best Deal Every Time', 18,9),
(DEFAULT, 'How To Heal', 19,10),
(DEFAULT, 'Lincoln@Gettysburg', 20,6),
(DEFAULT, 'Looking at Lincoln', 12,6);

SELECT *FROM books b  ;

INSERT INTO prices VALUES
(DEFAULT, 21, '28.99'),
(DEFAULT, 22, '12.99'),
(DEFAULT, 23, '35.99'),
(DEFAULT, 24, '25.99'),
(DEFAULT, 25, '15.99'),
(DEFAULT, 26, '13.99'),
(DEFAULT, 27, '38.99'),
(DEFAULT, 28, '45.99'),
(DEFAULT, 29, '36.99'),
(DEFAULT, 30, '45.99');

INSERT INTO rewievs VALUES
(DEFAULT,21 ,1,'Not bad',default),
(DEFAULT,22 ,2,'So cool',default),
(DEFAULT,23 ,3,'One of the best',default),
(DEFAULT,24 ,4,'Want more',default),
(DEFAULT,26 ,5,'I hope it is not the end',default),
(DEFAULT,27 ,6,'Pretty story',default),
(DEFAULT,28 ,7,'Interesting book',default),
(DEFAULT,29 ,8,'Book about life',default),
(DEFAULT,30,9,'I hope it is help me',default),
(DEFAULT,21 ,10,'Not bad',default),
(DEFAULT,22 ,1,'Really, very bad',default),
(DEFAULT,23 ,2,'Interesting',default),
(DEFAULT,24 ,3,'Pretty story',default),
(DEFAULT,25 ,4,'Interesting book',default),
(DEFAULT,26 ,5,'Not bad',default),
(DEFAULT,27 ,6,'Want more',default),
(DEFAULT,28 ,7,'so cool',default),
(DEFAULT,29 ,8,'Not bad',default),
(DEFAULT,30 ,9,'Want more',default),
(DEFAULT,21,10,'I hope it is not the end',default),
(DEFAULT,22,1,'One of the best',default),
(DEFAULT,23 ,2,'Not bad',default),
(DEFAULT,24 ,3,'One of the best',default),
(DEFAULT,25 ,4,'Not bad',default),
(DEFAULT,26 ,5,'One of the best',default),
(DEFAULT,27 ,6,'Really, very good',default),
(DEFAULT,28 ,7,'Not bad',default),
(DEFAULT,29 ,8,'Really, very goog',default),
(DEFAULT,30 ,9,'Nice book',default),
(DEFAULT,21,10,'interesting story',default);

INSERT into  ratings VALUES 
(DEFAULT,4 ,21,4,default),
(DEFAULT,3 ,22,4,default),
(DEFAULT,2 ,24,2,default),
(DEFAULT,4 ,30,3,default),
(DEFAULT,2 ,28,5,default),
(DEFAULT,4 ,26,4,default),
(DEFAULT,3 ,26,6,default),
(DEFAULT,4 ,24,9,default),
(DEFAULT,5 ,24,8,default),
(DEFAULT,5 ,30,8,default),
(DEFAULT,5 ,27,10,default),
(DEFAULT,4 ,29,9,default),
(DEFAULT,4 ,29,7,default),
(DEFAULT,4 ,28,7,default),
(DEFAULT,3 ,24,6,default),
(DEFAULT,4 ,23,5,default),
(DEFAULT,5 ,27,4,default),
(DEFAULT,4 ,24,3,default),
(DEFAULT,3 ,22,2,default),
(DEFAULT,4 ,24,1,default),
(DEFAULT,5 ,26,10,default),
(DEFAULT,5 ,28,9,default),
(DEFAULT,3 ,28,8,default),
(DEFAULT,4,24,7,default),
(DEFAULT,4 ,25,6,default),
(DEFAULT,5 ,26,5,default),
(DEFAULT,5 ,27,4,default),
(DEFAULT,3 ,27,3,default),
(DEFAULT,4 ,29,2,default),
(DEFAULT,5 ,30,1,default);

INSERT INTO  descriptions VALUES
<<<<<<< HEAD
(DEFAULT,22,'Ever wondered why economics, well, matters? MIT economists Abhijit V. Banerjee and Esther Duflo explain just that in their book, Good Economics for Hard Times.',default),
(DEFAULT,23,'Following her 2016 debut, Behold the Dreamers, Mbues sweeping and quietly devastating second novel begins in 1980 in the fictional African village of Kosawa, where representatives from an American oil company have come to meet with the locals, whose children are dying because of the environmental havoc (fallow fields, poisoned water) wreaked by its drilling and pipelines',default),
(DEFAULT,24,'Walter Isaacsons "enthralling" (The New Yorker) worldwide bestselling biography of Apple cofounder Steve Jobs',default),
(DEFAULT,25,'When it comes to recruiting, motivating, and creating great teams, Patty McCord says most companies have it all wrong.',default),
(DEFAULT,26,'Theresa May would probably love a copy, judging by Gavin Barwells Chief of Staff (Atlantic), a loyal and sensitive account of her attempts to extract something resembling a workable Brexit from the fantasies of the Tory right',default),
(DEFAULT,27,'Whether you need to ask for a raise at work, request a better hotel room while youre on holiday, or even debate with your stubborn teenager at home, you can learn effective and powerful negotiation skills to help you get the best deal every time',default),
(DEFAULT,28,'The National Council for Behavioral Health estimates that seven out of every ten people you know will experience a trauma during their lifetimes  perhaps even you. When that happens, though, what do you do? ',default),
=======
(DEFAULT,22,'Ever wondered why economics, well, matters? MIT economists Abhijit V. Banerjee and Esther Duflo explain just that in their book, “Good Economics for Hard Times.”',default),
(DEFAULT,23,'Following her 2016 debut, “Behold the Dreamers,” Mbue’s sweeping and quietly devastating second novel begins in 1980 in the fictional African village of Kosawa, where representatives from an American oil company have come to meet with the locals, whose children are dying because of the environmental havoc (fallow fields, poisoned water) wreaked by its drilling and pipelines',default),
(DEFAULT,24,'Walter Isaacsons "enthralling" (The New Yorker) worldwide bestselling biography of Apple cofounder Steve Jobs',default),
(DEFAULT,25,'When it comes to recruiting, motivating, and creating great teams, Patty McCord says most companies have it all wrong.',default),
(DEFAULT,26,'Theresa May would probably love a copy, judging by Gavin Barwell’s Chief of Staff (Atlantic), a loyal and sensitive account of her attempts to extract something resembling a workable Brexit from the fantasies of the Tory right',default),
(DEFAULT,27,'Whether you need to ask for a raise at work, request a better hotel room while you’re on holiday, or even debate with your stubborn teenager at home, you can learn effective and powerful negotiation skills to help you get the best deal every time',default),
(DEFAULT,28,'The National Council for Behavioral Health estimates that seven out of every ten people you know will experience a trauma during their lifetimes – perhaps even you. When that happens, though, what do you do? ',default),
>>>>>>> main
(DEFAULT,29,'From PBS - Braids together the stories behind Lincolns appearance at Gettysburg, his speech that day, and its dissemination to explore Lincolns roles as military commander, chief executive, and minister to a wounded and grieving people.',default),
(DEFAULT,30,'Fans of Who Was? and Jean Fritz will love this introduction to our sixteenth President by beloved author and illustrator Maira Kalman.',default),
(DEFAULT,21,'Now in paperback, the true story of Marcenia Lyle, an African American girl who grew up to become "Toni Stone," the first woman to play for a professional baseball team',default);
SELECT *FROM descriptions d ;

INSERT into storehouse VALUES 
(DEFAULT,22,3,'Minsk'),
(DEFAULT,23,4,'Minsk'),
(DEFAULT,24,10,'Minsk'),
(DEFAULT,25,12,'Minsk'),
(DEFAULT,26,15,'Minsk'),
(DEFAULT,27,3,'Minsk'),
(DEFAULT,28,16,'Minsk'),
(DEFAULT,29,8,'Minsk'),
(DEFAULT,30,2,'Minsk'),
(DEFAULT,21,10,'Grodno'),
(DEFAULT,22,1,'Grodno'),
(DEFAULT,23,3,'Grodno'),
(DEFAULT,24,7,'Grodno'),
(DEFAULT,25,2,'Grodno'),
(DEFAULT,26,0,'Grodno'),
(DEFAULT,27,6,'Grodno'),
(DEFAULT,28,0,'Grodno'),
(DEFAULT,29,4,'Grodno'),
(DEFAULT,30,3,'Grodno'),
(DEFAULT,21,0,'Vitebsk'),
(DEFAULT,22,0,'Vitebsk'),
(DEFAULT,23,0,'Vitebsk'),
(DEFAULT,24,0,'Vitebsk'),
(DEFAULT,25,0,'Vitebsk'),
(DEFAULT,26,7,'Vitebsk'),
(DEFAULT,27,7,'Vitebsk'),
(DEFAULT,28,2,'Vitebsk'),
(DEFAULT,29,15,'Vitebsk'),
(DEFAULT,30,6,'Vitebsk');
SELECT*FROM storehouse s ;

INSERT INTO orders VALUES
(DEFAULT, 1,4,1,1,default);
INSERT INTO orders VALUES
(DEFAULT, 4,3,1,4,default),
(DEFAULT, 7,2,1,7,default),
(DEFAULT, 5,1,1,5,default),
(DEFAULT, 10,4,1,10,default),
(DEFAULT, 6,5,1,6,default),
(DEFAULT, 6,5,1,6,default),
(DEFAULT, 8,9,1,8,default),
(DEFAULT, 9,9,1,9,default),
(DEFAULT, 21,6,1,33,default),
(DEFAULT, 22,1,1,34,default),
(DEFAULT, 21,22,1,33,default),
(DEFAULT, 1,7,1,1,default),
(DEFAULT, 1,7,1,1,default),
(DEFAULT, 8,1,1,8,default),
(DEFAULT, 3,3,1,3,default),
(DEFAULT, 3,6,1,3,default),
(DEFAULT, 7,22,1,7,default),
(DEFAULT, 9,7,1,9,default),
(DEFAULT, 1,9,1,1,default),
(DEFAULT, 1,8,1,1,default);
SELECT*FROM prices p ;

<<<<<<< HEAD
SELECT r.to_book, COUNT (r.rewiev) FROM rewievs r /* ÃªÃ®Ã«-Ã¢Ã® Ã®Ã²Ã§Ã»Ã¢Ã®Ã¢ Ã¤Ã«Ã¿ ÃªÃ­Ã¨Ã£Ã¨*/
GROUP BY r.to_book 
ORDER BY r.to_book ;

SELECT r.from_user r, COUNT (r.rewiev) FROM rewievs r /* ÃªÃ®Ã«-Ã¢Ã® Ã®Ã²Ã§Ã»Ã¢Ã®Ã¢ Ã®Ã² Ã¯Ã®Ã«Ã¼Ã§Ã®Ã¢Ã Ã²Ã¥Ã«Ã¥Ã©*/
=======
SELECT r.to_book, COUNT(r.rewiev) FROM rewievs r /* êîë-âî îòçûâîâ äëÿ êíèãè*/
GROUP BY r.to_book 
ORDER BY r.to_book ;

SELECT r.from_user r, COUNT(r.rewiev) FROM rewievs r /* êîë-âî îòçûâîâ îò ïîëüçîâàòåëåé*/
>>>>>>> main
GROUP BY r.from_user 
ORDER BY r.from_user ;


<<<<<<< HEAD
/*ÐŸÐ¾Ð´ÑÑ‡ÐµÑ‚ Ñ€ÐµÐ¹Ñ‚Ð¸Ð½Ð³Ð° Ð¿Ð¾ ÐºÐ½Ð¸Ð³Ð°Ð¼*/
=======
/*Ïîäñ÷åò ðåéòèíãà ïî êíèãàì*/
>>>>>>> main
SELECT avg (grade) AS Rating_book, b.name AS Book_name, a.name AS Autor_book  
FROM ratings r
JOIN books b 
ON r.to_book = b.id
JOIN authors a  
ON  b.author =a.id 
GROUP BY r.to_book;



<<<<<<< HEAD
/* Ð’Ð»Ð¾Ð¶ÐµÐ½Ð½Ñ‹Ð¹ Ð·Ð°Ð¿Ñ€Ð¾Ñ: Ð¿Ð¾Ð»ÑŒÐ·Ð¾Ð²Ð°Ñ‚ÐµÐ»ÑŒ, ÐºÐ¾Ñ‚Ð¾Ñ€Ñ‹Ð¹ Ð¾ÑÑ‚Ð°Ð²Ð¸Ð» Ð¼Ð°ÐºÑ ÐºÐ¾Ð»-Ð²Ð¾ reviews*/
SELECT *FROM rewievs r;

SELECT r.from_user, concat (u.first_name,' ',u.last_name) AS name_user, count(*) AS number_rewievs 
=======
/* Âëîæåííûé çàïðîñ: ïîëüçîâàòåëü, êîòîðûé îñòàâèë ìàêñ êîë-âî reviews*/
SELECT *FROM rewievs r;

SELECT r.from_user, concat(u.first_name,' ',u.last_name) AS name_user, count(*) AS number_rewievs 
>>>>>>> main
FROM rewievs r
JOIN users u 
ON r.from_user =u.id 
GROUP BY from_user 
ORDER BY from_user DESC;

SELECT 
<<<<<<< HEAD
	(SELECT concat (u.first_name,' ',u.last_name) FROM users u WHERE u.id = ms.from_user) AS U_name
=======
	(SELECT concat(u.first_name,' ',u.last_name) FROM users u WHERE u.id = ms.from_user) AS U_name
>>>>>>> main
FROM ( 	
		SELECT 
			r.from_user, count(*) AS CNT
	    FROM 
	    	rewievs r 
	    GROUP BY 
	    	r.from_user
	 ) MS
ORDER BY 
	ms.cnt desc
LIMIT 1
;

<<<<<<< HEAD
/* Ð¿ÐµÑ€ÐµÐ¼ÐµÐ½Ð½Ð°Ñ*/
=======
/* ïåðåìåííàÿ*/
>>>>>>> main
SELECT @number_rewievs := from_user AS U_name, count(*) AS Summary
FROM rewievs r 
GROUP BY from_user ; 


<<<<<<< HEAD
/* ÐŸÑ€ÐµÐ´ÑÑ‚Ð°Ð²Ð»ÐµÐ½Ð¸Ðµ Ð´Ð»Ñ Ñ€Ð¹Ñ‚Ð¸Ð½Ð³Ð° Ð¿Ð¾ ÐºÐ½Ð¸Ð³Ð°Ð¼*/
=======
/* Ïðåäñòàâëåíèå äëÿ ðéòèíãà ïî êíèãàì*/
>>>>>>> main
CREATE VIEW Rating_book_NOW
AS
SELECT avg (grade) AS Rating_book, b.name AS Book_name, a.name AS Autor_book  
FROM ratings r
JOIN books b 
ON r.to_book = b.id
JOIN authors a  
ON  b.author =a.id 
GROUP BY r.to_book;

SELECT *FROM  Rating_book_NOW;

<<<<<<< HEAD
/*Ð¿ÐµÑ€ÐµÐ¼ÐµÐ½Ð½Ð°Ñ*/
SELECT @price := MAX (price) FROM prices p ;
=======
/*ïåðåìåííàÿ*/
SELECT @price := MAX(price) FROM prices p ;
>>>>>>> main

SELECT p.book, b.name, p.price FROM prices p  
JOIN books b 
ON p.book=b.id 
WHERE price = @price;


<<<<<<< HEAD
/*Ñ„ÑƒÐ½ÐºÑ†Ð¸Ñ Ð¿Ñ€Ð¸Ð²ÐµÑ‚ÑnÐ²Ð¸Ðµ Ð¿Ñ€Ð¸ Ð²Ñ…Ð¾Ð´Ðµ*/

delimiter //
SELECT now (), HOUR (now ()) //
=======
/*ôóíêöèÿ ïðèâåòñnâèå ïðè âõîäå*/

delimiter //
SELECT now(), HOUR (now()) //
>>>>>>> main

DROP FUNCTION IF EXISTS hello;

delimiter //
CREATE FUNCTION hello ()
RETURNS tinytext 
DETERMINISTIC
BEGIN
	DECLARE HOUR int; 
<<<<<<< HEAD
	SET HOUR = HOUR(now ());
=======
	SET HOUR = HOUR(now());
>>>>>>> main
	CASE
	WHEN HOUR BETWEEN 0 AND 5
		THEN 
		RETURN "good night";
	WHEN HOUR BETWEEN 6 AND 11
		THEN 
		RETURN "good morning";
	WHEN HOUR BETWEEN 12 AND 17
		THEN 
		RETURN "good day";
	WHEN HOUR BETWEEN 17 AND 23
		THEN 
		RETURN "good evening";
END CASE;
END//

SELECT hello ();

<<<<<<< HEAD
/*Ñ‚Ñ€Ð°Ð½Ð·Ð°ÐºÑ†Ð¸Ñ Ð½Ð° Ð·Ð°ÐºÐ°Ð·*/
=======
/*òðàíçàêöèÿ íà çàêàç*/
>>>>>>> main
SELECT s.number_book, s.city  FROM storehouse s  WHERE s.book = 1 AND s.city = 'Minsk' ;
select o.number_book  FROM orders o  WHERE o.from_user = 4;

START TRANSACTION;
UPDATE orders o SET o.number_book = o.number_book + 1 WHERE o.from_user = 4;
UPDATE storehouse s SET s.number_book = s.number_book -1 WHERE city = 'Minsk';
COMMIT;

<<<<<<< HEAD
/*Ñ‚Ñ€Ð¸Ð³Ð³ÐµÑ€ Ð½Ð° Ð´Ð¾Ð±Ð²Ð»ÐµÐ½Ð¸Ðµ Ð¾ÑˆÐ¸Ð±ÐºÐ¸ Ð² Ð·Ð°ÐºÐ°Ð·, ÐµÑÐ»Ð¸ ÐºÐ¾Ð»-Ð²Ð¾ Ð¼ÐµÐ½ÑŒÑˆÐµ 1 ÑˆÑ‚*/
=======
/*òðèããåð íà äîáâëåíèå îøèáêè â çàêàç, åñëè êîë-âî ìåíüøå 1 øò*/
>>>>>>> main

DELIMITER //
CREATE TRIGGER check_order_before_update BEFORE UPDATE ON orders 
FOR EACH ROW 
BEGIN 
	IF NEW.number_book  <1  THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Number of books ';
	END IF;
END//

DELIMITER ;

 DROP TRIGGER check_order_before_update;

UPDATE orders  SET number_book  = '0' WHERE id = 21;

INSERT INTO orders VALUES
(DEFAULT, 5,2,0,5,default);

<<<<<<< HEAD
/*Ð²Ñ‹Ð²Ð¾Ð´ Ñ€ÐµÐºÐ¾Ð¼ÐµÐ½Ð´Ð°Ñ†Ð¸Ð¹ ÐºÐ½Ð¸Ð³ Ð¿Ð¾ Ð¶Ð°Ð½Ñ€Ð°Ð¼*/
=======
/*âûâîä ðåêîìåíäàöèé êíèã ïî æàíðàì*/
>>>>>>> main
SELECT b.name FROM books b
WHERE b.genre = (SELECT DISTINCT g.id  FROM orders o 
JOIN   books b 
ON o.book =b.id
JOIN   genres g
ON b.genre=g.id
WHERE o.from_user =5)
ORDER BY RAND() 
	LIMIT 2;


<<<<<<< HEAD
/* Ð¿Ñ€Ð¾Ñ†ÐµÐ´ÑƒÑ€Ð°*/
=======
/* ïðîöåäóðà*/
>>>>>>> main

DELIMITER //
CREATE PROCEDURE show_books (IN name INT UNSIGNED)
BEGIN
	SELECT b.name FROM books b
WHERE b.genre = (SELECT DISTINCT g.id  FROM orders o 
JOIN   books b 
ON o.book =b.id
JOIN   genres g
ON b.genre=g.id
WHERE o.from_user =5)
<<<<<<< HEAD
ORDER BY RAND () 
=======
ORDER BY RAND() 
>>>>>>> main
	LIMIT 2;
END// 


CALL show_books;
