
<?php
function fill_filters($conn, $sql, $tbl) {

	$col_sql = "SHOW COLUMNS FROM $tbl";
	
	$col_res = $conn->query($col_sql);
	
	$x = 0;
	if ($col_res->num_rows > 0) {
		while($row = $col_res->fetch_assoc()) {
			$cols[$x++] = $row['Field'];
		}
	}
	
	$sel_rd = $conn->query($sql);
	
	$i = 0;
	
	if ($sel_rd->num_rows > 0) {
		while($row = $sel_rd->fetch_assoc()) {
			for ($j=0; $j<count($cols); $j++) {
				$col_name = $cols[$j];
				$rd_res[$i][$col_name] = $row[$col_name];
			}
			$i = $i + 1;
		}
	}
	
	return  $rd_res;
}
?>