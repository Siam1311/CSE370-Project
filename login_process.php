<?php
session_start();
require 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $username = trim($_POST['username']);
    $password = trim($_POST['password']);

    if (empty($username) || empty($password)) {
        $_SESSION['error'] = "Both fields are required.";
        header("Location: login.php");
        exit();
    }

    $stmt = $conn->prepare("SELECT pwHASH FROM learner WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows == 1) {
        $stmt->bind_result($pwHASH);
        $stmt->fetch();

        if (password_verify($password, $pwHASH)) {
            $_SESSION['username'] = $username;
            header("Location: home.php");
            exit();
        } else {
            $_SESSION['error'] = "Incorrect password.";
            header("Location: login.php");
            exit();
        }

    } else {
        $_SESSION['error'] = "Username not found.";
        header("Location: login.php");
        exit();
    }
}
?>
