USE shopping;
SHOW TABLES;

-- users --------------------------------------------------------------------------------------
SELECT * FROM users;
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;
-- profiles ------------------------------------------------------------------------------------
SELECT * FROM profiles;
UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at;
-- catalog ---------------------------------------------------------------------------------------
SELECT * FROM catalog;
UPDATE catalog SET updated_at = NOW() WHERE updated_at < created_at;
-- перемещиваем тип медиа
UPDATE catalog SET
	media_id = FLOOR(1+RAND() *300);
-- перемещиваем тип одежды
UPDATE catalog SET
	type_clothes_id = FLOOR(1+RAND() *3);    

-- type_clothes ---------------------------------------------------------------------------------    
SELECT * FROM type_clothes;
UPDATE type_clothes SET name = 'обувь' WHERE name = 'ducimus';
UPDATE type_clothes SET name = 'одежда' WHERE name = 'dolor';
UPDATE type_clothes SET name = 'аксессуары' WHERE name = 'architecto';

-- catalog_description ---------------------------------------------------------------------------
SELECT * FROM catalog_description;
SELECT * FROM catalog;

UPDATE catalog_description SET updated_at = NOW() WHERE updated_at < created_at;


    
-- перемещиваем скидки
UPDATE catalog_description SET
	discount_id = FLOOR(1+RAND() *30);

-- меняем цену
UPDATE catalog_description SET
	price = FLOOR(1000 + RAND() *10000) WHERE price > 30000;
 -- перемещиваем коментарии  
UPDATE catalog_description SET
	reviews_id = FLOOR(1+RAND() *100);

-- courier ---------------------------------------------------------------------------------------
SELECT * FROM courier;
UPDATE courier SET updated_at = NOW() WHERE updated_at < created_at;

-- discount ---------------------------------------------------------------------------------------удалить каталог айди
SELECT * FROM discount;
-- перемещиваем каталог
UPDATE discount SET
	catalog_id = FLOOR(1+RAND() *300);
-- меняем размер скидки
UPDATE discount SET
	amount = FLOOR(1+RAND() *30);
-- media --------------------------------------------------------------------------------------------
SELECT * FROM media;
-- перемещиваем каталог
UPDATE media SET
	catalog_id = FLOOR(1+RAND() *300);
-- правим даты
UPDATE media SET updated_at = NOW() WHERE updated_at < created_at;

-- вносим данные в метаданные
UPDATE media SET metadata = NULL;
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(color, ' ', size) FROM catalog_description WHERE catalog_description.id = media.id),
  '"}');

  -- коректируем filename
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));
INSERT INTO extensions VALUES ('PNG'),('TIFF'),('JPEG'),('GIF');  
UPDATE media SET filename = CONCAT(
  'http://lamoda.net/',
  (SELECT color FROM catalog_description ORDER BY RAND() LIMIT 1),
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

-- orders -------------------------------------------------------------------------------------------
SELECT * FROM orders;
-- перемещиваем каталог
UPDATE orders SET
	user_id = FLOOR(1+RAND() *100);
-- перемещиваем пункты выдачи
UPDATE orders SET
	pick_up_points_id = FLOOR(1+RAND() *60);
    
-- перемещиваем пункты курьеров
UPDATE orders SET
	courier_id = FLOOR(1+RAND() *20);
    
-- правим даты
UPDATE orders SET confirmed_at = NOW() WHERE confirmed_at< created_at;

    
    
-- orders_items -------------------------------------------------------------------------------------
SELECT * FROM orders_items;
-- перемещиваем заказы
UPDATE orders_items SET
	order_id = FLOOR(1+RAND() *100);
-- перемещиваем каталог
UPDATE orders_items SET
	catalog_id = FLOOR(1+RAND() *300);
    
-- перемещиваем склады
UPDATE orders_items SET
	store_id = FLOOR(1+RAND() *25);
    
-- заполняем стобец количество товара
UPDATE orders_items SET
	quantity = FLOOR(1+RAND() *4);    
	
-- pick_up_points -----------------------------------------------------------------------------------
SELECT * FROM pick_up_points;
UPDATE pick_up_points SET updated_at = NOW() WHERE updated_at < created_at;
-- quantity -----------------------------------------------------------------------------------------
SELECT * FROM quantity;

-- перемещиваем склады
UPDATE quantity SET
	store_id = FLOOR(1+RAND() *25);
    
 -- перемещиваем каталог
UPDATE quantity SET
	catalog_id = FLOOR(1+RAND() *300);   
    
-- коректируем количество
UPDATE quantity SET amount = FLOOR(1 +RAND () *100) WHERE amount >200;

-- reviews---------------------------------------------------------------------------------
SELECT * FROM reviews;
    
-- перемещиваем каталог
UPDATE reviews SET
	catalog_id = FLOOR(1+RAND() *300); 
    
-- перемещиваем каталог
UPDATE reviews SET
	user_id = FLOOR(1+RAND() *100);     
 
 -- перемещиваем тип одежды
UPDATE reviews SET
	type_clothes_id = FLOOR(1+RAND() *3);    
    
-- status_order --------------------------------------------------------------------------------------
SELECT * FROM status_order;
-- редактируем столбец со статусом заказа
CREATE TEMPORARY TABLE ext (name VARCHAR(30));
INSERT INTO ext VALUES ('сбор заказа'),('в пункте выдачи'),('у курьера'),('доставлен');  
UPDATE status_order SET name = (SELECT name FROM ext ORDER BY RAND() LIMIT 1);

-- store ---------------------------------------------------------------------------------------------
SELECT * FROM store;
UPDATE store SET updated_at = NOW() WHERE updated_at < created_at;

