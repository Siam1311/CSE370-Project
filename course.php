<?php
session_start();
if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit();
}

require_once 'db.php';
$username = $_SESSION['username'];

if (!isset($_GET['courseID'])) {
    echo "Course not specified!";
    exit();
}
$courseID = $_GET['courseID'];

// Fetch course details
$courseStmt = $conn->prepare("SELECT * FROM course WHERE ID = ?");
$courseStmt->bind_param("i", $courseID);
$courseStmt->execute();
$courseResult = $courseStmt->get_result();
$course = $courseResult->fetch_assoc();
if (!$course) {
    echo "Course not found!";
    exit();
}

// Fetch modules and concepts
$moduleStmt = $conn->prepare("
    SELECT m.ID as moduleID, m.name as moduleName 
    FROM module m 
    WHERE m.courseID = ?
");
$moduleStmt->bind_param("i", $courseID);
$moduleStmt->execute();
$moduleResult = $moduleStmt->get_result();
$modules = [];
while ($mod = $moduleResult->fetch_assoc()) {
    // fetch concepts
    $conceptStmt = $conn->prepare("SELECT * FROM concept WHERE moduleID = ?");
    $conceptStmt->bind_param("i", $mod['moduleID']);
    $conceptStmt->execute();
    $conceptResult = $conceptStmt->get_result();
    $concepts = [];
    while ($c = $conceptResult->fetch_assoc()) {
        $concepts[] = $c;
    }
    $mod['concepts'] = $concepts;
    $modules[] = $mod;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title><?php echo htmlspecialchars($course['name']); ?> - Course</title>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
<style>
body {
    margin: 0;
    font-family: 'Plus Jakarta Sans', sans-serif;
    background-color: #000;
    color: #0ff;
}
.container {
    max-width: 900px;
    margin: 50px auto;
    padding: 20px;
}
h1 {
    text-align: center;
    margin-bottom: 30px;
}
.module {
    margin-bottom: 30px;
    border: 1px solid #0ff;
    padding: 20px;
    border-radius: 10px;
}
.module h2 {
    margin-top: 0;
    color: #0ff;
}
.concept {
    display: block;
    margin: 10px 0;
    padding: 10px 15px;
    border-radius: 5px;
    background-color: #001f1f;
    color: #0ff;
    text-decoration: none;
    transition: 0.2s;
}
.concept:hover {
    background-color: #0ff;
    color: #000;
}
</style>
</head>
<body>
<div class="container">
    <h1><?php echo htmlspecialchars($course['name']); ?></h1>

    <?php if (count($modules) == 0): ?>
        <p>No modules in this course yet!</p>
    <?php else: ?>
        <?php foreach ($modules as $module): ?>
            <div class="module">
                <h2><?php echo htmlspecialchars($module['moduleName']); ?></h2>
                <?php if (count($module['concepts']) == 0): ?>
                    <p>No concepts yet!</p>
                <?php else: ?>
                    <?php foreach ($module['concepts'] as $concept): ?>
                        <a class="concept" href="concept.php?conceptID=<?php echo $concept['ID']; ?>">
                            <?php echo htmlspecialchars($concept['name']); ?>
                        </a>
                    <?php endforeach; ?>
                <?php endif; ?>
            </div>
        <?php endforeach; ?>
    <?php endif; ?>
</div>
</body>
</html>
