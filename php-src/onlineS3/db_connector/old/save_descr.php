<?php
function save_descr($description) {

	$servername = 'localhost';
	$username = 'root';
	$password = '25ye$ando5';
	$dbname = 'regata';
	
	$current_date = date('Y-m-d H:i:s', time());

	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);

	// Check connection
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	
	$rd_id = 25;
	
	$sel_sql = "SELECT * FROM rd_desc WHERE rd_id = $rd_id";
	$sel_descr = $conn->query($sel_sql);
	if ($sel_descr->num_rows > 0) {
		$upd_descr = "UPDATE rd_desc SET descr_body='$description' WHERE rd_id=$rd_id";
		$upd_res = $conn->query($upd_descr);
	} else {
		$insert_descr = "INSERT INTO rd_desc (rd_id, descr_body) values ($rd_id, '$description')";
		$ins_res = $conn->query($insert_descr);
	}
	
	if ($upd_res === TRUE or $ins_res === TRUE ) {
		$succeed = TRUE;
	} else {
		$succeed = FALSE;
	}
	
	$conn->close();
	
	return array($rd_id, $succeed);
	
}
?>