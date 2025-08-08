-- Creating the Employee table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary INT,
    Age INT
);

-- Output:
-- Table "Employee" created successfully.


-- Inserting values into Employee table
INSERT INTO Employee (EmpID, Name, Department, Salary, Age) VALUES
(1, 'Asha Rao', 'HR', 50000, 29),
(2, 'Nikhil Verma', 'IT', 75000, 31),
(3, 'Divya Patel', 'IT', 72000, 28),
(4, 'Karan Mehta', 'Sales', 55000, 26),
(5, 'Pooja Iyer', 'HR', 51000, 35);

-- Output:
-- 5 rows inserted.


-- Using aggregate functions

-- Average salary
SELECT AVG(Salary) AS AverageSalary FROM Employee;

-- Output:
-- +----------------+
-- | AverageSalary  |
-- +----------------+
-- |    60600       |
-- +----------------+


-- Maximum age
SELECT MAX(Age) AS OldestEmployee FROM Employee;

-- Output:
-- +------------------+
-- | OldestEmployee   |
-- +------------------+
-- |        35        |
-- +------------------+


-- Total salary paid to IT department
SELECT SUM(Salary) AS TotalITSalary FROM Employee
WHERE Department = 'IT';

-- Output:
-- +---------------+
-- | TotalITSalary |
-- +---------------+
-- |    147000     |
-- +---------------+


-- Number of employees in each department
SELECT Department, COUNT(*) AS EmpCount
FROM Employee
GROUP BY Department;

-- Output:
-- +-------------+----------+
-- | Department  | EmpCount |
-- +-------------+----------+
-- | HR          |    2     |
-- | IT          |    2     |
-- | Sales       |    1     |
-- +-------------+----------+


-- Average salary by department, filtering only departments with average salary > 60000
SELECT Department, AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Department
HAVING AVG(Salary) > 60000;

-- Output:
-- +-------------+-----------+
-- | Department  | AvgSalary |
-- +-------------+-----------+
-- | IT          |  73500    |
-- +-------------+-----------+

