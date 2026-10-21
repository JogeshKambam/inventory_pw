Inventory Management System (SQL Project)
Project Overview -
This Inventory Management System is a beginner-friendly SQL project developed using MySQL. The project helps manage products, categories, suppliers, stock information, and customer orders in a structured relational database.

The system demonstrates core SQL concepts such as table creation, relationships, joins, aggregate functions, subqueries, views, and CRUD operations.

Objectives -
Manage product information
Track stock availability
Store supplier details
Manage customer orders
Analyze sales and inventory data
Practice relational database design using SQL

Technologies Used
MySQL
SQL
MySQL Workbench

Database Tables
1. Categories
Stores product categories.

Example:

Electronics
Clothing
Furniture
Grocery
Stationery

2. Suppliers
Stores supplier information.

Fields:

supplier_id
supplier_name
phone
location

3. Products
Stores product details.

Fields:

product_id
product_name
price
category_id
supplier_id
stock

4. Orders
Stores customer order details.

Fields:

order_id
product_id
quantity
order_date
total_amount

5. Stock
Stores stock quantity information.

Fields:

stock_id
product_id
quantity_available
last_updated

Database Relationships
One Category → Many Products
One Supplier → Many Products
One Product → Many Orders
One Product → Many Stock Records

SQL Concepts Used
CREATE TABLE
PRIMARY KEY
FOREIGN KEY
SELECT
WHERE
ORDER BY
GROUP BY
HAVING
JOINS
Subqueries
Aggregate Functions
INSERT
UPDATE
DELETE
Views

Sample Queries

Find Out-of-Stock Products
SELECT *
FROM Products
WHERE stock = 0;

Calculate Total Inventory Value
SELECT SUM(price * stock) AS total_inventory_value
FROM Products;
Display Product and Category Names
SELECT p.product_name,
       c.category_name
FROM Products p
INNER JOIN Categories c
ON p.category_id = c.category_id;
Key Features
Product Management
Category Management
Supplier Management
Stock Tracking
Order Tracking
Inventory Analysis
Sales Analysis
Learning Outcomes
Through this project, I learned:

Relational Database Design
Primary and Foreign Keys
SQL Query Writing
Data Analysis using SQL
Table Relationships
Inventory and Sales Reporting
Database Normalization Basics
Future Enhancements
Stored Procedures
Triggers
User Authentication
Dashboard using Power BI
Web Interface Integration
Advanced Reporting
