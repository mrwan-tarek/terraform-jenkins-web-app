<?php
$servername = "";
$username = "admin";
$password = "1234asAS";
$dbname = "web_app_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$search = $_POST['search'];
$stmt = $conn->prepare("SELECT * FROM users WHERE name = ?");
$stmt->bind_param("s", $search);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    echo "<h2>Search Results:</h2>";
    while ($row = $result->fetch_assoc()) {
        echo "<p>Name: " . htmlspecialchars($row['name']) . "<br>Age: " . htmlspecialchars($row['age']) . "<br>Gender: " . htmlspecialchars($row['gender']) . "</p>";
    }
} else {
    echo "No results found.";
}

$stmt->close();
$conn->close();
?>
