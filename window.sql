-- сколько продали единц товара в разрезе типа товара total
-- общий итог продаж в деньгах в разрезе типа товара price
-- сколько людей покупает разные типы товара

SELECT DISTINCT type_clothes.name, 
SUM(orders_items.quantity) OVER w AS total,
SUM(catalog_description.price) OVER W AS price,
COUNT(orders.user_id) OVER w AS people
FROM orders_items
LEFT JOIN catalog 
ON orders_items.catalog_id = catalog.id 
LEFT JOIN type_clothes
ON catalog.type_clothes_id = type_clothes.id
LEFT JOIN catalog_description
ON catalog.id = catalog_description.catalog_id
LEFT JOIN orders
ON orders.id = orders_items.order_id
WINDOW w AS (PARTITION BY type_clothes.name);
