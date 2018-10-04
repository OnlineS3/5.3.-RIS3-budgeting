<?php

function has_reg_results($conn, $tbl_id, $reg_id) {
	
	$sel = "SELECT 1 FROM re_tables WHERE table_id = $tbl_id and code='$reg_id'";
	$res = $conn->query($sel);
	
	if ($res->num_rows > 0) {
		return true;
	}
	
	return false;
}

function has_var_results($conn, $tbl_id, $var_id) {
	
	$sel = "SELECT 1 as has_results FROM re_tables WHERE table_id = $tbl_id and var_id='$var_id'";
	$res = $conn->query($sel);
	
	if ($res->num_rows > 0) {
		return true;
	}
	
	return false;
}

?>