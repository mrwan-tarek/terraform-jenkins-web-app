<?php
$servername = "rds-web-app-db.cefu4bi34c5q.us-west-2.rds.amazonaws.com:3306";
$username = "admin";
$password = "1234asAS";
$dbname = "web_app_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

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
$conn->close();
?>