<?php include 'db_connect.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ad-Hoc SQL Query</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <nav>
            <a href="index.php">Home</a>
            <a href="listings.php">Listings</a>
            <a href="agents.php">Agents</a>
            <a href="buyers.php">Buyers</a>
            <a href="query.php">SQL Query</a>
        </nav>

        <h1>Execute SQL Query</h1>

        <form method="POST" action="query.php">
            <textarea name="sql_query" rows="5" style="width:100%;" placeholder="SELECT * FROM Property..."><?php echo isset($_POST['sql_query']) ? htmlspecialchars($_POST['sql_query']) : ''; ?></textarea>
            <br><br>
            <button type="submit">Execute Query</button>
        </form>

        <hr>

        <?php
        if ($_SERVER["REQUEST_METHOD"] == "POST" && !empty($_POST['sql_query'])) {
            $sql = $_POST['sql_query'];

            // Strip slashes to allow quotes in queries
            $sql = stripslashes($sql);

            echo "<h3>Results:</h3>";

            if ($result = $conn->query($sql)) {
                if ($result === TRUE) {
                    // For INSERT, UPDATE, DELETE
                    echo "<div class='alert' style='background:#d4edda; border-color:#c3e6cb; color:#155724;'>Query executed successfully.</div>";
                } elseif ($result->num_rows > 0) {
                    // For SELECT - Dynamically generate table headers and rows
                    echo "<table>";

                    // Fetch Fields for Headers
                    $fields = $result->fetch_fields();
                    echo "<tr>";
                    foreach ($fields as $field) {
                        echo "<th>" . $field->name . "</th>";
                    }
                    echo "</tr>";

                    // Fetch Data
                    while($row = $result->fetch_assoc()) {
                        echo "<tr>";
                        foreach ($row as $data) {
                            echo "<td>" . $data . "</td>";
                        }
                        echo "</tr>";
                    }
                    echo "</table>";
                } else {
                    echo "<p>No results found.</p>";
                }
            } else {
                // Error Handling
                echo "<div class='alert'>Error: " . $conn->error . "</div>";
            }
        }
        ?>
    </div>
</body>
</html>
