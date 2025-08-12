<?php
include 'db_config.php';

$user = $_POST['username'];
$pass = $_POST['password'];

$sql = "SELECT * FROM users WHERE username=? AND password=?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $user, $pass);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    echo "<h2>Login successful! Welcome, $user</h2>";
} else {
    echo "<h2>Invalid username or password</h2>";
}

$stmt->close();
$conn->close();
?>
