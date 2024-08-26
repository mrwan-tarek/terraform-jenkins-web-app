<?php
$servername = "rds-web-app-db.cefu4bi34c5q.us-west-2.rds.amazonaws.com:3306";
$username = "admin";
$password = "1234asAS";
$dbname = "web_app_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
// Function to create the users table if it doesn't exist
function createUsersTable($conn) {
    $sql = "CREATE TABLE IF NOT EXISTS users (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            age INT CHECK(age >= 0),
            gender ENUM('male', 'female') NOT NULL
            )";

    if ($conn->query($sql) !== TRUE) {
        echo "Error creating table: " . $conn->error . "<br>";
    }
}
createUsersTable($conn);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST['name'];
    $age = $_POST['age'];
    $gender = $_POST['gender'];
    
    $stmt = $conn->prepare("INSERT INTO users (name,gender,age) VALUES (?, ?, ?)");
    $stmt->bind_param("ssi", $name , $gender , $age);

    if ($stmt->execute()) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
}
$conn->close();
?>