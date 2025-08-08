-- Creating Department table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100)
);

-- Output:
-- Table "Department" created successfully.


-- Creating Employee table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Salary INT,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Output:
-- Table "Employee" created successfully.


-- Inserting into Department
INSERT INTO Department (DeptID, DeptName) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

-- Output:
-- 3 rows inserted.


-- Inserting into Employee
INSERT INTO Employee (EmpID, Name, Salary, DeptID) VALUES
(101, 'Ravi Singh', 75000, 1),
(102, 'Neha Mehra', 62000, 2),
(103, 'Aman Khan', 80000, 1),
(104, 'Rekha Nair', 56000, 3),
(105, 'Sameer Joshi', 61000, 2);

-- Output:
-- 5 rows inserted.


-- 🔍 Subquery: Get employees earning more than average salary
SELECT Name, Salary
FROM Employee
WHERE Salary > (
    SELECT AVG(Salary) FROM Employee
);

-- Output:
-- +-------------+--------+
-- | Name        | Salary |
-- +-------------+--------+
-- | Ravi Singh  | 75000  |
-- | Aman Khan   | 80000  |
-- +-------------+--------+


-- 🔍 Subquery: List departments with at least one employee earning > 70000
SELECT DeptName
FROM Department
WHERE DeptID IN (
    SELECT DeptID FROM Employee
    WHERE Salary > 70000
);

-- Output:
-- +-----------+
-- | DeptName  |
-- +-----------+
-- | IT        |
-- +-----------+


-- 🔗 Simple INNER JOIN: Show employee names with their department names
SELECT E.Name, D.DeptName
FROM Employee E
JOIN Department D ON E.DeptID = D.DeptID;

-- Output:
-- +--------------+-----------+
-- | Name         | DeptName  |
-- +--------------+-----------+
-- | Ravi Singh   | IT        |
-- | Neha Mehra   | HR        |
-- | Aman Khan    | IT        |
-- | Rekha Nair   | Finance   |
-- | Sameer Joshi | HR        |
-- +--------------+-----------+


-- 🔗 Simple JOIN with condition: Employees from 'HR' department only
SELECT E.Name, E.Salary
FROM Employee E
JOIN Department D ON E.DeptID = D.DeptID
WHERE D.DeptName = 'HR';

-- Output:
-- +--------------+--------+
-- | Name         | Salary |
-- +--------------+--------+
-- | Neha Mehra   | 62000  |
-- | Sameer Joshi | 61000  |
-- +--------------+--------+

