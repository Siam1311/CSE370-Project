<?php

session_start();
require_once 'db.php'; 

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = isset($_POST['username']) ? trim($_POST['username']) : '';
    $email = isset($_POST['email']) ? trim($_POST['email']) : '';
    $password = isset($_POST['password']) ? $_POST['password'] : '';

    if ($username === '' || $email === '' || $password === '') {
        die("Please fill all required fields.");
    }

    $pwHASH = password_hash($password, PASSWORD_DEFAULT);

    $stmt = $conn->prepare("SELECT username FROM learner WHERE username = ? OR email = ?");
    if (!$stmt) {
        die("Prepare failed: " . $conn->error);
    }

    $stmt->bind_param("ss", $username, $email);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        $stmt->close();
        die("Username or email already exists. Please choose another.");
    }
    $stmt->close();

    $stmt = $conn->prepare("INSERT INTO learner (username, email, pwHASH, currentStreak, longestStreak, dateJoined, tournamentRating) VALUES (?, ?, ?, 0, 0, CURDATE(), 1000)");
    if (!$stmt) {
        die("Prepare failed: " . $conn->error);
    }

    $stmt->bind_param("sss", $username, $email, $pwHASH);

    if ($stmt->execute()) {
        $stmt->close();
        $_SESSION['username'] = $username;
        header("Location: login.php");
        exit();
    } else {
        die("Error inserting user: " . $stmt->error);
    }

} else {
    header("Location: signup.php");
    exit();
}
?>
