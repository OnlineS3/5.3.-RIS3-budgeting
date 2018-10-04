
<?php
	
    function exec_upd($conn, $upd_sql) {
        if ($conn->query($upd_sql) === TRUE) {
            return $conn->update_id;
        } else {
            echo $conn->error;
            return false;
        }
    }

    function exec_ins($conn, $upd_sql) {
        if ($conn->query($upd_sql) === TRUE) {
            return $conn->insert_id;
        } else {
            echo $conn->error;
            echo $upd_sql;
            return 0;   
        }
    }
	
    function exec_del($conn, $del_sql) {
        if ($conn->query($del_sql) === TRUE) {
            return true;
        } else {
            echo $conn->error;
            return false;
        }
    }

    function exec_select($conn, $sql) {
        $res = $conn->query($sql);
        echo $conn->error;
        $i=0;
        if($res->num_rows>0) {
            while($fieldinfo=mysqli_fetch_field($res)) {
                $fields[$i++] = $fieldinfo->name;
            }
        }

        $y = 0;
        if($res->num_rows>0) {
            while($row = $res->fetch_assoc()) {
                for($i=0;$i<count($fields);$i++) {
                    $field = $fields[$i];
                    $res_out[$y][$field] = $row[$field];
                }
                $y++;
            }
        }
        return $res_out;
    }

?>