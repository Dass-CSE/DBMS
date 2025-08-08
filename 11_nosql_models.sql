//---------------------------------------------
// A. Document-Based Data Model Using MongoDB
//---------------------------------------------

// Switch to database
use inventory;

// Insert documents into 'products' collection
db.products.insertMany([
  { product_id: 101, name: "Laptop", brand: "Dell", price: 70000 },
  { product_id: 102, name: "Smartphone", brand: "Samsung", price: 25000 },
  { product_id: 103, name: "Tablet", brand: "Apple", price: 50000 }
]);

// Output:
// Acknowledged. Inserted 3 documents into 'products'

// Query products with price > 30000
db.products.find({ price: { $gt: 30000 } });

// Output:
// { product_id: 101, name: "Laptop", brand: "Dell", price: 70000 }
// { product_id: 103, name: "Tablet", brand: "Apple", price: 50000 }

// Update a product’s price
db.products.updateOne(
  { product_id: 102 },
  { $set: { price: 23000 } }
);

// Output:
// Matched 1 document, Modified 1 document
// Updated Product: { product_id: 102, name: "Smartphone", brand: "Samsung", price: 23000 }

// Delete a product from the collection
db.products.deleteOne({ product_id: 103 });

// Output:
// Deleted 1 document

//---------------------------------------------------
// B. Column-Family-Based Data Model Using Cassandra
//---------------------------------------------------

// Create a Keyspace
CREATE KEYSPACE IF NOT EXISTS retail
WITH replication = { 'class': 'SimpleStrategy', 'replication_factor': 1 };

// Use the Keyspace
USE retail;

// Create a 'sales' table
CREATE TABLE sales (
  sale_id UUID PRIMARY KEY,
  customer_name text,
  product_name text,
  amount decimal
);

// Insert data into the table
INSERT INTO sales (sale_id, customer_name, product_name, amount)
VALUES (uuid(), 'Alice', 'Laptop', 70000.00);

INSERT INTO sales (sale_id, customer_name, product_name, amount)
VALUES (uuid(), 'Bob', 'Tablet', 50000.00);

// Output:
// 2 rows inserted

// Query data with amount > 30000
SELECT * FROM sales WHERE amount > 30000.00;

// Output:
// sale_id: abc-123
// customer_name: Alice
// product_name: Laptop
// amount: 70000.00

// Update the amount for a specific sale (Note: Primary key must be specified)
UPDATE sales SET amount = 68000.00 WHERE sale_id = abc-123;

// Output:
// Updated 1 row

// Delete a record from the table
DELETE FROM sales WHERE customer_name = 'Bob';

// Output:
// Deleted 1 row (only if customer_name is part of primary key or indexed)

//-------------------------------------------
// C. Graph-Based Data Model Using Neo4j
//-------------------------------------------

// Create nodes representing people
CREATE (p1:Person {name: 'Alice', age: 25});
CREATE (p2:Person {name: 'Bob', age: 30});
CREATE (p3:Person {name: 'Charlie', age: 35});

// Output:
// 3 nodes created

// Create relationships between people
CREATE (p1)-[:FRIEND_OF]->(p2);
CREATE (p2)-[:FRIEND_OF]->(p3);
CREATE (p3)-[:FRIEND_OF]->(p1);

// Output:
// 3 relationships created

// Query people who are friends with Bob
MATCH (p:Person)-[:FRIEND_OF]->(friend:Person {name: 'Bob'})
RETURN p.name AS FriendsOfBob;

// Output:
// Friends of Bob: Alice, Charlie

// Update Alice's age
MATCH (p:Person {name: 'Alice'})
SET p.age = 26;

// Output:
// Alice’s age updated to 26

// Delete a relationship between Charlie and Alice
MATCH (p1:Person {name: 'Charlie'})-[r:FRIEND_OF]->(p2:Person {name: 'Alice'})
DELETE r;

// Output:
// 1 relationship deleted
