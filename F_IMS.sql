CREATE DATABASE inventory;
USE inventory;

CREATE TABLE user (
   id  BIGINT NOT NULL,
   roleId  SMALLINT NOT NULL,
   firstName  VARCHAR(50) NULL DEFAULT NULL,
   middleName  VARCHAR(50) NULL DEFAULT NULL,
   lastName  VARCHAR(50) NULL DEFAULT NULL,
   username  VARCHAR(50) NULL DEFAULT NULL,
   mobile  VARCHAR(15) NULL,
   email  VARCHAR(50) NULL,
  PRIMARY KEY ( id ));
INSERT INTO user (id, roleId, firstName, middleName, lastName, username, mobile, email) VALUES
(1, 1, 'John', 'A', 'Doe', 'john.doe', '1234567890', 'john.doe@email.com'),
(2, 2, 'Jane', 'B', 'Smith', 'jane.smith', '0987654321', 'jane.smith@email.com'),
(3, 1, 'Bob', 'D', 'Johnson', 'bob.johnson', '6789012345', 'bob.johnson@email.com'),
(4, 3, 'Alice', 'C', 'Williams', 'alice.williams', '1234509876', 'alice.williams@email.com'),
(5, 2, 'Charlie', 'E', 'Brown', 'charlie.brown', '0987612345', 'charlie.brown@email.com');
SELECT * FROM user;

CREATE TABLE product (
   id  BIGINT NOT NULL,
   title  VARCHAR(75) NOT NULL,
   price  FLOAT NOT NULL DEFAULT 0,
   quantity  SMALLINT(6) NOT NULL DEFAULT 0,
  PRIMARY KEY ( id ) 
);
INSERT INTO product (id, title, price, quantity) VALUES
(1, 'Laptop', 50.00, 2),
(2, 'Smartphone', 25.50, 1),
(3, 'Headphones', 30.25, 3),
(4, 'Digital Camera', 10.75, 1),
(5, 'Fitness Tracker', 40.40, 2);
SELECT * FROM product;

CREATE TABLE orders (
   id  BIGINT NOT NULL AUTO_INCREMENT,
   userId  BIGINT NOT NULL,
   subTotal  FLOAT NOT NULL DEFAULT 0,
   tax  FLOAT NOT NULL DEFAULT 0,
   total  FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY ( id ),
  INDEX  idx_order_user  ( userId  ASC),
  CONSTRAINT  fk_order_user 
    FOREIGN KEY ( userId )
    REFERENCES  inventory . user  ( id )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
INSERT INTO orders (userId, subTotal, tax, total) VALUES
(1, 100.00, 8.00, 108.00),
(2, 75.50, 6.04, 81.54),
(3, 200.25, 16.02, 216.27),
(4, 50.75, 4.06, 54.81),
(5, 120.80, 9.66, 130.46);
SELECT * FROM orders;

CREATE TABLE transactions (
   id  BIGINT NOT NULL AUTO_INCREMENT,
   userId  BIGINT NOT NULL,
   orderId  BIGINT NOT NULL,
   content  TEXT NULL DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX idx_transaction_user (userId ASC),
  CONSTRAINT fk_transaction_user 
    FOREIGN KEY (userId)
    REFERENCES user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

INSERT INTO transactions (userId, orderId, content) VALUES
(1, 1, 'Successfully processed payment $49.99'),
(2, 2, 'Payment received  $129.95'),
(3, 3, 'Transaction completed $79.99'),
(4, 4, 'payment confirmed: $149.99'),
(5, 5, 'Payment processed $19.99');
SELECT * FROM transactions;

CREATE TABLE offers (
    offer_id INT PRIMARY KEY,
    product_id BIGINT, 
    offer_title VARCHAR(255) NOT NULL,
    offer_description TEXT,
    CONSTRAINT fk_offer_product
        FOREIGN KEY (product_id)
        REFERENCES product(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
INSERT INTO offers (offer_id, product_id, offer_title, offer_description)VALUES
(1, 1, 'Discount Sale', 'Get 20% off on Product Laptop!'),
(2, 2, 'Bundle Deal', 'Buy Product B and Product SmartPhone together and save $10.'),
(3, 3, 'Limited Time Offer', 'Special price for Product HeadPhones for the next 48 hours!'),
(4, 4, 'Clearance Sale', 'Last chance to buy Product DigitalCamera at a discounted price.'),
(5, 5, 'Buy One Get One Free', 'Purchase Product Fitness Tracker and get another one for free');

SELECT * FROM offers;

DESC user;
DESC product;
DESC orders;
DESC transactions;
DESC offers;

-- drop table transactions;
-- drop database inventory;
