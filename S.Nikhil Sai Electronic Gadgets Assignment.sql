
use TechShop;

create table Customers(
CustomerID int identity primary key,
Firstname varchar(30),
Lastname varchar(30),
Email varchar(300),
Phone varchar(15),
Address varchar(100));
INSERT INTO Customers (Firstname, Lastname, Email, Phone, Address) 
VALUES
    ('Alice', 'Smith', 'alice.smith@example.com', '1234567890', '123 Maple Street, New York, USA'),
    ('Bob', 'Johnson', 'bob.johnson@example.com', '2345678901', '456 Oak Avenue, Los Angeles, USA'),
    ('Carol', 'Williams', 'carol.williams@example.com', '3456789012', '789 Pine Road, Chicago, USA'),
    ('David', 'Brown', 'david.brown@example.com', '4567890123', '101 Elm Street, Houston, USA'),
    ('Eve', 'Jones', 'eve.jones@example.com', '5678901234', '202 Cedar Lane, Phoenix, USA'),
    ('Frank', 'Garcia', 'frank.garcia@example.com', '6789012345', '303 Birch Boulevard, Philadelphia, USA'),
    ('Grace', 'Martinez', 'grace.martinez@example.com', '7890123456', '404 Spruce Drive, San Antonio, USA'),
    ('Hank', 'Davis', 'hank.davis@example.com', '8901234567', '505 Aspen Circle, Dallas, USA'),
    ('Ivy', 'Miller', 'ivy.miller@example.com', '9012345678', '606 Willow Street, San Jose, USA'),
    ('Jack', 'Wilson', 'jack.wilson@example.com', '0123456789', '707 Redwood Avenue, Austin, USA');


 
select * from Customers


create table Products(
ProductID int primary key,
ProductName varchar(30),
Description varchar(30),
Price decimal(10,2),
);
INSERT INTO Products (ProductID, ProductName, Description, Price) 
VALUES
    (1001, 'Laptop', '15-inch display', 799.99),
    (1002, 'Smartphone', '64GB storage', 599.49),
    (1003, 'Headphones', 'Noise-canceling', 199.99),
    (1004, 'Smartwatch', 'Water-resistant', 249.89),
    (1005, 'Tablet', '10-inch screen', 349.99),
    (1006, 'Keyboard', 'Mechanical', 99.99),
    (1007, 'Mouse', 'Wireless', 29.99),
    (1008, 'Monitor', '4K resolution', 299.99),
    (1009, 'Printer', 'Laser', 159.99),
    (1010, 'External Hard Drive', '1TB storage', 79.99);

 

select * from Products


create table Orders(
OrderID int primary key,
CustomerID int,
OrderDate date,
TotalAmount decimal(10,2),
FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) 
VALUES
    (2001, 1, '2024-09-01', 150.75),
    (2002, 2, '2024-09-03', 299.99),
    (2003, 3, '2024-09-05', 89.49),
    (2004, 4, '2024-09-07', 450.00),
    (2005, 5, '2024-09-10', 210.30),
    (2006, 6, '2024-09-12', 320.00),
    (2007, 7, '2024-09-14', 499.99),
    (2008, 8, '2024-09-16', 120.20),
    (2009, 9, '2024-09-18', 75.00),
    (2010, 10, '2024-09-20', 60.99);

select * from Orders;


 


create table OrderDetails(
OrderDetailID int primary key,
OrderID int,
ProductID int,
Quantity int,
FOREIGN KEY(OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
FOREIGN KEY(ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) 
VALUES
    (3001, 2001, 1001, 20),
    (3002, 2002, 1002, 18),
    (3003, 2003, 1003, 35),
    (3004, 2004, 1004, 11),
    (3005, 2005, 1005, 25),
    (3006, 2006, 1006, 40),
    (3007, 2007, 1007, 52),
    (3008, 2008, 1008, 45),
    (3009, 2009, 1009, 20),
    (3010, 2010, 1010, 30);

select * from OrderDetails;



create table Inventory(
InventoryID int primary key,
ProductID int,
QuantityInStocks int,
LastStockUpdate date,
FOREIGN KEY(ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
);
INSERT INTO Inventory (InventoryID, ProductID, QuantityInStocks, LastStockUpdate) 
VALUES
    (4001, 1001, 50, '2024-09-01'),
    (4002, 1002, 30, '2024-09-02'),
    (4003, 1003, 20, '2024-09-03'),
    (4004, 1004, 15, '2024-09-04'),
    (4005, 1005, 25, '2024-09-05'),
    (4006, 1006, 40, '2024-09-06'),
    (4007, 1007, 60, '2024-09-07'),
    (4008, 1008, 10, '2024-09-08'),
    (4009, 1009, 35, '2024-09-09'),
    (4010, 1010, 45, '2024-09-10');

select * from Inventory;

--Task 2
--1.Extract Names,Email
select FirstName as Names, Email  from Customers;

--2.join Orders and Customers
select Orders.OrderId, Orders.OrderDate, Customers.FirstName
from Orders 
join Customers 
on Customers.CustomerID=Orders.CustomerID;

--3.Inserting new row
Insert into Customers values('Nikhil', 'Sai','nikhil@gmail.com',Null ,'Tirupati, India');
select * from Customers

--4.Update price by 10%
update Products
set Price=Price +(Price*0.1)
select * from Products

--5.delete a specific row from tables
declare @orderid int =2006;
delete from Orders where orderid=@orderid;
delete from OrderDetails where orderid=@orderid;
select * from Orders
select * from Orderdetails

--6. new row in Order Table
insert into Orders values(2006,6,'2024-09-06',489.98);
select * from Orders

--7.update customer
declare @customerid int =3;
update Customers
set Email = 'update@gmail.com',
    Phone =  '9456208136',
	Address = '243 canada'
	where CustomerID= @customerid;
select * from Customers

--8 recalculation the total cost in Orders
update Orders
set TotalAmount = (
    select sum(Products.Price * OrderDetails.Quantity)
     from Products, OrderDetails
	 where OrderDetails.ProductID = Products.ProductID   
      and OrderDetails.OrderID = Orders.OrderID);
select * from Orders;

--9 Delete all order
declare @customerID INT = 5;
 
delete from OrderDetails where OrderID IN (
    select OrderID from Orders
    where CustomerID = @customerID
);
delete from Orders
where CustomerID = @customerID;
select * from Orders
select * from OrderDetails
 
--10 inserting new electronic gadget

insert into Products values(1011, 'Earpods', '50hrs durability', 750);
select * from Products

--11 updating orders

alter table Orders add Status varchar(30);   
update Orders   
set Status = 'Pending'
declare @orderID int = 2001;
declare @newstatus varchar(20) ='Shipped';

update Orders  
set Status = @newstatus
where OrderID = @orderID;
select * from orders

--12 Total Orders placed
alter table Customers add Total_orders_placed int;

update Customers
SET Total_orders_placed = (
    SELECT count(Orders.CustomerID)
	from Orders
	where Orders.CustomerID=Customers.CustomerID);
select * from Customers


--Task 3

--1. Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.

select  OrderId, Customers.Firstname 
from Customers join Orders on Customers.CustomerID=Orders.CustomerID 

--2.  Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue.
select 
    P.ProductName, 
    sum(OD.Quantity * P.Price) as TotalRevenue
from
    Products P
join
    OrderDetails OD on P.ProductID = OD.ProductID
join
    Orders O on OD.OrderID = O.OrderID
group by
    P.ProductName;
 
--3.Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information. 
select
    Firstname,
    Lastname,
    Email,
    Phone,
    Address
from
    Customers 
join 
    Orders on Customers.CustomerID = Orders.CustomerID
group by Firstname, Lastname, Email, Phone, Address;

--4.Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.

select top 1 ProductName , Quantity from Products
join OrderDetails on OrderDetails.ProductID=Products.ProductID
order by Quantity desc;

--5.Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories.
alter table Products add Category varchar(40);
update Products
set Category='Electronic Gadgets';

select ProductName, Category from Products
where Category like 'Electronic%';

--6.Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value. 
select  
c.Firstname, 
c.Lastname, 
avg(o.TotalAmount) as Average_Amount
from Customers 
join Orders o on c.CustomerID = o.CustomerID
group by  c.FirstName, c.LastName;

--7.Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.
select Top 1
    O.OrderID, 
    C.CustomerID, 
    C.Firstname, 
    C.Lastname, 
    C.Email, 
    O.TotalAmount as Total_Revenue
from Customers C
join Orders O on O.CustomerID = C.CustomerID
order by O.TotalAmount desc;

--8.Write an SQL query to list electronic gadgets and the number of times each product has been ordered.
select P.ProductName, count(OD.ProductID) as Times_Ordered
from Products P
join OrderDetails OD on OD.ProductID=P.ProductID
group by P.ProductName

--9.Write an SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter.
declare @productname varchar(20) = 'Mouse';
select 
C.Firstname, 
C.Lastname, 
P.ProductName 
From Customers C
join Orders O on C.CustomerID = O.CustomerID
join OrderDetails OD on O.OrderID = OD.OrderID
join Products P on OD.ProductID = P.ProductID
where P.ProductName = @productname;

--10.Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.
declare @StartDate date = '2024-09-1'
declare @EndDate date = '2024-09-15'
select sum(TotalAmount) as TotalRevenue
from Orders
where OrderDate >= @StartDate and OrderDate <= @EndDate;
select * from Orders
 
 


--Task 4

--1.Write an SQL query to find out which customers have not placed any orders. 
select
    CustomerID, 
    Firstname, 
    Lastname
from 
    Customers
where 
    CustomerID NOT IN (select CustomerID from Orders);

--2.Write an SQL query to find the total number of products available for sale.  
select 
(select count(QuantityInStocks) from Inventory) 
as Available_For_Sale;

--3.Write an SQL query to calculate the total revenue generated by TechShop. 
select 
(select sum(TotalAmount) from Orders) 
as Total_Revenue_Generated;


--4.Write an SQL query to calculate the average quantity ordered for products in a specific category. Allow users to input the category name as a parameter. 
declare @categoryname varchar(50)='Electronic Gadgets';
select 
P.Category,
(select avg(Quantity) from OrderDetails) as Avg_Quantity
from Products P
join OrderDetails OD on P.ProductId=OD.ProductID
where P.Category = @categoryname
group by P.Category;

--5.Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter. 
declare @customerid int = 4;
select 
CustomerID,
(select sum(TotalAmount) from Orders where CustomerID= @customerid) as TotalRevenue 
from Orders
where CustomerID= @customerid
group by CustomerID


--6.Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed. 
select
FirstName, 
LastName, 
TotalOrders 
from (select Customers.FirstName, Customers.LastName, count(Orders.OrderID) as TotalOrders from Customers
      JOIN Orders on Orders.CustomerID = Customers.CustomerID
      group by Customers.FirstName, Customers.LastName) as CustomerOrders
	  order by TotalOrders desc;


--7.Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders.
select Category 
from (select max(quantity) as MaxQuantity, Products.Category 
      from OrderDetails
      join Products on Products.ProductID=OrderDetails.ProductID
      group by Products.Category) AS ProductsOrders;

	   
--8.Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending.
select 
C.Firstname,
C.Lastname,
O.TotalAmount
from Customers C
join Orders O on C.CustomerID=O.CustomerID
where O.TotalAmount = (select max(TotalAmount) from Orders)

--9.Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers.
select avg(TotalRevenue) as AverageOrderValue
from (select C.CustomerID, sum(O.TotalAmount) as TotalRevenue, count(O.OrderID) as NumberOfOrders from Customers C
     join Orders O on C.CustomerID = O.CustomerID
     group by C.CustomerID) AS RevenueData
where NumberOfOrders > 0;
 


--10.Write an SQL query to find the total number of orders placed by each customer and list their names along with the order count.
select
    FirstName, 
    LastName, 
    TotalSpent, 
    OrderCount
from(select sum(Orders.TotalAmount) as TotalSpent, 
            Customers.FirstName, 
            Customers.LastName, 
            count(Orders.OrderID) as OrderCount from Orders
            join Customers on Orders.CustomerID = Customers.CustomerID
            group by Customers.FirstName, Customers.LastName) as CustomerSpending;
	 