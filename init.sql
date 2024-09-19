-- Создаем пользователя с паролем
CREATE USER 'jpa'@'%' IDENTIFIED WITH mysql_native_password BY '280211';

-- Предоставляем все права пользователю на базу данных
GRANT ALL PRIVILEGES ON wortspiel.* TO 'jpa'@'%';

-- Обновляем привилегии
FLUSH PRIVILEGES;

