<?php
$servername = "rds-web-app-db.cefu4bi34c5q.us-west-2.rds.amazonaws.com:3306";
$username = "admin";
$password = "1234asAS";
$dbname = "web_app_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
//////////////////////////// Here 
// Process form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $data = $_POST['data'];
    
    $sql = "INSERT INTO users (name,gender,age) VALUES ('$data')";

    if ($conn->query($sql) === TRUE) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}
// ////////////////////////////////
// $name = $_POST['name'];
// $age = $_POST['age'];
// $gender = $_POST['gender'];


// $stmt = $conn->prepare("INSERT INTO users (name,gender,age) VALUES (?, ?, ?)");
// $stmt->bind_param("ssi", $name , $gender , $age);

// if ($stmt->execute()) {
//     echo "New record created successfully";
// } else {
//     echo "Error: " . $stmt->error;
// }

// $stmt->close();
$conn->close();
?>