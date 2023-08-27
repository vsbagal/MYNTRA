-- Create Database for Myntra
CREATE DATABASE Myntra;
USE Myntra;

-- Create tables

-- Table for users/customers
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    RegistrationDate DATE
);
-- Insert Values
INSERT INTO Users (UserID, Username, Email, RegistrationDate)
VALUES
	(1, 'john_doe', 'john@example.com', '2023-01-15'),
    (2, 'jane_smith', 'jane@example.com', '2023-02-10'),
    (6, 'Amit Sharma', 'amit@example.com', '2022-03-15'),
    (7, 'Riya Patel', 'riya@example.com', '2022-05-20'),
    (8, 'Sandeep Mehta', 'sandeep@example.com', '2022-07-10'),
    (9, 'Priya Singh', 'priya@example.com', '2022-09-08'),
    (10, 'Rahul Gupta', 'rahul@example.com', '2022-10-25'),
    (11, 'Neha Verma', 'neha@example.com', '2022-11-30'),
    (12, 'Saurabh Kumar', 'saurabh@example.com', '2023-01-18'),
    (13, 'Kavita Choudhary', 'kavita@example.com', '2023-03-05'),
    (14, 'Vikram Rana', 'vikram@example.com', '2023-04-12'),
    (15, 'Anjali Khanna', 'anjali@example.com', '2023-06-07');

-- Table for products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(200) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);
-- Insert Values
INSERT INTO Products (ProductID, Name, Category, Price, StockQuantity)
VALUES
	(101, 'Cotton T-Shirt', 'Clothing', 2500.99, 100),
    (102, 'Running Shoes', 'Footwear', 4999.99, 50),
    (106, 'Elegant Saree', 'Clothing', 2999.99, 50),
    (107, 'Formal Shirt', 'Clothing', 899.99, 100),
    (108, 'Leather Belt', 'Fashion Accessories', 499.99, 200),
    (109, 'Casual Jeans', 'Clothing', 1299.99, 75),
    (110, 'Sports Shoes', 'Footwear', 1499.99, 50),
    (111, 'Stylish Watch', 'Fashion Accessories', 799.99, 150),
    (112, 'Funky T-shirt', 'Clothing', 599.99, 100),
    (113, 'Classic Sunglasses', 'Fashion Accessories', 699.99, 80),
    (114, 'Ethnic Kurta', 'Clothing', 899.99, 60),
    (115, 'Trendy Backpack', 'Fashion Accessories', 1199.99, 40);
    
-- Table for orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    UserID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
-- Insert Values
INSERT INTO Orders (OrderID, UserID, OrderDate, TotalAmount)
VALUES
    (1001, 1, '2023-03-20', 9999.98),
    (1002, 2, '2023-04-05', 3499.98),
    (1005, 6, '2022-04-10', 1799.98),
    (1006, 7, '2022-06-20', 1299.97),
    (1007, 8, '2022-08-02', 3999.96),
    (1008, 9, '2022-10-15', 2599.95),
    (1009, 10, '2022-12-05', 3199.94),
    (1010, 11, '2023-02-22', 1799.93),
    (1011, 12, '2023-04-08', 899.92),
    (1012, 13, '2023-05-25', 2299.91),
    (1013, 14, '2023-07-14', 2999.90),
    (1014, 15, '2023-08-28', 1799.89);

-- Table for order items
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Values
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Price)
VALUES
	(2001, 1001, 101, 2, 5100.98),
    (2002, 1001, 102, 1, 4900.99),
    (2006, 1005, 107, 2, 1799.98),
    (2007, 1005, 109, 1, 1299.99),
    (2008, 1006, 110, 1, 1499.99),
    (2009, 1006, 112, 1, 599.99),
    (2010, 1007, 106, 1, 2999.99),
    (2011, 1007, 108, 2, 999.98),
    (2012, 1008, 113, 1, 699.99),
    (2013, 1009, 114, 1, 899.99),
    (2014, 1010, 111, 1, 799.99),
    (2015, 1011, 115, 1, 1199.99);
