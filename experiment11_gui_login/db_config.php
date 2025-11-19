<?php
$servername = "localhost";
$username = "root";  // change if needed
$password = "";      // change if needed
$dbname = "experiment12";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
