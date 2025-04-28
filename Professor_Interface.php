<html>
<body>
<?php>

$link = mysqli_connect('mariadb', 'cs332t29', 'y5pD4Xwt', 'cs332t29');
if (!$link) {
        die('Could not connect: '.mysql_error());
}
echo 'Connected successfully<p>';

$result = $link->query("SELECT * FROM STUDENT");
$nor=$result->num_rows;

for($i=0; $i<$nor, $i++)
{
        $row=$result->fetch_assoc();
        echo "SSN: ", $row["ssn"], "<br>";
        echo "First NAME: ", $row["fname"], "<br>";
        echo "Last NAME: ", $row["lname"], "<br>";
}

$result->free_result();
$link->close();
?>

</body>
</html>
