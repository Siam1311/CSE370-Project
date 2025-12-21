<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html, body {
            height: 100%;
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #000;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #0ff;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .logincontainer {
            background-color: #000;
            border: 2px solid #0ff;
            padding: 50px 40px;
            border-radius: 12px;
            box-shadow: 0 0 20px #0ff, 0 0 40px #0ff, 0 0 60px #0ff;
            text-align: center;
            width: 360px;
            animation: fadeIn 1s ease forwards;
        }

        h1 {
            font-weight: 600;
            font-size: 28px;
            margin-bottom: 30px;
            text-shadow: 0 0 10px #0ff;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 14px 18px;
            margin-bottom: 20px;
            border: 2px solid #0ff;
            border-radius: 8px;
            background-color: #000;
            color: #0ff;
            font-size: 16px;
            outline: none;
            box-shadow: 0 0 10px #0ff inset;
            transition: 0.3s;
        }

        input:focus {
            box-shadow: 0 0 20px #0ff inset, 0 0 30px #0ff;
        }

        button {
            width: 100%;
            padding: 14px 0;
            border: none;
            border-radius: 8px;
            background-color: #000;
            color: #0ff;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 0 10px #0ff, 0 0 20px #0ff;
            transition: 0.3s;
        }

        button:hover {
            box-shadow: 0 0 20px #0ff, 0 0 40px #0ff;
            transform: translateY(-2px);
        }

        .link {
            margin-top: 15px;
            display: block;
            color: #0ff;
            text-decoration: none;
            font-size: 14px;
            text-shadow: 0 0 5px #0ff;
            transition: 0.3s;
        }

        .link:hover {
            text-shadow: 0 0 15px #0ff;
        }
    </style>
</head>
<body>
    <div class="logincontainer">
        <h1>Login</h1>
        <form method="post" action="login_process.php">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <a class="link" href="signup.php">Don't have an account? Sign Up</a>
    </div>
</body>
</html>
