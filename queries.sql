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

