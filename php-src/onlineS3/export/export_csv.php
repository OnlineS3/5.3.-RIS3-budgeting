

<?php
	if($_SERVER["REQUEST_METHOD"] == "POST" and isset($_POST['export-csv'])) {
		
		$filename = 'export_'.date('Y-m-d').'.csv';
			
		$x = 0;
		$tbl_id = $_POST['tbl_id'];
		$group_id = $_POST['tbl_group_id'];
		$group_t = $_POST['group_type'];
		$header = "reg_id, var_id, year_id, value" . "\n";
		
		if ($group_t == 'reg') {
			$query = "SELECT * FROM re_tables WHERE table_id = $tbl_id and reg_id = '$group_id'";
			
		} else {
			$query = "SELECT * FROM re_tables WHERE table_id = $tbl_id and var_id = '$group_id'";
		}
		
		$result = $conn->query($query);
		$num_rows = $result->num_rows;
			
		if($num_rows >= 1) {
			$fp = fopen($filename, "w");
			$separator = "";
			$comma = "";
			$row = $result->fetch_assoc();
			fputs($fp, $header);
			while($row = $result->fetch_assoc()) {
				$separator .= str_replace('', '""', $row['reg_id']) . "," .str_replace('', '""', $row['var_id']) . "," .str_replace('', '""', $row['year_id']) . "," .str_replace('', '""', $row['value']) . "\n";
			}
			fputs($fp, $separator);	
			fclose($fp);
				
			$download_msg = "Your file has been downloaded. You can download it from " . "<a id='export-ref' href='http://localhost/regplain/$filename'>here</a>";
			}
		else {
			$download_msg = "There is no record in your Database"; 
		}
		
	}
?>