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
if (!isset($_POST['cwid']) || !is_numeric($_POST['cwid'])) {
    die("Invalid CWID.");
}

$cwid = intval($_POST['cwid']);

// Query: Get all courses the student took and their grades
$query = "
SELECT C.TITLE, E.GRADE
FROM ENROLLMENT E, SECTION S, COURSE C
WHERE E.CWID = $cwid
  AND E.CNO = C.CNO
  AND E.SECTION_NUMBER = S.SNO
  AND E.CNO = S.CNUM
ORDER BY C.TITLE";

$result = $link->query($query);

if ($result->num_rows > 0) {
    $line = "+-----------------------------------------------+--------+";
    echo $line . "\n";
    echo "| COURSE TITLE                                  | GRADE  |\n";
    echo $line . "\n";

    while ($row = $result->fetch_assoc()) {
        printf("| %-45s | %-6s |\n", substr($row["TITLE"], 0, 45), $row["GRADE"]);
    }

    echo $line . "\n";
} else {
    echo "No courses found for student CWID: $cwid\n";
}

$result->free();
$link->close();
?>
</pre>
</body>
</html>
