# 🍔 Food Delivery Database Project

## 📌 Overview
This project simulates a **Food Delivery Management System** using MySQL.  
It demonstrates database design, data relationships, and SQL querying techniques.

The project includes:  
- Database schema design (ERD + SQL schema)  
- Hypothetical CSV dataset for customers, restaurants, menu items, orders, and order details  
- SQL queries covering filtering, joins, and aggregation
- The project assumes that all the major towns listed are cities in Kenya.

---

## 🗂️ Entity Relationship Diagram (ERD)
<img width="3303" height="3840" alt="ERD" src="https://github.com/user-attachments/assets/d21876ea-539b-4c37-92b8-dddd127e6e77" />



---

## ⚙️ Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/food-delivery-db.git
cd food-delivery-db
```

### 2. Create the Database and Tables
```bash
mysql -u your_username -p food_delivery < schema.sql
```

### 3. Import the Data from CSV Files
Place the CSV files into MySQL’s import folder (e.g., `/var/lib/mysql-files/`) and run:  
```sql
LOAD DATA INFILE '/var/lib/mysql-files/customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

Repeat for `restaurants.csv`, `menu.csv`, `orders.csv`, and `order_details.csv`.  

### 4. Run the Queries
```bash
mysql -u your_username -p food_delivery < queries.sql
```

---

## 📊 Queries Implemented

1. Find the name and price of food items that cost more than 1000/-
2. List top 5 cheapest dishes 
3. List all restaurants located in Kakamega
4. List all order IDs where quantity is greater than 2
5. Show all orders along with the restaurant name from which they were placed
6. List all customers along with their city who placed an order on or after 2024-01-01
7. Show customer names and order dates for orders placed in Jan to April 2025
8. Show restaurant names and order IDs for orders placed from restaurants in Machakos
9. Show total revenue earned from each city
10. List customers who placed more than 4 orders starting with the highest
11. Find all customers and their most recent order date. Make sure customers who have never placed an order also appear in the results
12. List all restaurants and the total number of orders they have received. Make sure restaurants with no orders are also shown.
13. Retrieve a list of all menu items from every restaurant along with the total quantity ordered for each item. Ensure that menu items which have never been ordered still appear in the results
14. Count how many orders each customer as placed
15. Customers who have ordered from a specific restaurant (Safari Nyama).
16. Retrieve a list of all customers and the restaurants they have ordered from. Ensure that restaurants with no matching customers are also included in the results.
17. List all restaurants and their menu items, including restaurants that don’t currently have any menu items.
18. Show the number of customers who signed up each year
19: Find the average quantity of items ordered per order
20.Find the top 3 customers who spent the most overall
---

## ✅ Deliverables
- `schema.sql` → Database schema +  SQL queries
- `customers.csv`, `restaurants.csv`, `menu.csv`, `orders.csv`, `order_details.csv` → Dataset  
- `ERD.png` → Entity Relationship Diagram  
- `README.md` → Project documentation  

---

## 🏆 Learning Outcomes
By completing this project, I demonstrated:
- Database schema design and normalization 
- Writing SQL queries with **JOINs, GROUP BY, and aggregates**  
- Handling **LEFT and RIGHT joins**  
- Importing CSV datasets into MySQL  
- End-to-end project setup and documentation 
- Generating insights such as **top customers, popular dishes, city-wise revenue, and inactive restaurants/customers** 

---

## 🚀 Future Improvements

- Add triggers to track changes in orders

- Create stored procedures for reporting

- Build a simple web dashboard (using Flask/Django + SQL) to visualize insights

👤 Author

Maina M James
📧 mmainajames@gmail.com

🌍 Nairobi, Kenya
---
