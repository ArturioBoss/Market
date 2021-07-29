SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id                    INT(11) NOT NULL AUTO_INCREMENT,
  username              VARCHAR(50) NOT NULL,
  password              CHAR(80) NOT NULL,
  first_name            VARCHAR(50) NOT NULL,
  last_name             VARCHAR(50) NOT NULL,
  email                 VARCHAR(50) NOT NULL,
  phone                 VARCHAR(15) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS roles;

CREATE TABLE roles (
  id                    INT(11) NOT NULL AUTO_INCREMENT,
  name                  VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS users_roles;

CREATE TABLE users_roles (
  user_id               INT(11) NOT NULL,
  role_id               INT(11) NOT NULL,

  PRIMARY KEY (user_id,role_id),

  CONSTRAINT FK_USER_ID_01 FOREIGN KEY (user_id)
  REFERENCES users (id)
  ON DELETE NO ACTION ON UPDATE NO ACTION,

  CONSTRAINT FK_ROLE_ID FOREIGN KEY (role_id)
  REFERENCES roles (id)
  ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
  id	                INT(11) NOT NULL AUTO_INCREMENT,
  title                 VARCHAR(255) NOT NULL,
  description           VARCHAR(5000),
  PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS products;

CREATE TABLE products (
  id	                INT(11) NOT NULL AUTO_INCREMENT,
  category_id           INT(11) NOT NULL,
  vendor_code           VARCHAR(8) NOT NULL,
  title                 VARCHAR(255) NOT NULL,
  short_description     VARCHAR(1000) NOT NULL,
  full_description      VARCHAR(5000) NOT NULL,
  price                 DECIMAL(8,2) NOT NULL,
  create_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT FK_CATEGORY_ID FOREIGN KEY (category_id)
  REFERENCES categories (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS products_images;

CREATE TABLE products_images (
  id                    INT(11) NOT NULL AUTO_INCREMENT,
  product_id            INT(11) NOT NULL,
  path                  VARCHAR(250) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_PRODUCT_ID_IMG FOREIGN KEY (product_id)
  REFERENCES products (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS orders_statuses;

CREATE TABLE orders_statuses (
  id                    INT(11) NOT NULL AUTO_INCREMENT,
  title                 VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  id	                INT(11) NOT NULL AUTO_INCREMENT,
  user_id               INT(11) NOT NULL,
  price                 DECIMAL(8,2) NOT NULL,
  delivery_price        DECIMAL(8,2) NOT NULL,
  delivery_address_id   INT(11) NOT NULL,
  phone_number          VARCHAR(20) NOT NULL,
  status_id             INT(11) NOT NULL,
  delivery_date         TIMESTAMP NOT NULL,
  create_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT FK_USER_ID FOREIGN KEY (user_id)
  REFERENCES users (id),
  CONSTRAINT FK_STATUS_ID FOREIGN KEY (status_id)
  REFERENCES orders_statuses (id),
  CONSTRAINT FK_DELIVERY_ADDRESS_ID FOREIGN KEY (delivery_address_id)
  REFERENCES delivery_addresses (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS orders_item;

CREATE TABLE orders_item (
  id	                INT(11) NOT NULL AUTO_INCREMENT,
  product_id            INT(11) NOT NULL,
  order_id              INT(11) NOT NULL,
  quantity              INT NOT NULL,
  item_price            DECIMAL(8,2) NOT NULL,
  total_price           DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_ORDER_ID FOREIGN KEY (order_id)
  REFERENCES orders (id),
  CONSTRAINT FK_PRODUCT_ID_ORD_IT FOREIGN KEY (product_id)
  REFERENCES products (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO users (username,password,first_name,last_name,email,phone)
VALUES
('artur','$2y$12$HkSUIITA5vaD1b8s4gZLL.HXGd6uofr0Y6WjsboX.YMOq3sZpL9Se','Артур','GeekBrains','maltcev-artur@yandex.ru','79091000222');

INSERT INTO roles (name)
VALUES
('ROLE_EMPLOYEE'), ('ROLE_MANAGER'), ('ROLE_ADMIN');

INSERT INTO users_roles (user_id, role_id)
VALUES
(1, 1),
(1, 2),
(1, 3);

INSERT INTO categories (title)
VALUES
("Автоматизация"), ("Камеры");

INSERT INTO products (category_id, vendor_code, title, short_description, full_description, price)
VALUES
(1, "00000001", "SmartHome", "Умный дом (Mijia Home)", "Управление устройствами Xiaomi.<a>Отличия от оригинала:</a> Частично реализован перевод сценариев и статусов устройств, в процессе перевод уведомлений. Для замены плагинов ROOT не требуется! Путь для замены плагинов: <au>Внутренняя память/EDA/plugin/install/mpk/№ папки</au>", 1.00),
(1, "00000002", "SmartHomePlugin", "Плагины для Умного дома", "Плагины для различных устройств в Умном доме. Путь для замены плагинов: <au>Внутренняя память/EDA/plugin/install/mpk/№ папки.</au>", 2.00),
(1, "00000003", "Yeelight", "Yeelight", "Приложение для управления умными лампами Xiaomi (Yeelight LED (цветная), Yeelight LED (белая), Ночник Yeelight и Настольная лампа Mijia) Полный перевод, включая Помощь и Справку.", 3.00),
(1, "00000004", "Mi Роутер", "Mi Роутер", "Приложение для управления роутерами Xiaomi.", 4.00),
(1, "00000005", "ZMI Portable Router", "ZMI Portable Router", "Используйте сим-карту для интернета любого мобильного оператора в своём мобильном роутере ZMI и разделяйте задачи: сим-карта в телефоне – для звонков, сим-карта в роутере – для интернета. К тому же, можно использовать и как портативное зарядное устройство.", 5.00),
(1, "00000006", "ZMI Smart PowerBank", "ZMI Smart PowerBank", "Приложение для полного контроля и управления Вашего батарейного блока ZMI.", 6.00),
(2, "00000007", "Yi Home (IP-Камеры)", "Yi Home (IP-Камеры)", "Приложение для управления умными IP-камерами Xiaomi Mi ants.", 7.00),
(2, "00000008", "Yi Action Camera (Спортивная камера)", "Yi Action Camera (Спортивная камера)", "Данное приложение поможет Вам управлять, снимать, просматривать отснятое видео и фото.
Существует несколько моделей данной камеры, Отличие на данный момент только в улучшении звука и фокусировки линзы.", 8.00),
(2, "00000009", "Yi Car DVR (Видеорегистратор)", "Yi Car DVR (Видеорегистратор)", "Команда Yi Technology, объединившись с профессионалами из Германии, Тайваня, Китая и Японии, создала умный видеорегистратор, ранее не имевший аналогов по оптимальному соотношению стоимости и производительности.", 9.00),
(2, "00000010", "Yi Halo (VR-Камера)", "Yi Halo (VR-Камера)", "Бывший партнер Xiaomi, компания Yi Technology сегодня представила Yi Halo – платформу для записи VR-видео. Конструкция состоит из 17 камер Yi 4K Action Camera, а также обладает собственным дисплеем и аккумулятором на 50 Вт для автономной работы.", 10.00),
(2, "00000011", "Видеорегистратор 70MAI Dash Сam", "Видеорегистратор 70MAI Dash Сam", "Приложение для управления видеорегистратором 70MAI Dash Сam.", 11.00),
(2, "00000012", "Видеорегистратор Mijia Car Camera", "Видеорегистратор Mijia Car Camera", "Приложение для управления видеорегистратором Mijia Car Camera.", 12.00);

INSERT INTO products_images (product_id, path)
VALUES
(1, "Mijia_Home.png"),
(2, "plugin_3.png"),
(3, "Yeelight.png"),
(4, "mi_wifi.png"),
(5, "ZMI.png"),
(6, "ZMI2.png"),
(7, "YiHome.png"),
(8, "canera.png"),
(9, "MijiaCarCamera.png"),
(10, "HALO.png"),
(11, "70MAI Dash Сam.png"),
(12, "Mijia_Car_Camera.png");

INSERT INTO orders_statuses (title)
VALUES
("Сформирован");
