/*
Easy Problem Statements:
1. Retrieve User Information: Fetch the details of a specific users by providing their UserID.*/
SELECT * FROM Users 
WHERE UserID BETWEEN '8' AND '11';

-- 2. Total Orders: Calculate the total number of orders made by a given user UserID = 2.
SELECT COUNT(OrderID) AS TotalOrders, UserID 
FROM Orders
WHERE UserID = '2';

-- 3. Product Availability: Check if a specific product is currently in stock ProductID=109.
SELECT Name, StockQuantity FROM Products
WHERE ProductID = '109';

-- 4. Recent Orders: Retrieve the latest 5 orders along with their order dates for a particular user.
SELECT OrderID, OrderDate FROM Orders 
WHERE UserID = '9'
ORDER BY OrderDate DESC 
LIMIT 5;

-- 5. Product Count: Count the total number of products available in a certain category(Clothing).
SELECT SUM(StockQuantity) AS TotalQuantity 
	FROM Products
	WHERE Category ='Clothing';
    
-- 6. Order Amount: Calculate the total amount spent by a user on a specific order(1008 AND 1009).
SELECT UserID, OrderID, TotalAmount 
	FROM Orders
	WHERE OrderID IN (1008, 1009);
    
-- 7. Popular Category: Find the category with the highest number of products.
SELECT COUNT(*) AS ProductCount, Category 
FROM Products 
GROUP BY Category
ORDER BY ProductCount DESC LIMIT 1;

-- 8. Average Price: Calculate the average price of products in a given category(Footwear).
SELECT AVG(Price) AS AveragePrice, Category
FROM Products 
WHERE Category = 'Footwear';

-- 9. Registration Month: Display the usernames and registration months of users who registered in the same month.
SELECT Username, DATE_FORMAT(RegistrationDate, '%M %Y') AS RegistrationMonth
FROM Users
GROUP BY RegistrationMonth, Username
HAVING COUNT(*) > 1
ORDER BY RegistrationMonth, Username;

SELECT Username, DATE_FORMAT(RegistrationDate, '%M %Y') AS RegistrationMonth
FROM Users
GROUP BY RegistrationMonth, Username 
HAVING RegistrationMonth LIKE '%RegistrationMonth%'
ORDER BY Username;

-- 10. Order Date Range: Retrieve orders made between a specified start and end date.
SELECT * FROM Orders 
WHERE OrderDate BETWEEN '2022-02-22' AND '2022-08-22';

/*Moderate Problem Statements:
11. Top Buyers: List the top 5 users who have made the highest Amount of orders.*/
SELECT Orders.UserID, Orders.TotalAmount, Users.Username FROM Orders
JOIN Users 
ON Orders.UserID = Users.UserID
ORDER BY Orders.TotalAmount 
DESC LIMIT 5;

-- 12. Expensive Orders: Retrieve the details of orders with a total amount greater than a 4000.00 value.
SELECT OrderID, UserID, OrderDate, TotalAmount
FROM Orders
WHERE TotalAmount > '4000.00';

-- 13. User Order History: Display the complete order history of a user 9, including product names, quantities, and order dates.
SELECT * FROM Orders
WHERE UserID = 9;

-- 14. Low Stock Products: List products that are currently low in stock (quantity less than 50).
SELECT * FROM Products 
WHERE StockQuantity < 50;

-- 15. User Loyalty: Calculate the average time between consecutive orders for a specific user.
SELECT AVG(DATEDIFF(O2.OrderDate, O1.OrderDate)) AS AverageTimeBetweenOrders
FROM Orders AS O1
JOIN Orders AS O2 ON O1.OrderID = O2.OrderID - 1
WHERE O1.UserID = 12;

-- 16. Category Revenue: Determine the total revenue generated from Top 3 category's products.
SELECT Category, SUM(Price) AS TotalRevenue FROM Products 
GROUP BY Category 
ORDER BY TotalRevenue DESC LIMIT 3;

-- 17. Inactive Users: Identify users who haven't placed any orders in the last 6 months.
SELECT Orders.UserID, Orders.OrderID, Orders.OrderDate, Users.UserName FROM Orders
JOIN Users ON Orders.UserID = Users.UserID
WHERE OrderDate <= DATE_SUB(current_date(), INTERVAL 6 MONTH);

-- 18. Order Item Count: Count the total number of items in each order and display the results.
SELECT COUNT(Quantity), OrderID FROM OrderItems
GROUP BY OrderID;

-- 19. Product Recommendations: Suggest products to a user based on their previous order history.
SELECT DISTINCT P.ProductID, P.Name, P.Category, P.Price
FROM Products AS P
JOIN OrderItems AS OI ON P.ProductID = OI.ProductID
JOIN Orders AS O ON OI.OrderID = O.OrderID
LIMIT 5;

-- 20. Frequent Buyers: Find users who have made more than 5 orders in the last 6 months.
SELECT O.UserID, U.Username, COUNT(O.OrderID) AS OrderCount
FROM Orders AS O
JOIN Users AS U ON O.UserID = U.UserID
WHERE O.OrderDate >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY O.UserID, U.Username
HAVING OrderCount > 5;

-- Advanced Problem Statements:
-- 21. Revenue Trend: Create a monthly revenue trend report for the last year, showing revenue for each month.
SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS Month, SUM(TotalAmount) AS Revenue
FROM Orders
WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY Month
ORDER BY Month;

-- 22. User Churn Analysis: Identify users who haven't placed an order in the last 6 months and classify them as potential churn cases.
SELECT UserID, OrderDate, OrderID FROM Orders
WHERE OrderDate <= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

SELECT U.UserID, U.Username
FROM Users AS U
LEFT JOIN (
    SELECT DISTINCT UserID
    FROM Orders
    WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
) AS ActiveUsers ON U.UserID = ActiveUsers.UserID
WHERE ActiveUsers.UserID IS NULL;

-- 23. Order Diversity: Determine the average number of different product categories in each order.
SELECT AVG(CategoryCount) AS AvgCategoryCount
FROM (
    SELECT O.OrderID, COUNT(DISTINCT P.Category) AS CategoryCount
    FROM Orders AS O
    JOIN OrderItems AS OI ON O.OrderID = OI.OrderID
    JOIN Products AS P ON OI.ProductID = P.ProductID
    GROUP BY O.OrderID
) AS OrderCategoryCounts;

-- 24. Price Elasticity: Analyze how changes in product prices affect the quantity of products ordered.
SELECT P.Price, AVG(OI.Quantity) AS AvgQuantity
FROM Products AS P
JOIN OrderItems AS OI ON P.ProductID = OI.ProductID
GROUP BY P.Price
ORDER BY P.Price;

-- 25. User Segmentation: Segment users into high, medium, and low spenders based on their total order amounts.
SELECT CASE 
	WHEN TotalAmount>0 AND TotalAmount = 500 THEN 'LOW'
	WHEN TotalAmount>501 AND TotalAmount< 2000 THEN 'MEDIUM'
    WHEN TotalAmount >2001 AND TotalAmount < 10000 THEN 'HIGH'
    END AS PurchasePower, UserID
    FROM Orders 
    ORDER BY PurchasePower;

-- 26. Product Bundle Analysis: Identify products that are often purchased together in the same order.
SELECT DISTINCT OI1.ProductID, OI2.ProductID
FROM OrderItems AS OI1
JOIN OrderItems AS OI2 ON OI1.OrderID = OI2.OrderID AND OI1.ProductID < OI2.ProductID
GROUP BY OI1.ProductID, OI2.ProductID
HAVING COUNT(*) >= 5
ORDER BY COUNT(*) DESC;

-- 27. Inventory Management: Develop a query to help restock products when their quantity goes below a certain threshold.
SELECT StockQuantity,
       CASE 
           WHEN StockQuantity > 50 THEN 'Enough Stock Available'
           WHEN StockQuantity < 50 OR StockQuantity = 50 THEN 'Restock Products'
       END AS StockThreshold
FROM Products
ORDER BY StockQuantity;

-- 28. User Cohort Analysis: Study the buying behavior of users who registered in the same month over time.
SELECT DATE_FORMAT(O.OrderDate, '%Y-%m') AS OrderMonth, COUNT(DISTINCT U.UserID) AS UserCount, COUNT(O.OrderID) AS OrderCount
FROM Orders AS O
JOIN Users AS U ON O.UserID = U.UserID
WHERE DATE_FORMAT(O.OrderDate, '%Y-%m')
GROUP BY OrderMonth
ORDER BY OrderMonth;

-- 30. Seasonal Patterns: Analyze whether certain product categories sell more during specific months of the year.
SELECT P.Category, DATE_FORMAT(O.OrderDate, '%Y-%m') AS OrderMonth, COUNT(O.OrderID) AS OrderCount
FROM Orders AS O
JOIN OrderItems AS OI ON O.OrderID = OI.OrderID
JOIN Products AS P ON OI.ProductID = P.ProductID
GROUP BY P.Category, OrderMonth
ORDER BY P.Category, OrderMonth;
