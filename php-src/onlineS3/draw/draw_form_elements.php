<?php
/**
 * Created by PhpStorm.
 * User: elvira
 * Date: 05/12/2016
 * Time: 17:30
 */

function fill_ddl_list($cols) {
    echo "<select class='online-select'>";
    foreach ($cols as $val) {
        echo "<option value='$val'>$val</option>";
    }
    echo "</select>";
}

?>