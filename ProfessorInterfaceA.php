<html>
<body>
<pre style="font-family: monospace;">
<?php

// Validate and retrieve professor SSN from POST
if (empty($_POST['ssn'])) {
    die("Error: Professor SSN must be provided.\n");
}

$ssn = trim($_POST['ssn']);

// Simple validation
if (!ctype_digit($ssn)) {
    die("Error: SSN must be numeric.\n");
}

// Connect to database
$link = mysqli_connect('mariadb', 'cs332t29', 'y5pD4Xwt', 'cs332t29');
if (!$link) {
    die('Could not connect: ' . mysqli_connect_error());
}
echo "Connected successfully\n\n";

// Sanitize input
$ssn_escaped = mysqli_real_escape_string($link, $ssn);

// SQL query filtered by professor SSN
$query = "
    SELECT COURSE.TITLE, CLASSROOM, MEETING_DAYS, START_TIME, END_TIME
    FROM COURSE, SECTION, PROFESSOR
    WHERE PSSN = SSN
      AND CNO = CNUM
      AND SSN = '$ssn_escaped'
";

$result = $link->query($query);
if (!$result) {
    die("Query failed: " . $link->error);
}

if ($result->num_rows > 0) {
    $line = "+----------------------------------+-----------+--------------+------------+----------+";
    echo $line . "\n";
    echo "| TITLE                            | CLASSROOM | MEETING_DAYS | START_TIME | END_TIME |\n";
    echo $line . "\n";

    while ($row = $result->fetch_assoc()) {
        printf(
            "| %-32s | %-9s | %-12s | %-10s | %-8s |\n",
            substr($row["TITLE"], 0, 32),
            $row["CLASSROOM"],
            $row["MEETING_DAYS"],
            $row["START_TIME"],
            $row["END_TIME"]
        );
    }

    echo $line . "\n";
} else {
    echo "No classes found for professor with SSN: $ssn\n";
}

$result->free();
$link->close();
?>
</pre>
</body>
</html>
