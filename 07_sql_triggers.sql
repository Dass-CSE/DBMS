-------------------------------
-- 🔁 Trigger: Logging Salary Changes
-------------------------------

-- Step 1: Create main table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Salary DECIMAL(10, 2)
);

-- Output:
-- Table "Employees" created.


-- Step 2: Create audit table to log salary changes
CREATE TABLE SalaryAudit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmpID INT,
    OldSalary DECIMAL(10, 2),
    NewSalary DECIMAL(10, 2),
    ChangedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Output:
-- Table "SalaryAudit" created.


-- Step 3: Insert sample data
INSERT INTO Employees (EmpID, EmpName, Salary) VALUES
(1, 'Arjun', 50000.00),
(2, 'Meera', 60000.00);

-- Output:
-- 2 rows inserted into "Employees".


-- Step 4: Create BEFORE UPDATE Trigger
DELIMITER //
CREATE TRIGGER before_salary_update
BEFORE UPDATE ON Employees
FOR EACH ROW
BEGIN
    IF OLD.Salary <> NEW.Salary THEN
        INSERT INTO SalaryAudit (EmpID, OldSalary, NewSalary)
        VALUES (OLD.EmpID, OLD.Salary, NEW.Salary);
    END IF;
END;
//
DELIMITER ;

-- Output:
-- Trigger "before_salary_update" created.


-- Step 5: Perform update to test trigger
UPDATE Employees SET Salary = 55000.00 WHERE EmpID = 1;

-- Output:
-- 1 row updated in "Employees".
-- Corresponding audit entry inserted into "SalaryAudit".


-- Step 6: View updated Employees
SELECT * FROM Employees;

-- Output:
-- +--------+---------+----------+
-- | EmpID  | EmpName | Salary   |
-- +--------+---------+----------+
-- | 1      | Arjun   | 55000.00 |
-- | 2      | Meera   | 60000.00 |
-- +--------+---------+----------+


-- Step 7: View audit trail
SELECT * FROM SalaryAudit;

-- Output:
-- +---------+--------+-----------+-----------+---------------------+
-- | AuditID | EmpID  | OldSalary | NewSalary | ChangedAt           |
-- +---------+--------+-----------+-----------+---------------------+
-- | 1       | 1      | 50000.00  | 55000.00  | 2025-08-08 11:12:00 |
-- +---------+--------+-----------+-----------+---------------------+

