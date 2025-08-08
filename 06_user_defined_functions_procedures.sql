-- Using MySQL / SQL Server syntax
-- Functions and procedures vary slightly across RDBMS.
-- We'll demonstrate both with practical examples.

-------------------------------
-- 🔧 USER DEFINED FUNCTION
-------------------------------

-- Create a function to calculate annual salary from monthly salary
-- MySQL version
DELIMITER $$

CREATE FUNCTION GetAnnualSalary(monthly_salary INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN monthly_salary * 12;
END $$

DELIMITER ;

-- Output:
-- Function "GetAnnualSalary" created successfully.


-- Using the function
SELECT GetAnnualSalary(50000) AS AnnualSalary;

-- Output:
-- +--------------+
-- | AnnualSalary |
-- +--------------+
-- |    600000    |
-- +--------------+


-------------------------------
-- 🔧 STORED PROCEDURE
-------------------------------

-- Create a stored procedure to insert a new employee
DELIMITER $$

CREATE PROCEDURE AddEmployee (
    IN p_EmpID INT,
    IN p_Name VARCHAR(100),
    IN p_Salary INT
)
BEGIN
    INSERT INTO Employee (EmpID, Name, Salary)
    VALUES (p_EmpID, p_Name, p_Salary);
END $$

DELIMITER ;

-- Output:
-- Procedure "AddEmployee" created successfully.


-- Assuming Employee table exists:
-- CREATE TABLE Employee (
--     EmpID INT PRIMARY KEY,
--     Name VARCHAR(100),
--     Salary INT
-- );

-- Call the stored procedure
CALL AddEmployee(201, 'Rohit Das', 65000);
CALL AddEmployee(202, 'Sneha Roy', 72000);

-- Output:
-- 2 rows inserted into Employee.


-- View table data
SELECT * FROM Employee;

-- Output:
-- +--------+------------+--------+
-- | EmpID  | Name       | Salary |
-- +--------+------------+--------+
-- |  201   | Rohit Das  | 65000  |
-- |  202   | Sneha Roy  | 72000  |
-- +--------+------------+--------+

