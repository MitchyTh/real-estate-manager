<?php include 'db_connect.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Agent Directory</title>
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

        <h1>Agent Directory</h1>

        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Date Started</th>
                <th>Firm Name</th>
                <th>Firm Address</th>
            </tr>
            <?php
            $sql = "SELECT a.agentId, a.name, a.phone, a.dateStarted, f.name AS firmName, f.address AS firmAddress
                    FROM Agent a
                    JOIN Firm f ON a.firmId = f.id
                    ORDER BY a.name ASC";

            $result = $conn->query($sql);

            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    echo "<tr>
                        <td>" . $row["agentId"] . "</td>
                        <td>" . $row["name"] . "</td>
                        <td>" . $row["phone"] . "</td>
                        <td>" . $row["dateStarted"] . "</td>
                        <td>" . $row["firmName"] . "</td>
                        <td>" . $row["firmAddress"] . "</td>
                    </tr>";
                }
            } else {
                echo "<tr><td colspan='6'>No agents found.</td></tr>";
            }
            ?>
        </table>
    </div>
</body>
</html>
