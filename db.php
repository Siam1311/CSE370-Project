<?php
// db.php - MySQLi version

$host = "localhost";
$user = "root";
$pass = "";
$dbname = "project";

// Create connection
$conn = new mysqli($host, $user, $pass, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Optional: set charset to UTF-8
$conn->set_charset("utf8mb4");
?>
