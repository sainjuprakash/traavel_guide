<?php
function getConnection() {
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "bkt_guide";
    
    try {
        // Create a PDO connection
        $pdo = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
        
        // Set PDO error mode to exception
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        echo "Connected successfully";
        return $pdo;
    } catch(PDOException $e) {
        // Handle connection errors
        echo 'Connection failed: ' . $e->getMessage();
        die();
    }
}
$conn=getConnection();
if(!$conn){
    echo "error";
}else{
    echo "connection successful";
}
?>
