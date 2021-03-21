-- процедура которая принмает id пользователя и выдает количество по нему заказов

DROP PROCEDURE counts_orders;
DELIMITER //
CREATE PROCEDURE counts_orders (IN id INT)
BEGIN
  SELECT COUNT(id) FROM orders WHERE user_id = id;
END//
DELIMITER ;

-- вызов процедуры
CALL counts_orders(40);
-- проверка
SELECT user_id, COUNT(id) FROM orders GROUP BY user_id;