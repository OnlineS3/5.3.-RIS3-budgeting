
<?php
function conn_db() {
    $servername = 'localhost';
    $username = 'root';
    $password = '25ye$ando5';
    $dbname = 'budgeting';

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    
    mysqli_set_charset($conn,"utf8");

    // Check connection
    if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
    } 

    return $conn;
}
?>