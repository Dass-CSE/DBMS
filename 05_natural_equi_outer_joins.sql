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
    DeptID INT,
    Salary INT
);

-- Output:
-- Table "Employee" created successfully.


-- Inserting into Department
INSERT INTO Department (DeptID, DeptName) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Legal');

-- Output:
-- 4 rows inserted.


-- Inserting into Employee
INSERT INTO Employee (EmpID, Name, DeptID, Salary) VALUES
(101, 'Arun Sharma', 1, 75000),
(102, 'Neeta Pillai', 2, 62000),
(103, 'Vikram Rao', 1, 72000),
(104, 'Sara Ali', 3, 58000),
(105, 'Divya Kapoor', NULL, 55000);

-- Output:
-- 5 rows inserted.


-- 🔗 EQUI JOIN: Explicit condition on matching column
SELECT E.Name, D.DeptName
FROM Employee E, Department D
WHERE E.DeptID = D.DeptID;

-- Output:
-- +--------------+-----------+
-- | Name         | DeptName  |
-- +--------------+-----------+
-- | Arun Sharma  | IT        |
-- | Neeta Pillai | HR        |
-- | Vikram Rao   | IT        |
-- | Sara Ali     | Finance   |
-- +--------------+-----------+


-- ⚡ NATURAL JOIN: Automatically joins on column(s) with same name
-- Note: Only works in some DBMSs that support it (e.g., PostgreSQL, MySQL with aliasing)
-- Assuming DeptID is common

-- Example (syntax may vary by DBMS):
SELECT E.Name, D.DeptName
FROM Employee NATURAL JOIN Department;

-- Output (if supported):
-- +--------------+-----------+
-- | Name         | DeptName  |
-- +--------------+-----------+
-- | Arun Sharma  | IT        |
-- | Neeta Pillai | HR        |
-- | Vikram Rao   | IT        |
-- | Sara Ali     | Finance   |
-- +--------------+-----------+


-- 🔗 LEFT OUTER JOIN: All employees, even if they don't belong to a department
SELECT E.Name, D.DeptName
FROM Employee E
LEFT JOIN Department D ON E.DeptID = D.DeptID;

-- Output:
-- +--------------+-----------+
-- | Name         | DeptName  |
-- +--------------+-----------+
-- | Arun Sharma  | IT        |
-- | Neeta Pillai | HR        |
-- | Vikram Rao   | IT        |
-- | Sara Ali     | Finance   |
-- | Divya Kapoor | NULL      |
-- +--------------+-----------+


-- 🔗 RIGHT OUTER JOIN: All departments, even those without employees
SELECT E.Name, D.DeptName
FROM Employee E
RIGHT JOIN Department D ON E.DeptID = D.DeptID;

-- Output:
-- +--------------+-----------+
-- | Name         | DeptName  |
-- +--------------+-----------+
-- | Arun Sharma  | IT        |
-- | Neeta Pillai | HR        |
-- | Vikram Rao   | IT        |
-- | Sara Ali     | Finance   |
-- | NULL         | Legal     |
-- +--------------+-----------+


-- 🔗 FULL OUTER JOIN (if supported by DBMS): All records from both tables
-- Note: Not all databases support FULL OUTER JOIN directly (MySQL doesn't)
-- Syntax (if supported):
SELECT E.Name, D.DeptName
FROM Employee E
FULL OUTER JOIN Department D ON E.DeptID = D.DeptID;

-- Output (hypothetical):
-- +--------------+-----------+
-- | Name         | DeptName  |
-- +--------------+-----------+
-- | Arun Sharma  | IT        |
-- | Neeta Pillai | HR        |
-- | Vikram Rao   | IT        |
-- | Sara Ali     | Finance   |
-- | Divya Kapoor | NULL      |
-- | NULL         | Legal     |
-- +--------------+-----------+

