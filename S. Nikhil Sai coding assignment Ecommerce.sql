use Ecommerce

create table customers(
customerid int IDENTITY PRIMARY KEY,
name varchar(20),
email varchar(300),
password varchar(300)
);



create table products(
productid int PRIMARY KEY,
name varchar(30),
description varchar(200),
price decimal(10,2),
stockQuantity int
);


create table cart(
cartid int PRIMARY KEY,
customerid INT,
productid INT,
Quantity INT, 
FOREIGN KEY(customerid) REFERENCES customers(customerid) ON DELETE CASCADE,
FOREIGN KEY(productid) REFERENCES products(productid) ON DELETE CASCADE
);


create table orders(
orderid int PRIMARY KEY,
customerid INT,
orderdate date,
totalamount decimal(10,2), 
FOREIGN KEY(customerid) REFERENCES customers(customerid) ON DELETE CASCADE
);

 
create table orderitems(
orderitemid int PRIMARY KEY,
orderid INT,
productid INT,
Quantity INT, 
itemamount decimal(10,2),
FOREIGN KEY(orderid) REFERENCES orders(orderid) ON DELETE CASCADE,
FOREIGN KEY(productid) REFERENCES products(productid) ON DELETE CASCADE
);

 
INSERT INTO customers VALUES 
('Rahul Sharma', 'rahul.sharma@example.com', 'rahul1234'),
('Priya Kapoor', 'priya.kapoor@example.com', 'priya_secure'),
('Anjali Mehta', 'anjali.mehta@example.com', 'mehta2024'),
('Vikram Singh', 'vikram.singh@example.com', 'vikram!789'),
('Sneha Patel', 'sneha.patel@example.com', 'patel#567'),
('Rohit Verma', 'rohit.verma@example.com', 'rohit_pass'),
('Kavita Nair', 'kavita.nair@example.com', 'kavita_123'),
('Arjun Rao', 'arjun.rao@example.com', 'arjun987'),
('Meera Iyer', 'meera.iyer@example.com', 'meera$pass'),
('Sanjay Gupta', 'sanjay.gupta@example.com', 'gupta@2024');
 select * from customers

INSERT INTO products VALUES
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);
select * from products

INSERT INTO cart VALUES
(1, 1, 1, 2),
(2, 1,3, 1),
(3, 2,2, 3),
(4, 3, 4, 4),
(5,3, 5, 2),
(6, 4,6, 1),
(7, 5, 1, 1),
(8,6,10,2),
(9, 6, 9,3),
(10, 7, 7,2);
select * from cart

INSERT INTO orders VALUES
(1, 1, '2023-01-05', 1200.00),
(2, 2, '2023-02-10', 900.00),
(3, 3, '2023-03-15', 300.00),
(4, 4, '2023-04-20', 150.00),
(5, 5, '2023-05-25', 1800.00),
(6, 6, '2023-06-30', 400.00),
(7, 7, '2023-07-05', 700.00),
(8, 8, '2023-08-10', 160.00),
(9, 9, '2023-09-15', 140.00),
(10, 10, '2023-10-20', 1400.00);
select * from orders

INSERT INTO orderitems VALUES
(1,1,1,2,1600.00),
(2,1,3,1,300.00),
(3,2,2,3,1800.00),
(4,3,5,2,1800.00),
(5,4,4,4,600.00),
(6,4,6,1,50.00),
(7,5,1,1,800.00),
(8,5,2,2,200.00),
(9,6,10,2,240.00),
(10,6,9,3,210.00);
select * from orderitems

--Tasks

--1.Update refrigerator product price to 800. 
update products
set price=800 
where name like 'Refrigerator';
select * from products

--2.Remove all cart items for a specific customer. 
delete  from cart
where customerid=3
select * from cart

--3.Retrieve Products Priced Below $100. 
select name, price from products
where price<100;

--4.Find Products with Stock Quantity Greater Than 5.
select name, stockquantity from products
where stockquantity > 5;

--5.Retrieve Orders with Total Amount Between $500 and $1000. 
select  * from orders
where totalamount>500 and totalamount<1000; 

--6.Find Products which name end with letter ‘r’.
select * from  products
where name like '%r'

--7.Retrieve Cart Items for Customer 5. 
select * from cart
where customerid=5

--8.Find Customers Who Placed Orders in 2023.
select c.name, o.orderdate 
from customers c
join orders o on c.customerid=o.customerid
where orderdate like '2023%'


--9.Determine the Minimum Stock Quantity for Each Product Category. 
 

alter table products
add category varchar(70);
update products 
set category = 'Electronics' 
where productid IN (1, 2, 3, 5, 6, 8);
update products 
set category = 'Accessories' 
where productid IN (4,7,9,10);
 

select category, min(stockQuantity) as min_stock_quantity
from products 
group by category;
   
   
--10. Calculate the Total Amount Spent by Each Customer. 
select customers.name, 
sum(orders.totalamount) as TotalAmount
from customers
JOIN orders
on customers.customerid = orders.customerid
group by customers.name;


--11.Find the Average Order Amount for Each Customer. 
select 
c.customerid,
c.name,
avg(o.totalamount) as Avgamount
from customers c
join orders o on c.customerid=o.customerid
group by c.customerid, c.name
order by Avgamount desc


--12.Count the Number of Orders Placed by Each Customer. 
select customers.name, 
count(orders.orderid) as No_of_Orders
from customers
JOIN orders
on customers.customerid = orders.customerid
group by customers.name;


--13.Find the Maximum Order Amount for Each Customer. 
SELECT 
c.customerid,
c.name,
max(o.totalamount) as maxamount
from customers c
join orders o on c.customerid=o.customerid
group by c.customerid, c.name;



--14.Get Customers Who Placed Orders Totaling Over $1000.
select 
c.customerid, 
c.name, 
sum(o.totalamount) as total_spent
from customers c
JOIN orders o on c.customerid = o.customerid
group by c.customerid, c.name
having sum(o.totalamount) > 1000;

--15.Subquery to Find Products Not in the Cart.
select 
p.productid,
p.name
from products p
where p.productid not in (select productid from cart);

--16.Subquery to Find Customers Who Haven't Placed Orders. 
select 
customerid, 
name 
from  customers 
where customerid not in (select customerid from customers);

--17.Subquery to Calculate the Percentage of Total Revenue for a Product. 
select p.productid, p.name, (sum(oi.Quantity * p.price) / (select sum(oi.Quantity * p.price) 
       from orderitems oi 
       JOIN products p on oi.productid = p.productid)) * 100 as revenue_percentage
from orderitems oi
join products p on oi.productid = p.productid
group by p.productid, p.name;
 

--18.Subquery to Find Products with Low Stock. 
select 
name,
stockquantity as lowstock_quantity
from products 
where stockquantity < (select avg(stockquantity) from products);

--19.Subquery to Find Customers Who Placed High-Value Orders. 
select
name, customerid from customers
where customerid in 
(select customerid from orders where totalamount > (select avg(totalamount) from orders));

