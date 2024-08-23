<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Form</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #F8F6F1; /* Creamy color */
            font-family: Arial, sans-serif;
            margin: 0;
        }

        h1 {
            margin-bottom: 20px;
            text-align: center; 
        }

        .form-container {
            background-color: #97DECE; /* Mint green color */
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            margin-bottom: 20px;
        }

        input[type="text"],
        input[type="number"],
        #search {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        #gender {
            width: 50%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[type="submit"] {
            margin-top: 29px;
            background-color: #2a9d8f; /* darker mint green */
            color: white;
            border: none;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 16px;
        }

        input[type="submit"]:hover {
            background-color: #21867a;
        }

        .results {
            background-color: #F0FFF0; /* Light green */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 400px;
            margin-top: 20px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h1>Welcome to Our Application!</h1>

    <div class="form-container">
        <h2>User Submission</h2>
        <form action="submit.php" method="post">
            <label for="name">Name:</label>
            <input type="text" name="name" placeholder="Enter Your Name" required><br>
            <label for="age">Age:</label>
            <input type="number" name="age" placeholder="Enter Your Age" required><br>
            <label for="gender">Gender:</label><br>
            <select id="gender" name="gender" style="cursor: pointer;">
                <option class="option" value="male">Male</option>
                <option class="option" value="female">Female</option>
            </select><br>
            <input type="submit" value="Submit">
        </form>
    </div>

    <div class="form-container">
        <h2>Search User</h2>
        <form action="search.php" method="post">
            <input type="text" id="search" name="search" placeholder="Search User by Name" required>
            <input type="submit" value="Search">
        </form>
    </div>

    <div id="results" class="results">
        <!-- Search results will be displayed here -->
    </div>
</body>
</html>
