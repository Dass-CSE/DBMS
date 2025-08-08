-------------------------------
-- 🔐 DCL: Data Control Language
-------------------------------

-- Creating a sample user (syntax may vary depending on DBMS)
-- MySQL:
CREATE USER 'demo_user'@'localhost' IDENTIFIED BY 'password123';

-- Output:
-- User "demo_user" created successfully.


-- Granting privileges
GRANT SELECT, INSERT, UPDATE ON testdb.* TO 'demo_user'@'localhost';

-- Output:
-- Privileges granted.


-- Revoking privileges
REVOKE UPDATE ON testdb.* FROM 'demo_user'@'localhost';

-- Output:
-- Update privilege revoked.

-- Viewing current privileges (MySQL)
SHOW GRANTS FOR 'demo_user'@'localhost';

-- Output:
-- Grants for demo_user:
-- GRANT SELECT, INSERT ON `testdb`.* TO 'demo_user'@'localhost'


-------------------------------
-- 🔁 TCL: Transaction Control Language
-------------------------------

-- Assuming the following table:
-- CREATE TABLE Account (
--     AccID INT PRIMARY KEY,
--     Name VARCHAR(100),
--     Balance INT
-- );

-- Inserting initial data
INSERT INTO Account (AccID, Name, Balance) VALUES
(1, 'Rahul', 10000),
(2, 'Sneha', 8000);

-- Output:
-- 2 rows inserted.


-- Start a transaction
START TRANSACTION;

-- Transfer 2000 from Rahul to Sneha
UPDATE Account SET Balance = Balance - 2000 WHERE AccID = 1;
UPDATE Account SET Balance = Balance + 2000 WHERE AccID = 2;

-- Check balances before committing
SELECT * FROM Account;

-- Output (before commit):
-- +-------+--------+---------+
-- | AccID | Name   | Balance |
-- +-------+--------+---------+
-- |   1   | Rahul  |  8000   |
-- |   2   | Sneha  | 10000   |
-- +-------+--------+---------+


-- COMMIT to save changes
COMMIT;

-- Output:
-- Transaction committed. Balances permanently updated.


-- Another transaction with ROLLBACK
START TRANSACTION;

UPDATE Account SET Balance = Balance - 5000 WHERE AccID = 1;
UPDATE Account SET Balance = Balance + 5000 WHERE AccID = 2;

-- Oops! Something went wrong. Let's undo it.
ROLLBACK;

-- Output:
-- Transaction rolled back. No changes applied.

-- Final view
SELECT * FROM Account;

-- Output:
-- +-------+--------+---------+
-- | AccID | Name   | Balance |
-- +-------+--------+---------+
-- |   1   | Rahul  |  8000   |
-- |   2   | Sneha  | 10000   |
-- +-------+--------+---------+

