CREATE DATABASE food_delivery;
USE food_delivery;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    signup_date DATE NOT NULL
);

-- Restaurants Table
CREATE TABLE Restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    registration_date DATE NOT NULL
);

-- Menu Table
CREATE TABLE Menu (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_menu_rest FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_date DATE NOT NULL,
	CONSTRAINT fk_ord_cust FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT fk_ord_rest FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT fk_det_ord FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT fk_det_menu FOREIGN KEY (item_id) REFERENCES Menu(item_id)
);

SET GLOBAL LOCAL_INFILE=ON; -- Activating use of LOAD DATA INFILE

-- Populating the customers table
LOAD DATA INFILE 'D:/Food Delivery Project/customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, customer_name, email, city, signup_date);

-- Populating the restaurants table
LOAD DATA INFILE 'D:/Food Delivery Project/restaurants.csv'
INTO TABLE Restaurants
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(restaurant_id, restaurant_name, city, registration_date);

-- Populating the menu table
LOAD DATA INFILE 'D:/Food Delivery Project/menu.csv'
INTO TABLE Menu
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(item_id, restaurant_id, item_name, price);

-- Populating the orders table
LOAD DATA INFILE 'D:/Food Delivery Project/orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, customer_id, restaurant_id, order_date);

-- Populating the order details table
LOAD DATA INFILE 'D:/Food Delivery Project/order_details.csv'
INTO TABLE OrderDetails
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_detail_id, order_id, item_id, quantity);

