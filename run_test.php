<?php
header('Content-Type: application/json');

// Turn off warnings and notices that break JSON
error_reporting(0);

// Read input
$input = json_decode(file_get_contents('php://input'), true);

if (!$input || !isset($input['exerciseID'], $input['codeBody'])) {
    echo json_encode([['pass' => false, 'message' => 'Invalid input']]);
    exit;
}

$exerciseID = intval($input['exerciseID']);
$codeBody = $input['codeBody'];

// Connect to database
$mysqli = new mysqli("localhost", "root", "", "myapp");
if ($mysqli->connect_errno) {
    echo json_encode([['pass' => false, 'message' => 'Database connection failed']]);
    exit;
}

// Fetch test cases
$stmt = $mysqli->prepare("SELECT inputData, expectedOutput FROM TestCase WHERE exerciseID = ?");
$stmt->bind_param("i", $exerciseID);
$stmt->execute();
$result = $stmt->get_result();

$testcases = [];
while ($row = $result->fetch_assoc()) {
    $testcases[] = $row;
}

$stmt->close();
$mysqli->close();

$results = [];

foreach ($testcases as $test) {
    $inputData = $test['inputData'];
    $expected = $test['expectedOutput'];

    // Capture output safely
    ob_start();
    try {
        // Provide inputData to the user code if needed
        eval($codeBody);
        $output = ob_get_clean();
    } catch (Throwable $e) {
        ob_end_clean();
        $output = '';
    }

    $results[] = [
        'pass' => trim($output) === trim($expected),
        'message' => trim($output) === trim($expected) ? 'Passed' : "Expected: '$expected', Got: '$output'"
    ];
}

// Ensure output is a JSON array
echo json_encode($results);
exit;
