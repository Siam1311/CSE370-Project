<?php
session_start();
require 'db.php';

$conceptID = $_GET['conceptID'] ?? 0;

// Fetch concept info
$stmt = $conn->prepare("SELECT * FROM concept WHERE ID = ?");
$stmt->bind_param("i", $conceptID);
$stmt->execute();
$concept = $stmt->get_result()->fetch_assoc();

// Fetch non-interactive explanation
$stmtExp = $conn->prepare("SELECT * FROM explanation WHERE conceptID = ?");
$stmtExp->bind_param("i", $conceptID);
$stmtExp->execute();
$explanation = $stmtExp->get_result()->fetch_assoc();

// Fetch interactive exercises
$stmtInt = $conn->prepare("
    SELECT e.ID, e.questionStatement, ce.codeBody
    FROM exercise e
    LEFT JOIN CodingExercise ce ON ce.exerciseID = e.ID
    JOIN interactiveexplanation ie ON ie.exerciseID = e.ID
    WHERE e.conceptID = ?");
$stmtInt->bind_param("i", $conceptID);
$stmtInt->execute();
$interactiveExercises = $stmtInt->get_result()->fetch_all(MYSQLI_ASSOC);

// Fetch practice exercises
$stmtPrac = $conn->prepare("
    SELECT e.ID, e.questionStatement, ce.codeBody
    FROM exercise e
    LEFT JOIN CodingExercise ce ON ce.exerciseID = e.ID
    WHERE e.conceptID = ? AND e.type='p'");
$stmtPrac->bind_param("i", $conceptID);
$stmtPrac->execute();
$practiceExercises = $stmtPrac->get_result()->fetch_all(MYSQLI_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><?php echo htmlspecialchars($concept['name']); ?></title>
<link rel="stylesheet" href="style.css">
<style>
body {
    background: black;
    color: cyan;
    font-family: 'Plus Jakarta Sans', sans-serif;
    padding: 20px;
}
.center { text-align: center; }
img.center { display: block; margin: 0 auto; }
textarea { width: 100%; background: #111; color: cyan; border: 1px solid cyan; padding: 10px; }
button { background: cyan; color: black; border: none; padding: 10px 20px; cursor: pointer; margin-top: 10px; }
.section { display: none; margin-bottom: 30px; }
.section.active { display: block; }
.exercise-box { margin-bottom: 20px; }
</style>
</head>
<body>

<!-- Non-interactive explanation -->
<div class="section active" id="section-explanation">
    <h2 class="center">Explanation</h2>
    <div class="center">
        <p><?php echo nl2br(htmlspecialchars($explanation['text'] ?? '')); ?></p>
        <?php if(!empty($explanation['image'])): ?>
            <img src="<?php echo htmlspecialchars($explanation['image']); ?>" class="center">
        <?php endif; ?>
    </div>
    <div class="center">
        <button class="next-btn" data-next="section-interactive">OK</button>
    </div>
</div>

<!-- Interactive exercises -->
<div class="section" id="section-interactive">
    <h2 class="center">Interactive Exercise</h2>
    <?php foreach($interactiveExercises as $iex): ?>
    <div class="exercise-box">
        <p><?php echo nl2br(htmlspecialchars($iex['questionStatement'])); ?></p>
        <textarea name="code" rows="5"><?php echo htmlspecialchars($iex['codeBody'] ?? ''); ?></textarea>
        <button onclick="runTest(<?php echo $iex['ID']; ?>)">Test</button>
        <div class="test-result" id="result-<?php echo $iex['ID']; ?>"></div>
    </div>
    <?php endforeach; ?>
    <div class="center">
        <button class="next-btn" data-next="section-practice">Next</button>
    </div>
</div>

<!-- Practice exercises -->
<div class="section" id="section-practice">
    <h2 class="center">Practice Exercise</h2>
    <?php foreach($practiceExercises as $pex): ?>
    <div class="exercise-box">
        <p><?php echo nl2br(htmlspecialchars($pex['questionStatement'])); ?></p>
        <textarea name="code" rows="5"><?php echo htmlspecialchars($pex['codeBody'] ?? ''); ?></textarea>
        <button onclick="runTest(<?php echo $pex['ID']; ?>)">Test</button>
        <div class="test-result" id="practice-result-<?php echo $pex['ID']; ?>"></div>
    </div>
    <?php endforeach; ?>
</div>

<script>
// Ensure DOM is loaded before attaching events
document.addEventListener("DOMContentLoaded", function() {
    const nextButtons = document.querySelectorAll(".next-btn");
    nextButtons.forEach(btn => {
        btn.addEventListener("click", function() {
            const nextId = this.dataset.next;
            document.querySelectorAll(".section").forEach(s => s.classList.remove("active"));
            document.getElementById(nextId).classList.add("active");
            window.scrollTo(0, 0); // scroll to top when next section shows
        });
    });
});

function runTest(exerciseID, isPractice = false) {
    const code = document.getElementById((isPractice ? 'practice-' : 'code-') + exerciseID).value;

    fetch('run_test.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ exerciseID: exerciseID, codeBody: code })
    })
    .then(res => res.text()) // get raw text first
    .then(text => {
        let data;
        try {
            data = JSON.parse(text); // parse JSON
        } catch (e) {
            console.error("Failed to parse JSON:", text);
            alert("Error running test. See console for details.");
            return;
        }

        // Ensure data is an array
        if (!Array.isArray(data)) {
            data = [data];
        }

        const resultDiv = document.getElementById((isPractice ? 'practice-result-' : 'result-') + exerciseID);
        resultDiv.innerHTML = ''; // clear previous results

        data.forEach((test, idx) => {
            const p = document.createElement('p');
            p.textContent = `Test ${idx + 1}: ${test.pass ? 'Passed' : 'Failed'} - ${test.message}`;
            resultDiv.appendChild(p);
        });
    })
    .catch(err => {
        console.error("Fetch error:", err);
        alert("Error running test. See console for details.");
    });
}


</script>

</body>
</html>
