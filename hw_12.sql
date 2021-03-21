
 CREATE DATABASE shopping;
  

-- Создаём таблицу пользователей
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);  

-- Таблица профилей
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
  gender ENUM ('M', 'W') COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  adress VARCHAR(130) COMMENT "Адрес проживания улица дом квартира",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
); 


-- Таблица складов
CREATE TABLE store (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "индефикатор склада", 
  city VARCHAR(130) NOT NULL COMMENT "Город",
  country VARCHAR(130) NOT NULL COMMENT "Страна",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
); 


-- Таблица остатков
CREATE TABLE quantity (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "индефикатор",
  store_id INT UNSIGNED NOT NULL COMMENT "Ссылка на склад",
  catalog_id INT UNSIGNED NOT NULL COMMENT "Ссылка на каталог",
  amount INT UNSIGNED DEFAULT '0' COMMENT "количество единиц товара",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
); 

-- Таблица скидок
CREATE TABLE discount (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "индефикатор",
  catalog_id INT UNSIGNED NOT NULL COMMENT "Ссылка на каталог",
  amount FLOAT UNSIGNED DEFAULT '0' COMMENT "размер скидки",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
); 

-- Таблица типа продукции
CREATE TABLE type_clothes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);


-- Таблица каталог
CREATE TABLE catalog (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "индефикатор",
	type_clothes_id INT UNSIGNED NOT NULL COMMENT "Название типа",
	type_clothes_age ENUM ('для мужчин', 'для женщин', 'для мальчиков', 'для девочек' ) NOT NULL COMMENT "класификация по возрасту",
    media_id INT UNSIGNED NOT NULL COMMENT "ссылка на фото",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);



-- Таблица каталог_описание товара
CREATE TABLE catalog_description (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "индефикатор",
    catalog_id INT UNSIGNED NOT NULL COMMENT "ссылка на каталог",
	price INT UNSIGNED NOT NULL COMMENT "цена",
	discount_id INT UNSIGNED NOT NULL COMMENT "Ссылка на скидку",
	size INT UNSIGNED COMMENT "размер",
	color VARCHAR (50) NOT NULL COMMENT "цвет",
    reviews_id INT UNSIGNED COMMENT "ссылка на отзыв и оценку",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);

-- Таблица статуса заказов
CREATE TABLE status_order (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE  COMMENT "статус заказа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

  
-- Таблица содержимого заказа
CREATE TABLE orders_items (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "индефикатор",
    order_id INT UNSIGNED NOT NULL COMMENT "Ссылка заказ",
    catalog_id INT UNSIGNED NOT NULL COMMENT "Ссылка на каталог",
    quantity INT UNSIGNED NOT NULL COMMENT "количество",
    store_id INT UNSIGNED NOT NULL COMMENT "Ссылка склад отгрузки",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);


-- Таблица заказов
CREATE TABLE orders (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "индефикатор",
    user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя", 
    status_order_id INT UNSIGNED NOT NULL COMMENT "Ссылка на статус заказа",
    payment ENUM ('наличные при получении', 'онлайн', 'картой при получении') NOT NULL COMMENT "тип оплаты",
    deliviry ENUM ('самовывоз', 'курьер') NOT NULL COMMENT "тип доставки",
    courier_id INT UNSIGNED COMMENT "Ссылка на курьера",
    pick_up_points_id INT UNSIGNED COMMENT "Ссылка на пункт самовывоза",
    confirmed_at DATETIME COMMENT "Время получения заказа",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);
    
 
 -- Таблица курьеров
 CREATE TABLE courier (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя курьера",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия курьера",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
); 
 
 -- Таблица отзывы,оценок
 CREATE TABLE reviews (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
    user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя", 
    catalog_id INT UNSIGNED NOT NULL COMMENT "Ссылка на каталог",
    type_clothes_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип товара",
    body_reviews VARCHAR(130) COMMENT "отзыв",
    rating ENUM ('1', '2', '3', '4', '5') COMMENT "оценка",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
 );
 
 -- Таблица пункты выдачи 
 CREATE TABLE pick_up_points (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  adress VARCHAR(130) COMMENT "адрес",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
); 
 

CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type ENUM ('JPEG', 'GIF', 'PNG', 'TIFF') COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы";	

