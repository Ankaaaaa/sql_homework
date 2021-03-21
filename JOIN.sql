-- 
-- максимальная покупка среди всех пользователей по мужчине и женщине т.е. находим женщину которая потратила больше всего денег, по аналогии так же у мужчины

SELECT  profiles.gender, MAX(catalog_description.price*orders_items.quantity) AS total
   FROM orders_items 
   LEFT JOIN orders
   ON orders.id = orders_items.order_id
   LEFT JOIN profiles
   ON profiles.user_id = orders.user_id
   LEFT JOIN catalog_description
   ON orders_items.catalog_id = catalog_description.catalog_id
   group by profiles.gender;
   
   -- топ 10 пользоватлей с максимальными покупками за все время
   SELECT  profiles.gender, profiles.user_id, catalog_description.price*orders_items.quantity AS total
   FROM orders_items 
   LEFT JOIN orders
   ON orders.id = orders_items.order_id
   LEFT JOIN profiles
   ON profiles.user_id = orders.user_id
   LEFT JOIN catalog_description
   ON orders_items.catalog_id = catalog_description.catalog_id
    ORDER BY total DESC LIMIT 10;
   
  
