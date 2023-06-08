<?php
require_once 'database.php'; // Include the database.php file

// Get the PDO connection
$pdo = getConnection();

$stmt = $pdo->prepare("SELECT * FROM temples");
$stmt->execute();

// Fetch the data
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Return the data as JSON
header('Content-Type: application/json');
echo json_encode($data);
?>