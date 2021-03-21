-- проверяем если при вставке в таблицу скидок, вставляемая скидка больше 50% 
-- то он отменяет действие вставки и выдает ошибку "о том что скидка слишком большая"

DELIMITER //
CREATE TRIGGER check_discount_insert BEFORE INSERT ON discount
FOR EACH ROW
BEGIN
  IF NEW.amount > 50 THEN 
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'скидка слишком большая';
  END IF;
END//

SELECT * FROM discount;
-- проверка
INSERT INTO discount
  (id, catalog_id, amount)
VALUES
  (101, 101, 10)//
  
  -- когда пользователь не указал страну, то автоматически подставляется "страна не указана"
  
 DELIMITER // 
CREATE TRIGGER check_country BEFORE INSERT ON profiles
FOR EACH ROW
BEGIN
  SET NEW.country = COALESCE(NEW.country, 'страна не указана');
END//

INSERT INTO profiles
  (user_id, gender, city, country, adress)
VALUES
  (103, 'W', 'Moscow' , NULL, 'street')//
