create database inventory;

use inventory;

-- creating tables categories,suppliers,products,orders,stock

-- 1.Categories table
create table categories
(
  category_id int primary key,
  category_name varchar(100)
  );
  
-- 2,Suppliers table
create table suppliers
(
   supplier_id int primary key,
   supplier_name varchar(100),
   phone varchar(15),
   location varchar(100)
);

-- 3.Products table
create table products
(
  product_id int primary key,
  product_name varchar(100) not null,
  price decimal(10,2),
  category_id int,
  supplier_id int,
  stock int
);

-- 4.Orders table
create table orders
(
  order_id int primary key,
  product_id int,
  quantity int,
  order_date date,
  total_amount decimal(10,2),
  foreign key (product_id) references products(product_id)
); 

-- 5.Stock table
create table stock
(
  stock_id int primary key,
  product_id int,
  quantity_available int,
  last_updated date,
  foreign key (product_id) references products(product_id)
);

show tables;
-- inserting data into tables
-- 1.insert categories
insert categories values
(1, 'electronics'),
(2, 'clothing'),
(3, 'furniture'),
(4, 'groceries'),
(5, 'stationery');

select * from categories;

-- 2.insert suppliers
insert suppliers values
(101,'Tech solutions','9876543210','Hyderabad'),
(102, 'Fashion hub','9876543211','Vijayawada'),
(103, 'Home essentials','9876543212' , 'Hyderabad'),
(104, 'Fresh mart','9876543213','Guntur'),
(105, 'Smart suppliers','9876543214','Chennai'),
(106, 'Global traders','9876543215','Bengaluru'),
(107, 'Infra','9876867583','Vizag');

select * from suppliers;

-- insert products values
insert into products values
(1, 'Laptop', 55000, 1, 101, 10),
(2, 'Mobile Phone', 18000, 1, 101, 25),
(3, 'T-Shirt', 450, 2, 102, 50),
(4, 'Jeans', 1200, 2, 102, 8),
(5, 'Office Chair', 3500, 3, 103, 5),
(6, 'Dining Table', 12000, 3, 103, 0),
(7, 'Rice Bag', 800, 4, 104, 40),
(8, 'Cooking Oil', 600, 4, 104, 3),
(9, 'Notebook', 80, 5, 105, 100),
(10, 'Printer', 7500, 1, 101, 4),
(11, 'Water Bottle', 300, 5, 105, 20); 

-- insert orders values
 insert into orders values
(1001, 1, 2, '2026-01-05', 110000),
(1002, 2, 3, '2026-01-10', 54000),
(1003, 3, 5, '2026-01-15', 2250),
(1004, 4, 2, '2026-02-02', 2400),
(1005, 1, 1, '2026-02-10', 55000),
(1006, 5, 2, '2026-02-15', 7000),
(1007, 7, 10, '2026-03-01', 8000),
(1008, 8, 4, '2026-03-05', 2400),
(1009, 2, 2, '2026-03-12', 36000),
(1010, 10, 1, '2026-03-20', 7500),
(1011, 9, 20, '2026-04-01', 1600),
(1012, 11, 5, '2026-04-05', 1500),
(1013, 1, 1, '2026-04-10', 55000),
(1014, 4, 3, '2026-04-15', 3600);

-- insert into stock
insert into stock values
(1, 1, 10, '2026-04-01'),
(2, 2, 25, '2026-04-01'),
(3, 3, 50, '2026-04-01'),
(4, 4, 8, '2026-04-01'),
(5, 5, 5, '2026-04-01'),
(6, 6, 0, '2026-04-01'),
(7, 7, 40, '2026-04-01'),
(8, 8, 3, '2026-04-01'),
(9, 9, 100, '2026-04-01'),
(10, 10, 4, '2026-04-01'),
(11, 11, 20, '2026-04-01');
  
select * from products;    
select * from orders;
select * from stock;  

-- Basic queries
#1.Display products with price greater than 500 
select * from products 
where price >500;

#2.Show products with low stock
##Here taking low stock as less than 10
select * from products
where stock < 10;

#3.List products by category
select * from products
where category_id = 2;

#4. Display suppliers froma specfic location
##Here location to find is 'Guntur'
select * from suppliers
where location = 'Guntur';

-- Joins
#1. Show product name with category
##Here to show  product name with category i used inner join(displays the rows that match in both tables)
select 
    p.product_name,
	c.category_name
from products p 
inner join  categories c 
on p.category_id=c.category_id;

#2.Display supplier with products
select 
    s.supplier_name,
    p.product_name
from suppliers s  
inner join  products p
on s.supplier_id=p.supplier_id;

#3.Show order details with product information
select 
    o.order_id,
    p.product_name,
    o.quantity,
    o.order_date,
    o.total_amount
from orders o
inner join products p 
on o.product_id=p.product_id;

-- Aggregate
#1.Count total products
select 
count(*)  as total_products from products;

#2.Find average product price
select avg(price) as avg_product_price from products;

#3.Calculate total inventory value
##inventory value = product price * available stock
select sum(price * stock ) as total_inventory_value from products;

#4.Find highest price product
select * from products
where price=(
              select max(price)
              from products
            );  

-- Subqueries
#1.Find products never ordered
select * from products 
where product_id not in (
  select  product_id 
   from orders);   
   
#2.Show products above average price
 select * from products
 where price >(
   select avg(price) as avg_price
   from products);
 
 #3.Find suppliers with no products
 select * from suppliers
 where supplier_id not in (
    select supplier_id 
    from products
    where supplier_id is not null);
    
-- Updates & Deletes
#1.Update product price    
update products
set price = 6000.00
where product_id = 1;

select * from products where product_id=1;

#2.Update stock quantity
update products
set stock = 15
where product_id = 4;

select * from products where product_id=4;

#3.Delete out=of stock products
select * from products where stock=0;

DELETE FROM Products
WHERE stock = 0
AND NOT EXISTS (
    SELECT 1
    FROM Orders
    WHERE Orders.product_id = Products.product_id
);
-- Views
#1.Create view for product details
create view product_detail as
select
     p.product_id,
     p.product_name,
     p.price,
     p.stock,
     c.category_name,
     s.supplier_name
from products p 
inner join categories c
on p.category_id=c.category_id
inner join suppliers s 
on p.supplier_id=s.supplier_id;  

select * from product_detail; 

#2.Create view for stock summary(inner join)
CREATE VIEW stock_summary AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    s.supplier_name,
    st.quantity_available,
    p.price
FROM Products p
JOIN Categories c
    ON p.category_id = c.category_id
JOIN Suppliers s
    ON p.supplier_id = s.supplier_id
JOIN Stock st
    ON p.product_id = st.product_id;  
    
select * from stock_summary;    

-- Stored procedures
#1.1. Insert a New Product
#COALESCE(MAX(product_id), 0) + 1 = Get the highest product ID and add 1 to generate 
#the next product ID (or return 1 if the table is empty)

DROP PROCEDURE IF EXISTS insert_product;
delimiter $$

create procedure insert_product
(
  in pro_name varchar(100),
  in pro_price decimal(10,2),
  in pro_category_id int,
  in pro_supplier_id int,
  in pro_stock int
)
begin
    insert into products
(
  product_id,
  product_name,
  price,
  category_id,
  supplier_id,
  stock
)
values(
    (select coalesce(max(product_id),0) + 1 
    from (select product_id from products) as temp),
    pro_name,
    pro_price,
    pro_category_id,
    pro_supplier_id,
    pro_stock
);
end $$

delimiter ;

call insert_product
(
  'Keyboard',
  900,
  1,
  101,
  20
);  

select * from products;

#2.Update product price
delimiter $$

create procedure update_prod_price
(
  in p_product_id int,
  in p_new_price decimal(10,2)
)
begin
    update products
    set price=p_new_price
    where product_id = p_product_id;
 end $$
 
 delimiter ;
 
 call update_prod_price(2,20000);
 
 select * from products where product_id=2;

#3.Display orders of a product
DROP PROCEDURE IF EXISTS get_product_orders;

delimiter $$

create procedure get_product_orders
(
   in p_product_id int
)
begin 
    select 
    o.order_id,
    p.product_name,
    o.quantity,
    o.order_date,
    o.total_amount
  from orders o
  inner join products p 
   on o.product_id = p.product_id
where o.product_id = p.product_id;

end $$

delimiter ;

call get_product_orders(1);

#4.
DROP PROCEDURE IF EXISTS calculate_inventory_value;

DELIMITER //

CREATE PROCEDURE calculate_inventory_value()
BEGIN
    SELECT
        COALESCE(SUM(price * stock), 0) AS total_inventory_value
    FROM Products;
END //

DELIMITER ;

CALL calculate_inventory_value();

#5.
drop procedure if exists get_products_by_category;
DELIMITER //

CREATE PROCEDURE get_products_by_category(
    IN p_category_id INT
)
BEGIN
    SELECT
        product_id,
        product_name,
        price,
        stock
    FROM Products
    WHERE category_id = p_category_id;
END //

DELIMITER ;

CALL get_products_by_category(1);

SHOW PROCEDURE STATUS
WHERE Db = 'inventory_db';

-- Report/Analysis
#1.Top 5 most sold products
select 
    p.product_name,
    sum(o.quantity) as total_sold
from products p 
inner join orders o 
on p.product_id= o.product_id
group by p.product_id,p.product_name
order by total_sold desc
limit 5;    

#2.Most active suppliers
select 
    s.supplier_name,
    count(o.order_id) as total_orders
from suppliers s 
inner join products p 
on s.supplier_id=p.supplier_id
inner join orders o 
on p.product_id=o.product_id
group by s.supplier_id,s.supplier_name
order by total_orders desc;    

#3.Monthly sales report
select
    month(order_date) as monthly_sales,
    sum(total_amount) as total_sales
from orders
group by month(order_date)
order by monthly_sales;

#4.Product generating highest revenue
select
   p.product_name,
   sum(o.total_amount) as total_revenue
from products p 
inner join orders o 
on p.product_id=o.product_id
group by p.product_id,p.product_name
order by total_revenue desc;  

#5.Inventory value analysis (product.price * product.stock) =inventory
select
   c.category_name,
   sum(p.price * p.stock) as inventory_value
from categories c 
inner join products p 
on c.category_id = p.category_id
group by c.category_id,c.category_name
order by inventory_value desc;   
#desc - high to low , asc - low to high
#6.Low stocks product report
select
    product_name,
    stock,
    price
from Products
where stock < 10
order by stock asc;