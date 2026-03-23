-- creating table for retail dataset
CREATE TABLE retail_data (
    InvoiceNo TEXT,
    StockCode TEXT,
    Description TEXT,
    Quantity INTEGER,
    InvoiceDate TIMESTAMP,
    UnitPrice FLOAT,
    CustomerID FLOAT,
    Country TEXT,
    Revenue FLOAT,
    Year INTEGER,
    Month INTEGER,
    Day INTEGER,
    Hour INTEGER
);
-- checking total records loaded
SELECT COUNT(*) AS total_rows
FROM retail_data;
-- previewing sample data
SELECT * 
FROM retail_data
LIMIT 10;
-- checking missing customer IDs
SELECT COUNT(*) AS missing_customers
FROM retail_data
WHERE CustomerID IS NULL;
-- checking for negative or zero quantity
SELECT COUNT(*) AS invalid_quantity
FROM retail_data
WHERE Quantity <= 0;
-- checking for negative or zero price
SELECT COUNT(*) AS invalid_price
FROM retail_data
WHERE UnitPrice <= 0;
-- checking duplicate transactions
SELECT InvoiceNo, COUNT(*) 
FROM retail_data
GROUP BY InvoiceNo
HAVING COUNT(*) > 1;
-- total revenue generated
SELECT SUM(Revenue) AS total_revenue
FROM retail_data;
-- average revenue per transaction
SELECT AVG(Revenue) AS avg_order_value
FROM retail_data;
-- monthly revenue trend
SELECT 
    Month,
    SUM(Revenue) AS monthly_revenue
FROM retail_data
GROUP BY Month
ORDER BY Month;
-- hourly sales pattern
SELECT 
    Hour,
    SUM(Revenue) AS hourly_sales
FROM retail_data
GROUP BY Hour
ORDER BY Hour;
-- revenue by country (top markets)
SELECT 
    Country,
    SUM(Revenue) AS revenue
FROM retail_data
GROUP BY Country
ORDER BY revenue DESC;
-- number of orders by country
SELECT 
    Country,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM retail_data
GROUP BY Country
ORDER BY total_orders DESC;
-- top 10 products by revenue
SELECT 
    Description,
    SUM(Revenue) AS revenue
FROM retail_data
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;
-- most sold products (by quantity)
SELECT 
    Description,
    SUM(Quantity) AS total_quantity
FROM retail_data
GROUP BY Description
ORDER BY total_quantity DESC
LIMIT 10;
-- top customers by spending
SELECT 
    CustomerID,
    SUM(Revenue) AS total_spent
FROM retail_data
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;
-- customer purchase frequency
SELECT 
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS order_count
FROM retail_data
GROUP BY CustomerID
ORDER BY order_count DESC;
-- basic customer segmentation (frequency + monetary)
SELECT 
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS frequency,
    SUM(Revenue) AS monetary
FROM retail_data
GROUP BY CustomerID
ORDER BY monetary DESC;
-- observation: certain countries and customers contribute majority of revenue
-- will validate these insights further in dashboard