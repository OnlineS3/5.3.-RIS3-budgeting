<?php

    $user = wp_get_current_user();
    $user_id =  isset( $user->ID ) ? (int) $user->ID : 0;

    include 'php-src/templates/header.php';
   
    $home = 'http://' . $_SERVER['SERVER_NAME'] . '/home';

    echo "<div class='budgeting'>";
    
    echo "<div id='about' class='section-page hide plain'>";
    include 'php-src/templates/about.php';
    echo "</div>";
    
    echo "<div id='docs' class='section-page hide plain'>";
    include 'php-src/templates/docs.html';
    echo "</div>";

    echo "<div id='guide' class='section-page hide plain'>";
    include 'php-src/templates/guide.php';
    echo "</div>";
    
    echo "<div id='tool' class='tool-page section-page hide' style='min-height:650px'>";
    include 'php-src/templates/tool.php';
    echo "</div>";
    
    echo "</div>";
    
    echo "</div>";
    
    include 'sidebar.php';
    
    include 'php-src/templates/footer.php';
    
?>