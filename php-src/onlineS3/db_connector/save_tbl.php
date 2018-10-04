<?php

function save_tbl($conn, $tbl_data) {
	$id_sel = 'SELECT max(table_id) as table_id FROM re_tables';
	$id_res = $conn->query($id_sel);
	
	$tbl_id = 0;
	
	if ($id_res->num_rows > 0) {
		while ($row = $id_res->fetch_assoc()) {
			$tbl_id = $row['table_id'] + 1;
		}
	}
	
	for ($i=0; $i<count($tbl_data); $i++) {
		$region_id = $tbl_data[$i][0];
		$var_id = $tbl_data[$i][1];
		$year_id = $tbl_data[$i][2];
		$unit = $tbl_data[$i][3];
		$value = $tbl_data[$i][4];
		
		$sql = "SELECT code FROM region WHERE label = '$region_id';";
		$res = exec_select($conn,$sql);
		$reg_id = $res[0]['code'];
		
		$sql_insert = "INSERT INTO re_tables (table_id, code, var_id, year_id, unit, value) 
						VALUES ($tbl_id, '$reg_id', '$var_id', '$year_id', '$unit', '$value')";
		$conn->query($sql_insert);
		
	}
		
	return $tbl_id;
}

?>