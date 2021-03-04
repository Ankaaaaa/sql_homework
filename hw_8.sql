USE vk;

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT profiles.gender, COUNT(likes.user_id) 
  FROM profiles 
   JOIN likes
  ON profiles.user_id = likes.user_id
  GROUP BY profiles.gender;
  

-- 4. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).


SELECT SUM(total) FROM 
(SELECT (SELECT COUNT(likes.target_id)) AS total
FROM profiles LEFT JOIN likes
ON profiles.user_id = likes.target_id 
AND likes.target_type_id =2 
GROUP BY profiles.user_id
 ORDER BY profiles.birthday DESC LIMIT 10) AS TT;

-- ПРОВЕРКА
SELECT profiles.user_id, COUNT(likes.target_id)
FROM profiles LEFT JOIN likes
ON profiles.user_id = likes.target_id 
AND likes.target_type_id =2 
GROUP BY profiles.user_id
 ORDER BY profiles.birthday DESC LIMIT 10;
 

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- выводим 10 пользователей которые меньше всего отправили сообщений и не поставили ни одного лайка и не имеют ни одного медиа
SELECT users.id, COUNT(media.id), COUNT(likes.id), COUNT(messages.from_user_id)
FROM users 
LEFT JOIN likes 
ON users.id = likes.user_id 
LEFT JOIN media 
ON media.user_id = users.id
JOIN messages
ON messages.from_user_id = users.id
GROUP BY users.id
ORDER BY COUNT(media.id), COUNT(likes.id), COUNT(messages.from_user_id) LIMIT 10;


SELECT * FROM media WHERE user_id = 58;
