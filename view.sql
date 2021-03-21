-- представление отображает сколько единиц товара хранится на каждом складе
CREATE VIEW new_name (id_store, count_stock) AS
	SELECT store.id, COUNT(quantity.amount) AS total
	FROM store LEFT JOIN quantity
	ON store.id = quantity.store_id
    GROUP BY store.id;
    
SELECT * FROM new_name;    

-- представление отображает номера заказов, статус заказа, фио курьера и его телефон
CREATE VIEW new_name1 (id_orders, status_order,  courier, courier_phone) AS
	SELECT orders.id, status_order.name, CONCAT(courier.first_name, ' ', courier.last_name), courier.phone
	FROM orders
    LEFT JOIN courier
	ON orders.courier_id = courier.id
    LEFT JOIN status_order
    ON orders.status_order_id = status_order.id;
    
    SELECT * FROM new_name1;   