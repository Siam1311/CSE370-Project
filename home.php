<?php
session_start();
require 'db.php';

if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit();
}

$username = $_SESSION['username'];

// Fetch all courses
$allCoursesResult = $conn->query("SELECT ID, name FROM course");
$allCourses = $allCoursesResult->fetch_all(MYSQLI_ASSOC);

// Fetch learner's enrolled courses
$stmt = $conn->prepare("SELECT courseID FROM learnertakescourse WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();
$learnerCoursesIDs = array_column($result->fetch_all(MYSQLI_ASSOC), 'courseID');
$stmt->close();

// Separate enrolled and available courses
$enrolledCourses = [];
$availableCourses = [];
foreach ($allCourses as $course) {
    if (in_array($course['ID'], $learnerCoursesIDs)) {
        $enrolledCourses[] = $course;
    } else {
        $availableCourses[] = $course;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home - Programming Learning App</title>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
<style>
body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background-color: #000;
    color: #0ff;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1000px;
    margin: 50px auto;
    padding: 20px;
}

h1 {
    text-align: center;
    font-size: 2.5em;
    margin-bottom: 20px;
}

.top-btn {
    display: block;
    margin: 0 auto 30px auto;
    padding: 12px 25px;
    font-size: 1em;
    font-weight: 600;
    background-color: #0ff;
    color: #000;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s;
    text-decoration: none;
    text-align: center;
    width: fit-content;
}

.top-btn:hover {
    background-color: #0cc;
}

.course-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
}

.course-card {
    background-color: #111;
    border: 2px solid #0ff;
    border-radius: 12px;
    width: 200px;
    padding: 20px;
    text-align: center;
    transition: transform 0.3s, box-shadow 0.3s;
    cursor: pointer;
    text-decoration: none;
    color: #0ff;
}

.course-card:hover {
    transform: scale(1.05);
    box-shadow: 0 0 15px #0ff;
}

.course-icon {
    font-size: 50px;
    margin-bottom: 15px;
}

.enroll-btn {
    background-color: #0ff;
    color: #000;
    padding: 10px 20px;
    border: none;
    border-radius: 8px;
    font-weight: 600;
    cursor: pointer;
    margin-top: 10px;
    transition: background-color 0.3s;
}

.enroll-btn:hover {
    background-color: #0cc;
}
</style>
</head>
<body>
<div class="container">
    <h1>Welcome, <?php echo htmlspecialchars($username); ?>!</h1>

    <?php if (count($enrolledCourses) > 0): ?>
        <a href="?show_all=1" class="top-btn">Enroll in more courses</a>
        <h2 style="text-align:center; margin-bottom:20px;">Your Courses</h2>
        <div class="course-grid">
            <?php foreach ($enrolledCourses as $course): ?>
                <a class="course-card" href="course.php?courseID=<?php echo $course['ID']; ?>">
                    <div class="course-icon">📘</div>
                    <h2><?php echo htmlspecialchars($course['name']); ?></h2>
                    <p>Enrolled</p>
                </a>
            <?php endforeach; ?>
        </div>

        <?php if (isset($_GET['show_all']) && count($availableCourses) > 0): ?>
            <h2 style="text-align:center; margin:40px 0 20px 0;">Available Courses</h2>
            <div class="course-grid">
                <?php foreach ($availableCourses as $course): ?>
                    <div class="course-card">
                        <div class="course-icon">📘</div>
                        <h2><?php echo htmlspecialchars($course['name']); ?></h2>
                        <form method="post" action="enroll_course.php">
                            <input type="hidden" name="courseID" value="<?php echo $course['ID']; ?>">
                            <button type="submit" class="enroll-btn">Enroll</button>
                        </form>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>

    <?php else: ?>
        <h2 style="text-align:center; margin-bottom:20px;">No courses taken yet!</h2>
        <?php if (count($availableCourses) > 0): ?>
            <div class="course-grid">
                <?php foreach ($availableCourses as $course): ?>
                    <a class="course-card" href="course.php?courseID=<?php echo $course['ID']; ?>">
                        <div class="course-icon">📘</div>
                        <h2><?php echo htmlspecialchars($course['name']); ?></h2>
                        <form method="post" action="enroll_course.php">
                            <input type="hidden" name="courseID" value="<?php echo $course['ID']; ?>">
                            <button type="submit" class="enroll-btn">Enroll</button>
                        </form>
                    </a>
                <?php endforeach; ?>
            </div>
        <?php else: ?>
            <p style="text-align:center;">No courses available at the moment.</p>
        <?php endif; ?>
    <?php endif; ?>
</div>
</body>
</html>
