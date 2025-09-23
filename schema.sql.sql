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

-- Queries 
-- Query 1
SELECT item_name, price FROM Menu WHERE price > 1000;

-- Query 2
SELECT item_name, price FROM Menu ORDER BY price ASC LIMIT 5;

-- Query 3
SELECT restaurant_name FROM Restaurants WHERE city = 'Kakamega';

-- Query 4
SELECT order_id, quantity FROM OrderDetails WHERE quantity > 2;

-- Query 5
SELECT o.order_id, r.restaurant_name 
FROM Orders o INNER JOIN Restaurants r ON 
o.restaurant_id = r.restaurant_id;

-- Query 6
SELECT DISTINCT c.customer_name, c.city
FROM Customers c INNER JOIN Orders o ON 
c.customer_id = o.customer_id
WHERE o.order_date >= '2024-01-01';

-- Query 7
SELECT c.customer_name, o.order_date
FROM Customers c INNER JOIN Orders o
ON c.customer_id = o.customer_id
WHERE o.order_date BETWEEN '2025-01-01' AND '2025-04-30';

-- Query 8
SELECT r.restaurant_name, o.order_id
FROM Orders o INNER JOIN Restaurants r ON 
o.restaurant_id = r.restaurant_id
WHERE r.city = 'Machakos';

-- Query 9
SELECT r.city, round(sum(d.quantity*m.price),2) AS revenue FROM
restaurants AS r INNER JOIN menu AS m ON
r.restaurant_id=m.restaurant_id JOIN orderdetails AS d ON
d.item_id=m.item_id
GROUP BY city ORDER BY revenue DESC;

-- Query 10
SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM Customers c JOIN Orders o ON 
c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 4
ORDER BY order_count DESC;

-- Query 11
SELECT c.customer_name, MAX(o.order_date) AS most_recent_order
FROM Customers c LEFT JOIN Orders o ON
c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- Query 12
SELECT r.restaurant_id, r.restaurant_name, COUNT(o.order_id) AS total_orders
FROM Orders o RIGHT JOIN Restaurants r ON 
o.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_orders DESC;

-- Query 13
SELECT m.item_id,m.item_name, r.restaurant_name,
COALESCE(SUM(od.quantity), 0) AS total_quantity_ordered
FROM OrderDetails od RIGHT JOIN Menu m ON 
od.item_id = m.item_id
INNER JOIN Restaurants r ON 
m.restaurant_id = r.restaurant_id
GROUP BY m.item_id, m.item_name, r.restaurant_name
ORDER BY total_quantity_ordered DESC;

-- Query 14
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c INNER JOIN Orders o ON 
c.customer_id = o.customer_id
GROUP BY c.customer_name;


-- Query 15
SELECT DISTINCT c.customer_name, r.restaurant_name
FROM Customers c INNER JOIN Orders o ON
c.customer_id = o.customer_id
INNER JOIN Restaurants r ON 
o.restaurant_id = r.restaurant_id
WHERE r.restaurant_name = 'Safari Nyama';

-- Query 16 
SELECT c.customer_name, o.order_id
FROM Customers c LEFT JOIN Orders o ON 
c.customer_id = o.customer_id;

-- Query 17 
SELECT o.order_id, r.restaurant_name
FROM Orders o RIGHT JOIN Restaurants r ON 
o.restaurant_id = r.restaurant_id;

-- Query 18
SELECT YEAR(signup_date) AS signup_year, COUNT(*) AS total_customers
FROM Customers
GROUP BY YEAR(signup_date)
ORDER BY signup_year;

-- Query 19
SELECT AVG(item_count) AS avg_items_per_order
FROM (
    SELECT order_id, SUM(quantity) AS item_count
    FROM OrderDetails
    GROUP BY order_id
) AS order_summary;

-- Query 20
SELECT c.customer_name, SUM(m.price * od.quantity) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Menu m ON od.item_id = m.item_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 3;
