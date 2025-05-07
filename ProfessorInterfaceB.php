<html>
<body>
<pre style="font-family: monospace;">
<?php

// Check if inputs are set and not empty
if (empty($_POST['course_no']) || empty($_POST['section_no'])) {
    die("Error: Course Number and Section Number must be provided.\n");
}

$course_no = trim($_POST['course_no']);
$section_no = trim($_POST['section_no']);

// Basic format validation
if (!ctype_digit($course_no) || !ctype_digit($section_no)) {
    die("Error: Both Course Number and Section Number must be numeric.\n");
}

// Connect to MySQL
$link = mysqli_connect('mariadb', 'cs332t29', 'y5pD4Xwt', 'cs332t29');
if (!$link) {
    die('Could not connect: ' . mysqli_connect_error());
}
echo "Connected successfully\n\n";

// Sanitize input
$course_no_escaped = mysqli_real_escape_string($link, $course_no);
$section_no_escaped = mysqli_real_escape_string($link, $section_no);

// Query
$query = "
	SELECT GRADE, COUNT(*) AS COUNT
	FROM COURSE, SECTION, ENROLLMENT
	WHERE COURSE.CNO = SECTION.CNUM
	AND ENROLLMENT.SECTION_NUMBER = SECTION.SNO
	AND COURSE.CNO = '$course_no_escaped'
	AND SECTION.SNO = '$section_no_escaped'
	GROUP BY GRADE";

$result = $link->query($query);
if (!$result) {
    die("Query failed: " . $link->error);
}

// Handle results
if ($result->num_rows > 0) {
    // Output header
    $line = "+-------+--------+";
    echo $line . "\n";
    echo "| GRADE | COUNT  |\n";
    echo $line . "\n";

    while ($row = $result->fetch_assoc()) {
        printf("| %-5s | %-6d |\n", $row["GRADE"], $row["COUNT"]);
    }

    echo $line . "\n";
} else {
    echo "No results found for the given Course and Section.\n";
}

$result->free();
$link->close();
?>
</pre>
</body>
</html>
