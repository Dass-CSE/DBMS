-- Creating Department table (Parent)
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100)
);

-- Output:
-- Table "Department" created successfully.


-- Creating Student table (Child) with Foreign Key
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Output:
-- Table "Student" created successfully with Foreign Key constraint.


-- Inserting into Department
INSERT INTO Department (DeptID, DeptName) VALUES
(1, 'Computer Science'),
(2, 'Electronics'),
(3, 'Mechanical');

-- Output:
-- 3 rows inserted.


-- Inserting into Student (valid foreign keys)
INSERT INTO Student (StudentID, Name, DeptID) VALUES
(101, 'Arjun Reddy', 1),
(102, 'Lakshmi Menon', 2),
(103, 'Rahul Singh', 1);

-- Output:
-- 3 rows inserted.


-- Trying to insert with invalid foreign key
INSERT INTO Student (StudentID, Name, DeptID)
VALUES (104, 'Meena Kumari', 5);

-- Output:
-- ERROR: Cannot add or update a child row: a foreign key constraint fails
-- (because DeptID = 5 does not exist in Department table)


-- Display Student Table
SELECT * FROM Student;

-- Output:
-- +-----------+----------------+--------+
-- | StudentID | Name           | DeptID |
-- +-----------+----------------+--------+
-- |    101    | Arjun Reddy    |   1    |
-- |    102    | Lakshmi Menon  |   2    |
-- |    103    | Rahul Singh    |   1    |
-- +-----------+----------------+--------+


-- Display Department Table
SELECT * FROM Department;

-- Output:
-- +--------+-------------------+
-- | DeptID | DeptName          |
-- +--------+-------------------+
-- |   1    | Computer Science  |
-- |   2    | Electronics        |
-- |   3    | Mechanical         |
-- +--------+-------------------+

