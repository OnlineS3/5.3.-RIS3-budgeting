<?php

include 'php-src/db_func/save_dt.php';

if ($_SERVER["REQUEST_METHOD"] == "POST" && (isset($_POST['data-analysis']) || isset($_POST['save-data']))) {
    save_plan($conn,$user_id);    
}

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['publish-data'])) {
    publish_data($conn,$user_id);
}