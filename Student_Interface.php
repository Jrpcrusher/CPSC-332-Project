<html>
<body>

<?php>
$link = mysqli_connect('mariadb', 'cs332t29', 'y5pD4Xwt', 'cs332t29');
if (!$link) {
        die('Could not connect: ' . mysql_error());
}

echo 'Connected successfully<p>';

$query = "SELECT * FROM STUDENT WHERE ssn=" . $_POST["sno"];
$result = $link->query($query);

$row=$result->fetch_assoc();
printf("SSN: %s<br>\n", $row["ssn"]);
printf("First NAME: %s<br>\n", $row["fname"]);
printf("Last NAME: %s<br>\n", $row["lname"]);

$result->free_result();
$link->close();
?>

</body>
</html>
