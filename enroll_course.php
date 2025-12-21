<?php
session_start();
require 'db.php';

if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_SESSION['username'];
    $courseID = intval($_POST['courseID']);

    $stmt = $conn->prepare("INSERT INTO learnertakescourse (username, courseID, dateTaken) VALUES (?, ?, CURDATE())");
    $stmt->bind_param("si", $username, $courseID);
    $stmt->execute();
    $stmt->close();

    header("Location: home.php");
    exit();
}
?>
