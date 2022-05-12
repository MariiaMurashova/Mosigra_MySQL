/* Theme of the course work: database for the store "MosIgra".
 * In reality, in this store, in addition to board games, a lot of things are sold, but within the framework of this work, we will limit ourselves to games.
 * Create a database:
 */

DROP DATABASE IF EXISTS mosigra;

CREATE DATABASE mosigra;

-- Use Database:

USE mosigra;

SHOW tables;

/* Table #1: game directory. In addition to id, name, price, description,
 * also contains information about the category and the creator. */

CREATE TABLE games_catalog(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(150) NOT NULL UNIQUE,
	price DECIMAL(10, 2) NOT NULL,
	description TEXT NOT NULL,
	creator_id BIGINT UNSIGNED,
	category_id BIGINT UNSIGNED,
	INDEX (name),
	KEY (creator_id),
	KEY (category_id),
	FOREIGN KEY (creator_id) REFERENCES creators(id),
	FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Inserting values

INSERT INTO mosigra.games_catalog (id,name,price,description,creator_id,category_id)
	VALUES (1,'Monopoly',3690.0,'Hit. Do you want to buy St. Petersburg or Moscow?',1,3),
 	(2,'Manchkin',1990.0,'Your Empire rules the world',2,3),
 	(3,'Uno',790.0,'A game that can captivate anyone',5,3),
	(4,'Chelovechki',790.0,'Take a pie from the shelf',2,1),
 	(5,'Cluedo',2990.0,'Intrigue in a closed space',1,3),
 	(6,'Tabu',2990.0,'To explain objects with "forbidden" words',1,2),
	(7,'Imaginarium',1990.0,'Good game',3,3),
 	(8,'Evolution',1390.0,'Outlive everyone',4,3),
 	(9,'Jackal',550.0,'Take all the gold',4,3),
 	(10,'Barbie',1690.0,'You can be anyone!',3,1);

-- Table #2: game creators. Contains the id, name and country of the manufacturer.

CREATE TABLE creators(
	id SERIAL PRIMARY KEY,
	creator VARCHAR(150),
	country VARCHAR(130));

-- Inserting values

INSERT INTO mosigra.creators VALUES (1,'Hasbro','USA');
INSERT INTO mosigra.creators VALUES (2,'Hobby World','Russia');
INSERT INTO mosigra.creators VALUES (3,'Cosmodrome Games','Russia');
INSERT INTO mosigra.creators VALUES (4,'Pravil''nyye igry','Russia');
INSERT INTO mosigra.creators VALUES (5,'Mattel','USA');

/* Table #3: game categories.
 *As you know, table games can have different categories.
 * For example, for children, for large companies, for lovers.
 * This table contains the id and the category itself.
 */

CREATE TABLE categories(
	id SERIAL PRIMARY KEY,
	category VARCHAR(150));

-- Inserting values

INSERT INTO mosigra.categories (id,category)
	VALUES (1,'for kids'), (2,'for lovers'), (3,'for big company');

/* Table #4: directory with store addresses.
 * The site may contain information about which game is available in which store.
 * In order to display this information, we need a directory with store addresses and availability information.
 */

CREATE TABLE shops(
	id SERIAL PRIMARY KEY,
	address VARCHAR(300));

-- Inserting values

INSERT INTO mosigra.shops (id, address) VALUES 
(1,'Leningradsky prospect, 60'),
(2,'Kashirskoe shosse, 26'),
(3,'Rublevskoe highway, 62'),
(4,'Zemlyanoy Val, 27'),
(5,'Vavilova street, 3'),
(6,'Sushchevskaya street, 13-15'),
(7,'Altufevskoe highway, 24'),
(8,'Narodnaya street, 8'),
(9,'Profsoyuznaya street, 129A'),
(10,'Schelkovskoe highway, 75');

-- Table No. 5: table on the availability of games in stores (see description for Table No. 4)

CREATE TABLE availability(
	game_id BIGINT UNSIGNED,
	shop_id BIGINT UNSIGNED,
	available BOOLEAN DEFAULT TRUE,
	KEY (game_id),
	KEY (shop_id),
	FOREIGN KEY (game_id) REFERENCES games_catalog(id),
	FOREIGN KEY (shop_id) REFERENCES shops(id)
);

-- Inserting values

INSERT INTO mosigra.availability (game_id,shop_id)
	VALUES (1,3),(4,7), (5,9), (2,4), (9,1), (6,1), (8,10), (1,5), (7,7), (3,7);

-- Table No. 6: registered users.

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	nickname VARCHAR(145) NOT NULL UNIQUE,
	first_name VARCHAR(145) NOT NULL,
	last_name VARCHAR(145) NOT NULL,
	email VARCHAR(145) NOT NULL UNIQUE,
	phone CHAR(11) NOT NULL,
	country VARCHAR(145) NOT NULL,
	password_hash CHAR(65) DEFAULT NULL,
	gender ENUM('f', 'm', 'x') NOT NULL,
	birthday DATE NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOW()
	INDEX (phone),
	INDEX (email)
);

-- Inserting values

INSERT INTO mosigra.users (id,nickname,first_name,last_name,email,phone,country,gender,birthday)
	VALUES (1,'Olga1','Olga','Ivanova','Olga1@mail.ru','89456667788','Russia','f','1996-09-28');
INSERT INTO mosigra.users (id,nickname,first_name,last_name,email,phone,country,gender,birthday)
	VALUES (2,'Mariia','Mariia','Ivanova','Mariia@yandex.ru','89045633312','Russia','x','1992-05-03');
INSERT INTO mosigra.users (id,nickname,first_name,last_name,email,phone,country,gender,birthday)
	VALUES (3,'Alexander','Alexander','Mitrofanov','Alexander@mail.ru','89067879054','Estonia','m','1987-06-15');
INSERT INTO mosigra.users (id,nickname,first_name,last_name,email,phone,country,gender,birthday)
	VALUES (4,'Vladimir1','Vladimir','Oreshkin','Vladimir1@mail.ru','89234546777','Russia','m','1988-03-28');
INSERT INTO mosigra.users (id,nickname,first_name,last_name,email,phone,country,gender,birthday)
	VALUES (5,'Olga2','Olga','Stepanova','Olga2@gmail.com','89324546677','Russia','x','1995-05-02');
INSERT INTO mosigra.users (id,nickname,first_name,last_name,email,phone,country,gender,birthday)
	VALUES (6,'Olga3','Olga','Kolobkova','Olga3@mail.ru','89563334322','Russia','f','1977-09-03');
INSERT INTO mosigra.users (id,nickname,first_name,last_name,email,phone,country,gender,birthday)
	VALUES (7,'Elizaveta','Elizaveta','Ivanova','Elizaveta@yandex.ru','89096765444','Belarus','f','2000-05-04');
INSERT INTO mosigra.users (id,nickname,first_name,last_name,email,phone,country,gender,birthday)
	VALUES (8,'Alexey','Alexey','Kerbinov','Alexey@mail.ru','89998788877','Russia','x','1979-09-09');
INSERT INTO mosigra.users (id,nickname,first_name,last_name,email,phone,country,gender,birthday)
	VALUES (9,'Olga4','Olga','Kutuzova','Olga4@mail.ru','89054443433','Russia','f','2000-12-01');
INSERT INTO mosigra.users (id,nickname,first_name,last_name,email,phone,country,gender,birthday)
	VALUES (10,'Vladimir2','Vladimir','Silovinov','Vladimir2@mail.ru','89045657765','Estonia','m','2002-04-15');

/* Table #7: comments.
 * Registered users can leave comments on games.
 */

CREATE TABLE comments(
	id SERIAL PRIMARY KEY,
	comment TEXT NOT NULL,
	user_id BIGINT UNSIGNED,
	game_id BIGINT UNSIGNED,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	KEY (game_id),
	KEY (user_id),
	FOREIGN KEY (game_id) REFERENCES games_catalog(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Inserting values


INSERT INTO mosigra.comments (id,comment,user_id,game_id)
	VALUES (1,'Супер',1,2), (2,'Супер',7,4), (3,'Не понравилось',3,7), (4,'Не понравилось',10,2), (5,'Супер',8,6),
 (6,'Супер',1,2), (7,'Супер',2,3), (8,'Не понравилось',2,5), (9,'Супер',6,10), (10,'Не понравилось',2,1);

/* Table #8: photos added by users.
 * Let's say users can back up their comments with a photo
 */

CREATE TABLE users_photo(
	id SERIAL PRIMARY KEY,
	comment_id BIGINT UNSIGNED,
	file_name VARCHAR(255) COMMENT '/files/folder/img.png',
	file_size BIGINT UNSIGNED,
	KEY (comment_id),
	FOREIGN KEY (comment_id) REFERENCES comments(id));

-- Inserting values

INSERT INTO mosigra.users_photo (id,comment_id,file_name,file_size)
	VALUES (1,5,'photo1.png',576223050), (2,5,'photo2.png',799367827), 
	(3,1,'photo3.png',577582207), (4,10,'photo4.png',577582207), (5,2,'photo5.png',789367827);

/* Table #9: photos added by admin.
 * The games on the site have photos that are added by the store itself.
 */

CREATE TABLE admin_photo(
	id SERIAL PRIMARY KEY,
	game_id BIGINT UNSIGNED,
	file_name VARCHAR(255) COMMENT '/files/folder/img.png',
	file_size BIGINT UNSIGNED,
	KEY (game_id),
	FOREIGN KEY (game_id) REFERENCES games_catalog(id));

-- Inserting values

INSERT INTO mosigra.admin_photo (id,game_id,file_name,file_size)
	VALUES (1,1,'game1.png',435657899),
 	(2,2,'game2.png',434555767),
 	(3,3,'game3.png',546454667),
 	(4,4,'game4.png',576223050),
 	(5,5,'game5.png',765884355),
 	(6,6,'game6.png',654777897),
 	(7,7,'game7.png',545777321),
 	(8,8,'game8.png',434543333),
 	(9,9,'game9.png',566766888),
 	(10,10,'game10.png',433234222);

 /* Table #10: rating.
 * Let's say users can rate games.
 * Let the scores take values ​​from 0 to 5 (track this with a check)
 */
 
CREATE TABLE rating (
	id SERIAL PRIMARY KEY,
 	grade INT,
 	user_id BIGINT UNSIGNED,
 	game_id BIGINT UNSIGNED,
 	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 	KEY (game_id),
	FOREIGN KEY (game_id) REFERENCES games_catalog(id),
	KEY (user_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
 	CONSTRAINT check_grade CHECK 
    (grade >= 0 AND grade <= 5));
   
-- Inserting values

INSERT INTO mosigra.rating (id,grade,user_id,game_id)
	VALUES (1,5,1,1),
 	(2,4,3,5),
 	(3,5,9,8),
 	(4,3,5,2),
	(5,5,1,3),
 	(6,4,9,1),
 	(7,3,4,2),
	(8,5,1,8),
	(9,1,3,5),
 	(10,2,7,1);

	
 -- Some SQL operations
 
 -- 1. Count the average age of users in the table users

SELECT 
  birthday,
  AVG(
    (YEAR(CURRENT_DATE) - YEAR(birthday)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d')) 
  ) AS age
FROM users;

-- 2. Count russian users

SELECT COUNT(*) FROM users WHERE country = 'Russia';

-- 3. Determine who wrote the most comments / rated the game (total): men or women

SELECT gender FROM users WHERE 
id IN ((SELECT user_id FROM comments GROUP BY(user_id) 
ORDER BY COUNT(*) DESC) 
UNION 
(SELECT user_id FROM rating GROUP BY(user_id) 
ORDER BY COUNT(*) DESC))
GROUP BY(gender) ORDER BY COUNT(*) DESC;

-- 4. Select names of games from games-catalog и creators which manufactured games

SELECT gc.name, c.creator
FROM games_catalog AS gc
INNER JOIN creators AS c ON (gc.creator_id = c.id);

/* 5. Create a view that displays the name of the game fromgames_ catalog table
 * and address of the store where is information about the availability */

CREATE VIEW namewithaddresses (name, address) AS 
SELECT gc.name, s.address 
FROM 
games_catalog AS gc
JOIN 
availability AS a
ON gc.id = a.game_id
JOIN 
shops AS s
ON a.shop_id = s.id
WHERE available = 1;

SELECT * FROM namewithaddresses;

-- 6. Create a view that will show the average rating for games

CREATE VIEW sr_rating (name, sr_grade) AS 
SELECT gc.name, AVG(r.grade)
FROM 
games_catalog AS gc
JOIN 
rating AS r 
ON gc.id = r.game_id
GROUP BY name;

SELECT * FROM sr_rating;

/* 7. There are two text fields in the table products: name with the name of the game and description with its description.
 *Only both fields are allowed.
 *The situation when both fields take an undefined NULL value is unacceptable.
 *Using triggers, we will ensure that both fields are filled.
 *If you try to assign a NULL value to fields, you must cancel the operation. */

DELIMITER //

CREATE TRIGGER check_name_description BEFORE INSERT ON games_catalog 
FOR EACH ROW BEGIN
IF NEW.name IS NULL AND NEW.description IS NULL THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
END IF;
END//


