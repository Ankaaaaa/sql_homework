-- Таблица типов лайков
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Заполняем лайки
INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 100)), 
    FLOOR(1 + (RAND() * 100)),
    FLOOR(1 + (RAND() * 4)),
    CURRENT_TIMESTAMP 
  FROM messages;
  
  -- Проверим
SELECT * FROM likes LIMIT 10;

CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');

SELECT * FROM target_types LIMIT 10;


-- Создадим таблицу постов

CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  is_public BOOLEAN DEFAULT TRUE,
  is_archived BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Заполняем посты
INSERT INTO posts
SELECT 
  user_id,
  FLOOR(1+RAND() *100),
  FLOOR(1+RAND() *20),
  city,
  country,
  FLOOR(1+RAND() *100),
  0,
  0,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
  FROM profiles;
  
SELECT * FROM posts;

-- создаем ключи !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
      
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);
    
ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id);
    
ALTER TABLE communities
  ADD CONSTRAINT communities_owner_id_fk 
    FOREIGN KEY (owner_id) REFERENCES users(id);
    

ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT communities_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
    
 ALTER TABLE media
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE;   
ALTER TABLE media
  ADD CONSTRAINT media_media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
    ON DELETE CASCADE; 
    
ALTER TABLE posts
  ADD CONSTRAINT posts_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
     ON DELETE CASCADE,
  ADD CONSTRAINT posts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
     ON DELETE CASCADE,
  ADD CONSTRAINT posts_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id)
     ON DELETE CASCADE;
     
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE,    
 ADD CONSTRAINT likes_target_type_id_fk 
    FOREIGN KEY (target_type_id) REFERENCES target_types(id)
    ON DELETE CASCADE;
    
    
-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT 
(SELECT COUNT(user_id) FROM likes WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'F')) AS woman,
(SELECT COUNT(user_id) FROM likes WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'M')) AS man;

-- 4. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).
SELECT COUNT(id) AS total FROM likes 
WHERE user_id IN (SELECT * FROM (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) AS total);


-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- выводим 10 пользователей которые меньше всего отправили сообщений и не поставили ни одного лайка и не имеют ни одного медиа
SELECT from_user_id FROM messages 
WHERE from_user_id NOT IN (SELECT *FROM (SELECT user_id FROM likes)AS tt) 
AND from_user_id NOT IN (SELECT *FROM (SELECT user_id FROM media)AS t) 
GROUP BY from_user_id ORDER BY COUNT(id) LIMIT 10;
-- проверяем
SELECT id FROM likes WHERE user_id = 24;
SELECT id FROM media WHERE user_id = 24;




 


SELECT filename FROM media
  WHERE user_id = 7
    AND media_type_id = (
      SELECT id FROM media_types WHERE name = 'image'
    );
  
  
  
  

-- -----------------------------------------------------------------------------------------------------------------------------

USE vk;
-- users ----------------------------------------------
SELECT * FROM users;
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;


-- users ----------------------------------------------
SELECT * FROM profiles;
UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at;


-- messages ---------------------------------------------- 
SELECT * FROM messages;
-- перемещиваем пользователей
UPDATE messages SET
	from_user_id = FLOOR(1+RAND() *100),
    to_user_id = FLOOR(1+RAND() *100);
    
-- заполняем стобец доставки   
CREATE TEMPORARY TABLE ext (name VARCHAR(12));
INSERT INTO ext VALUES ('доставлено'),('прочитано'),('ошибка'); 
SELECT * FROM ext;
ALTER TABLE messages MODIFY COLUMN is_delivered ENUM('доставлено','прочитано','ошибка');   
UPDATE messages SET is_delivered = (SELECT name FROM ext ORDER BY RAND() LIMIT 1);

-- заполняем стобец важно
CREATE TEMPORARY TABLE exte (name VARCHAR(12));
INSERT INTO exte VALUES ('!'),('~'); 
SELECT * FROM exte;
ALTER TABLE messages MODIFY COLUMN is_important ENUM('!','~');   
UPDATE messages SET is_important = (SELECT name FROM exte ORDER BY RAND() LIMIT 1);
    
    
    
-- media ----------------------------------------------   
SELECT * FROM media;
-- перемещиваем пользователей
UPDATE media SET
	user_id = FLOOR(1+RAND() *100);
    
-- правим даты
UPDATE media SET updated_at = NOW() WHERE updated_at < created_at;
-- заполняем ссылку
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));
INSERT INTO extensions VALUES ('avi'),('png'),('mp3'),('mpeg4');
SELECT * FROM extensions;
UPDATE media SET filename = CONCAT(
  'http://dropbox.net/vk/',
  (SELECT first_name FROM users ORDER BY RAND() LIMIT 1),
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);
-- коректируем размер файлов
UPDATE media SET size = FLOOR(10000 +RAND () *1000000) WHERE size <10000;
-- вносим данные в метаданные
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');
-- перемешиваем 
UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);
   
  
-- media_types ----------------------------------------------   
SELECT * FROM media_types; 
TRUNCATE media_types;
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;

-- friendship ----------------------------------------------  	
SELECT * FROM friendship;
-- перемещиваем пользователей
UPDATE friendship SET
	user_id = FLOOR(1+RAND() *100),
    friend_id = FLOOR(1+RAND() *100);
    
ALTER TABLE friendship DROP COLUMN requested_at;

UPDATE friendship SET updated_at = NOW() WHERE updated_at < created_at;

-- communities ---------------------------------------------- 
SELECT * FROM communities;  
DELETE FROM communities WHERE id > 20;  
UPDATE communities SET owner_id = FLOOR(1 + RAND() * 100); 

-- communities_users ---------------------------------------------- 
SELECT * FROM communities_users;  
UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 20);





DROP DATABASE vk;
CREATE DATABASE vk;
USE vk;

-- Создаём таблицу пользователей
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";  

-- Таблица профилей
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
  gender ENUM('M', 'F'),
  birthday DATE COMMENT "Дата рождения",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили"; 

-- Таблица сообщений
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  is_important ENUM('!','~'),
  is_delivered ENUM('доставлено','прочитано','ошибка'),
  created_at DATETIME DEFAULT NOW()
) COMMENT "Сообщения";

-- Таблица дружбы
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на инициатора дружеских отношений",
  friend_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя приглашения дружить",
  friendship_status ENUM ('приятель', 'знакомый', 'друг', 'лучший друг') DEFAULT '' COMMENT "Если статусы ограничены, то как вариант реализации",
  requested_at DATETIME DEFAULT NOW() COMMENT "Время отправления приглашения дружить",
  confirmed_at DATETIME COMMENT "Время подтверждения приглашения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",  
  PRIMARY KEY (user_id, friend_id) COMMENT "Составной первичный ключ"
) COMMENT "Таблица дружбы";


-- Таблица групп
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  owner_id INT UNSIGNED NOT NULL COMMENT "Добавил владельца(создателя) группы",
  name VARCHAR(150) NOT NULL COMMENT "Убрал UNIQUE",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE (owner_id, name) COMMENT "Сделал составное ограничение"  
) COMMENT "Группы";

-- Таблица связи пользователей и групп
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (community_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Участники групп, связь между пользователями и группами";

-- Таблица медиафайлов
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который загрузил файл",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы";

-- Таблица типов медиафайлов
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";




 
