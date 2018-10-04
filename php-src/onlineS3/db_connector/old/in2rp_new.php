

<?php
function in2rp($conn) {
	
	$sql_delete = "DELETE FROM rp_data";
	$conn->query($sql_delete);
	
	$sql_delete = "DELETE FROM tmp_data";
	$conn->query($sql_delete);
	
	
	$col_sql = "SHOW COLUMNS FROM in_data";
	$col_res = $conn->query($col_sql);
	
	$y = 0;
	if ($col_res->num_rows > 0) {
		while($row = $col_res->fetch_assoc()) {
			$col = $row['Field'];
			if (contains($col, 'year')) {
				$year_array[$y++] = substr($col, 4);
			}
		}
	}
	
	$var_sql = "SELECT DISTINCT var_id, description FROM in_data";
	$var_res = $conn->query($var_sql);
	
	$imp_sel = "SELECT in_data.description, reg.code as code, in_data.var_id, reg.reg_id FROM in_data JOIN region reg ON in_data.region = reg.label";
	
	$import_res = $conn->query($imp_sel);
	
	$x = 0;
	if ($import_res->num_rows > 0) {
		while($row = $import_res->fetch_assoc()) {
			
			$var_id = $row['var_id'];
			$reg_id = $row['code'];

			$sql_insert = "INSERT INTO tmp_data (var_id, code) VALUES ('$var_id', '$reg_id')";
			
			$conn->query($sql_insert);
		}
	}
	
	for ($i=0; $i<count($year_array); $i++) {
		$year = 'year' . $year_array[$i];

						
		$sql_base = "INSERT INTO rp_data (var_id, reg_id, year_id, value)
						SELECT DISTINCT rt.var_id, rt.reg_id, '$year_array[$i]', ind.$year
						FROM tmp_data rt JOIN in_data ind ON rt.var_id = ind.var_id 
						JOIN region reg ON ind.region = reg.label AND rt.code = reg.code WHERE ind.$year > 0";
						
		 $conn->query($sql_base);
	
	}
	
	return  true;
}
?>