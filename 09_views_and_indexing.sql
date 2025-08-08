-- Creating a sample table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

-- Inserting sample records
INSERT INTO Products VALUES
(1, 'Laptop', 55000.00, 30),
(2, 'Mouse', 400.00, 150),
(3, 'Keyboard', 1200.00, 100),
(4, 'Monitor', 15000.00, 25);

-- Viewing all products
SELECT * FROM Products;

-- Output:
-- +-----------+--------------+----------+--------+
-- | ProductID | ProductName  | Price    | Stock  |
-- +-----------+--------------+----------+--------+
-- | 1         | Laptop       | 55000.00 | 30     |
-- | 2         | Mouse        | 400.00   | 150    |
-- | 3         | Keyboard     | 1200.00  | 100    |
-- | 4         | Monitor      | 15000.00 | 25     |
-- +-----------+--------------+----------+--------+

-- Creating a view for products with price above 1000
CREATE VIEW Expensive_Products AS
SELECT ProductID, ProductName, Price
FROM Products
WHERE Price > 1000;

-- Selecting from the view
SELECT * FROM Expensive_Products;

-- Output:
-- +-----------+--------------+----------+
-- | ProductID | ProductName  | Price    |
-- +-----------+--------------+----------+
-- | 1         | Laptop       | 55000.00 |
-- | 3         | Keyboard     | 1200.00  |
-- | 4         | Monitor      | 15000.00 |
-- +-----------+--------------+----------+

-- Updating the base table via view
UPDATE Expensive_Products
SET Price = Price + 500
WHERE ProductID = 3;

-- Checking updated data
SELECT * FROM Products;

-- Output:
-- +-----------+--------------+----------+--------+
-- | ProductID | ProductName  | Price    | Stock  |
-- +-----------+--------------+----------+--------+
-- | 1         | Laptop       | 55000.00 | 30     |
-- | 2         | Mouse        | 400.00   | 150    |
-- | 3         | Keyboard     | 1700.00  | 100    |
-- | 4         | Monitor      | 15000.00 | 25     |
-- +-----------+--------------+----------+--------+

-- Creating an index on Price column
CREATE INDEX idx_price ON Products(Price);

-- Showing indexed column (will differ by DBMS)
-- (No standard SQL query to display index, but in MySQL: SHOW INDEX FROM Products;)

-- Dropping the view
DROP VIEW Expensive_Products;

-- Dropping index (syntax differs slightly across DBs)
DROP INDEX idx_price ON Products;

-- Dropping the table
DROP TABLE Products;
