
<?php
    function normalize_input($data) {
        $data = utf8_encode($data);
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }
?>