<?php include 'db_connect.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Property Listings</title>
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

        <h1>Property Listings</h1>

        <div class="search-box">
            <h3>Search Houses:</h3>
            <form method="GET" action="listings.php">
                <input type="number" name="min_price" placeholder="Min Price">
                <input type="number" name="max_price" placeholder="Max Price">
                <input type="number" name="beds" placeholder="Min Beds">
                <input type="number" name="baths" placeholder="Min Baths">
                <button type="submit" name="search_house">Filter Houses</button>
                <a href="listings.php"><button type="button" style="background:#7f8c8d;">Reset</button></a>
            </form>
        </div>

        <div class="search-box">
            <h3>Search Business:</h3>
            <form method="GET" action="listings.php">
                <input type="number" name="biz_min_price" placeholder="Min Price">
                <input type="number" name="biz_max_price" placeholder="Max Price">
                <input type="number" name="min_size" placeholder="Min Sq Ft">
                <input type="number" name="max_size" placeholder="Max Sq Ft">
                <button type="submit" name="search_biz">Filter Business</button>
            </form>
        </div>

        <h2>Residential Listings</h2>
        <table>
            <tr>
                <th>MLS #</th>
                <th>Address</th>
                <th>Price</th>
                <th>Beds</th>
                <th>Baths</th>
                <th>Size (SqFt)</th>
                <th>Agent ID</th>
            </tr>
            <?php
            // Base Query for Houses
            $sql = "SELECT l.mlsNumber, p.address, p.price, h.bedrooms, h.bathrooms, h.size, l.agentId
                    FROM Listings l
                    JOIN Property p ON l.address = p.address
                    JOIN House h ON p.address = h.address
                    WHERE 1=1";

            // Apply Filters if House Search is active
            if (isset($_GET['search_house'])) {
                if (!empty($_GET['min_price'])) $sql .= " AND p.price >= " . intval($_GET['min_price']);
                if (!empty($_GET['max_price'])) $sql .= " AND p.price <= " . intval($_GET['max_price']);
                if (!empty($_GET['beds'])) $sql .= " AND h.bedrooms >= " . intval($_GET['beds']);
                if (!empty($_GET['baths'])) $sql .= " AND h.bathrooms >= " . intval($_GET['baths']);
            }

            $result = $conn->query($sql);
            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    echo "<tr>
                        <td>" . $row["mlsNumber"] . "</td>
                        <td>" . $row["address"] . "</td>
                        <td>$" . number_format($row["price"]) . "</td>
                        <td>" . $row["bedrooms"] . "</td>
                        <td>" . $row["bathrooms"] . "</td>
                        <td>" . number_format($row["size"]) . "</td>
                        <td>" . $row["agentId"] . "</td>
                    </tr>";
                }
            } else {
                echo "<tr><td colspan='7'>No houses found.</td></tr>";
            }
            ?>
        </table>

        <h2>Business Listings</h2>
        <table>
            <tr>
                <th>MLS #</th>
                <th>Address</th>
                <th>Price</th>
                <th>Type</th>
                <th>Size (SqFt)</th>
                <th>Agent ID</th>
            </tr>
            <?php
            // Base Query for Business Properties
            $sql = "SELECT l.mlsNumber, p.address, p.price, b.type, b.size, l.agentId
                    FROM Listings l
                    JOIN Property p ON l.address = p.address
                    JOIN BusinessProperty b ON p.address = b.address
                    WHERE 1=1";

            // Apply Filters if Business Search is active
            if (isset($_GET['search_biz'])) {
                if (!empty($_GET['biz_min_price'])) $sql .= " AND p.price >= " . intval($_GET['biz_min_price']);
                if (!empty($_GET['biz_max_price'])) $sql .= " AND p.price <= " . intval($_GET['biz_max_price']);
                if (!empty($_GET['min_size'])) $sql .= " AND b.size >= " . intval($_GET['min_size']);
                if (!empty($_GET['max_size'])) $sql .= " AND b.size <= " . intval($_GET['max_size']);
            }

            $result = $conn->query($sql);
            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    echo "<tr>
                        <td>" . $row["mlsNumber"] . "</td>
                        <td>" . $row["address"] . "</td>
                        <td>$" . number_format($row["price"]) . "</td>
                        <td>" . $row["type"] . "</td>
                        <td>" . number_format($row["size"]) . "</td>
                        <td>" . $row["agentId"] . "</td>
                    </tr>";
                }
            } else {
                echo "<tr><td colspan='6'>No business properties found.</td></tr>";
            }
            ?>
        </table>
    </div>
</body>
</html>
