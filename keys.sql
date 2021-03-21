-- создаем ключи !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SHOW TABLES;

-- profiles---------------------------------------------------------------------------------------------------------------
SELECT * FROM users;
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
      
-- catalog---------------------------------------------------------------------------------------------------------------  
SELECT * FROM catalog;  
SELECT * FROM type_clothes; 
SELECT * FROM media; 
ALTER TABLE catalog
  ADD CONSTRAINT catalog_type_clothes_id_fk 
    FOREIGN KEY (type_clothes_id) REFERENCES type_clothes(id)
      ON DELETE CASCADE;  

ALTER TABLE catalog
  ADD CONSTRAINT catalog_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id)
      ON DELETE CASCADE;   
      
-- catalog---------------------------------------------------------------------------------------------------------------  
SELECT * FROM catalog;  
SELECT * FROM catalog_description; 
SELECT * FROM discount; 
SELECT * FROM reviews; 

ALTER TABLE catalog_description
  ADD CONSTRAINT catalog_description_catalog_id_fk 
    FOREIGN KEY (catalog_id) REFERENCES catalog(id)
      ON DELETE CASCADE;  

ALTER TABLE catalog_description
  ADD CONSTRAINT catalog_description_discount_id_fk 
    FOREIGN KEY (discount_id) REFERENCES discount(id)
    ON DELETE CASCADE; 
    
 ALTER TABLE catalog_description
  ADD CONSTRAINT catalog_description_reviews_id_fk 
    FOREIGN KEY (reviews_id) REFERENCES reviews(id)
    ON DELETE SET NULL;   

-- discount---------------------------------------------------------------------------------------------------------------  
SELECT * FROM discount;  
SELECT * FROM catalog; 

ALTER TABLE discount
  ADD CONSTRAINT discount_catalog_id_fk 
    FOREIGN KEY (catalog_id) REFERENCES catalog(id)
      ON DELETE CASCADE; 

      
 -- orders---------------------------------------------------------------------------------------------------------------  
SELECT * FROM orders;        
ALTER TABLE orders
  ADD CONSTRAINT orders_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;    
      
ALTER TABLE orders
  ADD CONSTRAINT orders_status_order_id_fk 
    FOREIGN KEY (status_order_id) REFERENCES status_order(id);
    
 ALTER TABLE orders
  ADD CONSTRAINT orders_courier_id_fk 
    FOREIGN KEY (courier_id) REFERENCES courier(id);    
    
 ALTER TABLE orders
  ADD CONSTRAINT orders_pick_up_points_id_fk 
    FOREIGN KEY (pick_up_points_id) REFERENCES pick_up_points(id)
      ON DELETE CASCADE; 
      
-- orders_items------------------------------------------------------------------------------------------------------------------
 SELECT * FROM orders_items;      
  
  ALTER TABLE orders_items
  ADD CONSTRAINT orders_items_order_id_fk 
    FOREIGN KEY (order_id) REFERENCES orders(id)
      ON DELETE CASCADE; 
      
ALTER TABLE orders_items
  ADD CONSTRAINT orders_items_catalog_id_fk 
    FOREIGN KEY (catalog_id) REFERENCES catalog(id);
    
ALTER TABLE orders_items
  ADD CONSTRAINT orders_items_store_id_fk 
    FOREIGN KEY (store_id) REFERENCES store(id);    

-- quantity------------------------------------------------------------------------------------------------------------------
 SELECT * FROM quantity; 
 
ALTER TABLE quantity
  ADD CONSTRAINT quantity_store_id_fk 
    FOREIGN KEY (store_id) REFERENCES store(id)
      ON DELETE CASCADE;  
    
ALTER TABLE quantity
  ADD CONSTRAINT quantity_catalog_id_fk 
    FOREIGN KEY (catalog_id) REFERENCES catalog(id)
      ON DELETE CASCADE; 
      
-- reviews------------------------------------------------------------------------------------------------------------------
 SELECT * FROM reviews;  
 
ALTER TABLE reviews
  ADD CONSTRAINT reviews_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE; 
      
ALTER TABLE reviews
  ADD CONSTRAINT reviews_catalog_id_fk 
    FOREIGN KEY (catalog_id) REFERENCES catalog(id)
      ON DELETE CASCADE;
      
ALTER TABLE reviews
  ADD CONSTRAINT reviews_type_clothes_id_fk 
    FOREIGN KEY (type_clothes_id) REFERENCES type_clothes(id)
      ON DELETE CASCADE;   
      
      