CREATE DATABASE HM5;
USE HM5;
DROP TABLE users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', NULL, NULL),
  ('Наталья', '1984-11-12', NULL, NULL),
  ('Александр', '1985-05-20', NULL, NULL),
  ('Сергей', '1988-02-14', NULL, NULL),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '2006-08-29', NULL, NULL);
  
  SELECT * FROM users;
 UPDATE users SET created_at = NOW(), updated_at = NOW();
 
 -- 2 TASK------------------------------------------------------------------------
 
 DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александр', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');
  
SELECT * FROM users;

UPDATE users SET created_at = STR_TO_DATE (created_at, '%d.%m.%Y %k:%i'),
updated_at = STR_TO_DATE (updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE users CHANGE created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users CHANGE updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP;

-- 3 TASK------------------------------------------------------------------------------------
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 543, 0),
  (1, 789, 2500),
  (1, 3432, 0),
  (1, 826, 30),
  (1, 719, 500),
  (1, 638, 1);
  
  SELECT * FROM storehouses_products;
  SELECT * FROM storehouses_products ORDER BY value IS NULL, value DESC;
  
  -- Тема Агрегация, задание 1
  
  SELECT * FROM profiles LIMIT 10;
  SELECT FLOOR(SUM((TO_DAYS(NOW()) - TO_DAYS(birthday))/365.25)/COUNT(user_id)) AS age FROM profiles;
  

-- Тема Агрегация, задание 2
SELECT DAYNAME(DATE_FORMAT(birthday,'2021-%m-%d %T')), COUNT(*) AS total FROM profiles GROUP BY DAYNAME(DATE_FORMAT(birthday,'2021-%m-%d %T'));
  
  




    
 

