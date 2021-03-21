-- поиск по номеру заказа и номеру товара
CREATE INDEX order_id_catalog_id_idx ON orders_items (order_id, catalog_id);

-- поиск по номеру заказа и пользователю
CREATE INDEX id_user_id_idx ON orders (id, user_id);

-- поиск по номеру заказа и типу доставки
CREATE INDEX id_deliviry_idx ON orders (id, deliviry);

-- поиск по номеру заказа и типу оплаты
CREATE INDEX id_payment_idx ON orders (id, payment);

-- поиск по пользователю который оставил отзыв к определеному типу товара
CREATE INDEX user_id_type_clothes_id_idx ON reviews (user_id, type_clothes_id);

-- поиск по номеру склада и номеру товара
CREATE INDEX store_id_catalog_id_idx ON quantity (store_id, catalog_id);
