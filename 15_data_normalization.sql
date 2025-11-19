-- Experiment 15: Database Design Using Normalization
-- ---------------------------------------------------
-- UNF (Unnormalized Form): A single table with repeating groups

-- Not implemented in SQL directly; starting with 1NF

-- 1NF: Remove repeating groups, make atomic columns
CREATE DATABASE normalization_db;
USE normalization_db;

CREATE TABLE Student_1NF (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Course1 VARCHAR(50),
    Course2 VARCHAR(50),
    Course3 VARCHAR(50)
);

INSERT INTO Student_1NF VALUES
(1, 'Alice', 'Math', 'Physics', 'Chemistry'),
(2, 'Bob', 'Biology', 'Math', NULL);

-- 2NF: Remove partial dependencies (separate into related tables)
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(50)
);

CREATE TABLE Enrollment (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

INSERT INTO Student VALUES
(1, 'Alice'),
(2, 'Bob');

INSERT INTO Course (CourseName) VALUES
('Math'), ('Physics'), ('Chemistry'), ('Biology');

INSERT INTO Enrollment VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 1);

-- 3NF: Remove transitive dependencies (example: separating instructor info)
CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    InstructorName VARCHAR(50),
    Department VARCHAR(50)
);

ALTER TABLE Course ADD InstructorID INT;
ALTER TABLE Course
ADD CONSTRAINT fk_instructor FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID);

-- Example inserts for Instructor and linking to Courses
INSERT INTO Instructor (InstructorName, Department) VALUES
('Dr. Smith', 'Science'),
('Dr. Lee', 'Biology');

UPDATE Course SET InstructorID = 1 WHERE CourseName IN ('Math', 'Physics', 'Chemistry');
UPDATE Course SET InstructorID = 2 WHERE CourseName = 'Biology';

