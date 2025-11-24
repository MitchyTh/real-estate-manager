<?php include 'db_connect.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Buyer Directory</title>
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

        <h1>Registered Buyers</h1>

        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Pref Type</th>
                <th>Bed/Bath</th>
                <th>Biz Type</th>
                <th>Price Range</th>
            </tr>
            <?php
            $sql = "SELECT * FROM Buyer ORDER BY name ASC";
            $result = $conn->query($sql);

            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    $priceRange = "$" . number_format($row["minimumPreferredPrice"]) . " - $" . number_format($row["maximumPreferredPrice"]);
                    $bedBath = ($row["propertyType"] == 'House') ? $row["bedrooms"] . " bd / " . $row["bathrooms"] . " ba" : "N/A";

                    echo "<tr>
                        <td>" . $row["id"] . "</td>
                        <td>" . $row["name"] . "</td>
                        <td>" . $row["phone"] . "</td>
                        <td>" . $row["propertyType"] . "</td>
                        <td>" . $bedBath . "</td>
                        <td>" . ($row["businessPropertyType"] ? $row["businessPropertyType"] : "N/A") . "</td>
                        <td>" . $priceRange . "</td>
                    </tr>";
                }
            } else {
                echo "<tr><td colspan='7'>No buyers found.</td></tr>";
            }
            ?>
        </table>
    </div>
</body>
</html>
