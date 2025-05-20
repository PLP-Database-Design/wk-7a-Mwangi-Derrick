-- Question 1: Achieving 1NF (First Normal Form)

-- Transform ProductDetail table into 1NF
-- Original table (for reference):
-- OrderID | CustomerName | Products
-- 101     | John Doe     | Laptop, Mouse
-- 102     | Jane Smith   | Tablet, Keyboard, Mouse
-- 103     | Emily Clark  | Phone

-- Create a new 1NF-compliant table
CREATE TABLE OrderDetails_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert data in 1NF format (one product per row)
INSERT INTO OrderDetails_1NF (OrderID, CustomerName, Product)
VALUES 
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');


-- Question 2: Achieving 2NF (Second Normal Form)

-- Transform OrderDetails table into 2NF
-- Original table (for reference):
-- OrderID | CustomerName | Product   | Quantity
-- 101     | John Doe     | Laptop    | 2
-- 101     | John Doe     | Mouse     | 1
-- 102     | Jane Smith   | Tablet    | 3
-- 102     | Jane Smith   | Keyboard  | 1
-- 102     | Jane Smith   | Mouse     | 2
-- 103     | Emily Clark  | Phone     | 1

-- Create Orders table (removes partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table (contains only full dependencies)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Insert data into OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
