-- Creating the table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Department VARCHAR(50)
);

-- Output:
-- Table "Students" created successfully.


-- Inserting records
INSERT INTO Students (StudentID, Name, Age, Department) VALUES
(1, 'Ananya Sharma', 20, 'CSE'),
(2, 'Ravi Kumar', 21, 'ECE'),
(3, 'Meera Iyer', 19, 'IT');

-- Output:
-- 3 rows inserted.


-- Viewing the data
SELECT * FROM Students;

-- Output:
-- +-----------+--------------+-----+-------------+
-- | StudentID | Name         | Age | Department  |
-- +-----------+--------------+-----+-------------+
-- |    1      | Ananya Sharma|  20 | CSE         |
-- |    2      | Ravi Kumar   |  21 | ECE         |
-- |    3      | Meera Iyer   |  19 | IT          |
-- +-----------+--------------+-----+-------------+


-- Updating a record
UPDATE Students
SET Age = 22
WHERE StudentID = 2;

-- Output:
-- 1 row updated.


-- Deleting a record
DELETE FROM Students
WHERE StudentID = 3;

-- Output:
-- 1 row deleted.


-- Final Table View
SELECT * FROM Students;

-- Output:
-- +-----------+--------------+-----+-------------+
-- | StudentID | Name         | Age | Department  |
-- +-----------+--------------+-----+-------------+
-- |    1      | Ananya Sharma|  20 | CSE         |
-- |    2      | Ravi Kumar   |  22 | ECE         |
-- +-----------+--------------+-----+-------------+

