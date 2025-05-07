<html>
<body>
<pre style="font-family: monospace;">
<?php
$link = mysqli_connect('mariadb', 'cs332t29', 'y5pD4Xwt', 'cs332t29');
if (!$link) {
    die('Could not connect: ' . mysqli_connect_error());
}
echo "Connected successfully\n\n";

// Validate input
if (!isset($_POST['course_no']) || !is_numeric($_POST['course_no'])) {
    die("Invalid course number.");
}

$course_no = intval($_POST['course_no']);

// SQL query
$query = "
SELECT S.SNO, S.CLASSROOM, S.MEETING_DAYS, S.START_TIME, S.END_TIME, COUNT(*) AS STUDENT_COUNT
FROM SECTION S, ENROLLMENT E
WHERE S.CNUM = $course_no
  AND S.CNUM = E.CNO
  AND S.SNO = E.SECTION_NUMBER
GROUP BY S.SNO, S.CLASSROOM, S.MEETING_DAYS, S.START_TIME, S.END_TIME";

$result = $link->query($query);

if ($result->num_rows > 0) {
    $line = "+-----+-----------+--------------+------------+----------+---------------+";
    echo $line . "\n";
    echo "| SNO | CLASSROOM | MEETING_DAYS | START_TIME | END_TIME | STUDENT_COUNT |\n";
    echo $line . "\n";

    while ($row = $result->fetch_assoc()) {
        printf(
            "| %-3d | %-9s | %-12s | %-10s | %-8s | %-13d |\n",
            $row["SNO"],
            $row["CLASSROOM"],
            $row["MEETING_DAYS"],
            $row["START_TIME"],
            $row["END_TIME"],
            $row["STUDENT_COUNT"]
        );
    }

    echo $line . "\n";
} else {
    echo "No sections found for course number $course_no.\n";
}

$result->free();
$link->close();
?>
</pre>
</body>
</html>
