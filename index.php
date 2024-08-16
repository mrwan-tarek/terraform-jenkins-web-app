<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Form</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f1de; /* Creamy color */
            font-family: Arial, sans-serif;
            margin: 0;
        }

        form {
            background-color: #d8f3dc; /* Mint green color */
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #2a9d8f; /* darker mint green */
            color: white;
            border: none;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <form action="submit.php" method="post">
        <label for="name">Name:</label>
        <input type="text" name="name" required><br>
        <label for="age">Age:</label>
        <input type="number" name="age" required><br>
        <input type="submit" value="Submit">
    </form>
</body>
</html>
