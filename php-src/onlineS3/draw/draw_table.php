
<?php 
	function draw_results($conn, $group_type, $tbl_id, $show_graph, $graph_type, $src) {
		if ($group_type == 'reg') {
			$sql = "SELECT DISTINCT rt.reg_id as reg_id, rr.label as label FROM re_tables rt JOIN region rr ON rr.reg_id = rt.reg_id WHERE rt.table_id = $tbl_id ORDER BY rt.reg_id";
			$col = 'reg_id';
		} else {
			$sql = "SELECT DISTINCT rt.var_id as var_id, rv.var_id as label FROM re_tables rt JOIN variable rv ON rv.var_id = rt.var_id WHERE table_id = $tbl_id ORDER BY var_id";
			$col = 'var_id';
		}
		$results = exec_select($conn, $sql);
		
		echo "<input name='current_graph' class='current_graph hide' value=''/>";
		
		for($i=0; $i<count($results); $i++) {
			$group_id = $results[$i][$col];
            $group_lb = $results[$i]['label'];
			$id_gr = 'show_graph' . $group_id;
			$id_cr = 'create_graph' . $group_id;
			$id_dn = 'show_down' . $group_id;
			$show_graph = $_POST[$id_gr];
			$create_graph = $_POST[$id_cr];
			$show_down = $_POST[$id_dn];

			echo "<div class='region-data'>";
			echo "<input name='$id_gr' id='$group_id' class='$id_gr hide' value='$show_graph'/>";
			echo "<input name='$id_cr' id='$group_id' class='$id_cr hide' value='$create_graph'/>";
			echo "<input name='$id_dn' id='$group_id' class='$id_dn hide' value=''/>";
			
			if ($group_type == 'reg') {
				$res = draw_results_reg($conn, $group_type, $tbl_id, $group_id, $src, $show_graph);
			} else {
				$res = draw_results_var($conn, $group_type, $tbl_id, $group_id, $src, $show_graph);
			}
			
			$wd_html .= $res['wd_html'];

            if ($src == 1) {
                echo "<div id='btn-area' class='$group_id'>";
                //echo "<input name='export-csv' id='$group_id' value='Export CSV' class='btn-nine button export-csv' type='submit'>";
                $filename = 'stock-data.csv';
                //$on_click = "return downloadCSV({ filename: '$filename' })";
                $rows = $res['rows'];
                $cols = $res['cols'];
                echo '<button id="$group_id" class="btn-nine button export-csv" onclick="return downloadCSV({filename: \'stock-data.csv\', rows:' . $rows . ' , cols:' . $cols . ', btn_id:\'' . $group_id . '\'})">Export CSV</button>';
                echo '<button id="$group_id" class="btn-nine button export-csv" onclick="window.exportData({filename: \'stock-data.csv\', rows:' . $rows . ' , cols:' . $cols . ', btn_id:\'' . $group_id . '\'})">Export XLS</button>';
                //echo "<input name='export-csv' id='$group_id' value='Export XLS' class='btn-nine button export-csv' type='submit'>";
                //echo "<input name='export-csv' id='$group_id' value='Export XLS' class='btn-nine button export-csv' type='submit'>";
                //echo "<input name='create-graph' id='$group_id' value='Show Graph' class='btn-nine button create-graph' onchange='render_bar_graph()' type='submit'>";
                echo '<button id="$group_id" class="btn-nine button" onclick="return render_bar_graph(
                    {filename: \'stock-data.csv\', rows:' . $rows . ' , cols:' . $cols . ', btn_id:\'' . $group_id . '\', group:\'' . $group_lb . '\'})">Show Graph</button>';
                echo "<input name='addTbl2Report' id='$group_id' value='Insert Table' class='btn-nine button addTbl2Report' type='submit'>";
                echo "</div>";
            }

			include 'php-src/onlineS3/export/export_csv.php';
			
			if ($show_down == 1) {
				echo "<p class='download-msg' id='$group_id' style='display:block'>$download_msg</p>";
			} else {
				echo "<p class='download-msg' id='$group_id' class='hide'></p>";
			}
			
			// draw graph
			// include 'wp-admin/php-fun/profile/post/create_graph.php';
			
			echo "</div>";
			
			echo "<hr class='sep'>";
		}
		
		echo "<input name='tbl_id' id='tbl_id' value='$tbl_id' class='hide'/>";
		echo "<input name='tbl_group_id' id='group_id' class='tbl hide' value='$group_id'/>";
		echo "<input name='graph_group_id' class='graph hide' id='group_id' value=''/>";
		echo "<input name='group_type' id='group_type' value='$group_type' class='hide'/>";
		
		return $res;
	}
	
	function draw_results_reg($conn, $group_type, $tbl_id, $region_id, $src, $show_graph) {
		
		$sql = "SELECT DISTINCT rt.reg_id as reg_id, rr.label as label FROM region rr JOIN re_tables rt ON rt.table_id = $tbl_id AND rt.reg_id = rr.reg_id WHERE rt.reg_id = '$region_id' ORDER BY rt.reg_id";
		$region = exec_select($conn, $sql);
		$reg_id = $region[0]['reg_id'];
		$label = $region[0]['label'];
		$wd_html = "<p>$label - $reg_id</p><table>";
			
		// get all years
		$sql = "SELECT DISTINCT year_id FROM re_tables WHERE table_id = $tbl_id AND reg_id = '$reg_id' ORDER BY year_id";
		$years = exec_select($conn,$sql);
		echo "<p class='section-header'>$label - <span style='color:red'>$reg_id</span></p>";
		
		// get unique vars by region
		$sql = "SELECT DISTINCT var_id FROM re_tables WHERE table_id = $tbl_id and reg_id = '$reg_id' and value > 0";
		$vars = exec_select($conn,$sql);
		
		echo "<div id='$region_id' class='tbl-div'>";
		echo "<div class='tbl-data style_four'>";
		
		// displays selected vars in graph
		$in_graph = '';
		if (isset($_POST['in-graph'])) {
			foreach ($_POST['in-graph'] as $check) {
				if (contains($check,$reg_id)) {
					$in_graph .= "'". $check . "'" . ","; }
			}
		}
		
		if (isset($_POST['create-graph']) and $_POST['current_graph'] == $reg_id) {
			$show_graph = 1;
			if ($in_graph == '') {
				if (count($vars) < 10) {
					for($y=0; $y<count($vars); $y++) {
						$var = $vars[$y]['var_id'];
						$in_graph .= "'". $reg_id . '-' . $var . "'" . ",";
					}
				} else {
					$graph_msg = 'Please select vars to include in graph.';
					$show_graph = 0;
				}
			}
		}
		$in_graph = '(' . substr($in_graph,0,strlen($in_graph)-1) . ')';
		$graph_col = ($show_graph == 1) ? 'inline-show' : 'hide';

		// print years
		echo "<div class='tbl-body row'>";
		$wd_html .= "<tr>";
		$wd_html .= "<td></td>";
		
		echo "<span class='cell small center in-graph bold $graph_col'>In Graph</span>";
		echo "<input class='cell large center bold' id='$region_id:0:0' value='Variable'/>";
		for($z=0; $z<count($years); $z++) {
			$year = $years[$z]['year_id'];
            $cell_indx = $region_id . ':0:' . ($z+1);
			echo "<input class='cell mediun center bold' id='$cell_indx' value='$year'/>";
			$wd_html .= "<td>$year</td>";
		}
		$wd_html .= "</tr>";
		echo "</div>";

		$count = 0;
		// get value per var and year
		for($y=0; $y<count($vars); $y++) {
			$var = $vars[$y]['var_id'];
			
			$wd_html .= "<tr>";
			$wd_html .= "<td>$var</td>";
			echo "<div class='row tbl-body'>";
			
			$checked = (contains($in_graph, $var)) ? 'checked' : '';
            $even = ($y%2==0) ? 'even' : 'odd';

			echo "<input type='checkbox' name='in-graph[]' id='chk-$reg_id-$y' value='$reg_id-$var' class='$graph_col' $checked/>";
			echo "<label for='chk-$reg_id-$y' class='cell small check $graph_col in-graph $even'></label>";
            $cell_indx = $region_id . ':' . ($y+1) . ':0';
			echo "<input class='cell label large left $even' type='text' value='$var' id='$cell_indx'/></input>";
			for($z=0; $z<count($years); $z++) {
				$year = $years[$z]['year_id'];
				$sql = "SELECT value FROM re_tables WHERE table_id = $tbl_id and var_id = '$var' AND year_id = '$year' AND reg_id = '$reg_id'";
				$val = exec_select($conn, $sql);
				$value = ($val[0]['value']>0) ? number_format($val[0]['value'],2,".","") : 0;	

                $cell_indx = $region_id . ':' . ($y+1) . ':' . ($z+1);
				echo "<input class='cell mediun $even' name='' value = '$value' id='$cell_indx' type='text'/>";
				$wd_html .= "<td>$value</td>";
			}
			
			echo "</div>";
			$wd_html .= "</tr>";
			$count++;
		}
		echo "</div>";
		echo "</div>";
		
		$wd_html .= "</table>";
		$res = array('wd_html'=>$wd_html, 'in_graph'=> $in_graph, 'graph_msg'=> $graph_msg, 'rows'=>count($vars)+1, 'cols'=>count($years)+1);
		return $res;
	}
	
	function draw_results_var($conn, $group_type, $tbl_id, $var_id, $src, $show_graph) {
		$sql = "SELECT DISTINCT rt.var_id as var_id, rv.description as description FROM variable rv JOIN re_tables rt ON rt.table_id = $tbl_id AND 
				rt.var_id = rv.var_id AND rv.var_id = '$var_id' ORDER BY rv.var_id";
		$var = exec_select($conn,$sql);
		
		$var_id = $var[0]['var_id'];
		$description = $var[0]['description'];
		
		$wd_html = "<p>$var_id - $description</p><table>";
		
		// get all years
		$sql = "SELECT DISTINCT year_id FROM re_tables WHERE table_id = $tbl_id AND var_id = '$var_id' ORDER BY year_id";
		$years = exec_select($conn,$sql);
		
		echo "<p class='section-header'>$description - $var_id</p>";
		
		// get unique vars by region
		$sql = "SELECT DISTINCT rr.reg_id, rr.label FROM re_tables re JOIN region rr ON re.reg_id = rr.reg_id WHERE re.table_id = $tbl_id and re.var_id = '$var_id'";
		$regions = exec_select($conn,$sql);
		
		echo "<div id='$var_id' class='tbl-div'>";
		echo "<div class='tbl-data style_four'>";
		
		// displays selected vars in graph
		$create_init = 1;

        // displays selected vars in graph
        $in_graph = '';
        if (isset($_POST['in-graph'])) {
            foreach ($_POST['in-graph'] as $check) {
                if (contains($check,$var_id)) {
                    $in_graph .= "'". $check . "'" . ","; }
            }
        }

        if (isset($_POST['create-graph']) and $_POST['current_graph'] == $var_id) {
            $show_graph = 1;
            if ($in_graph == '') {
                if (count($regions) < 10) {
                    for($y=0; $y<count($regions); $y++) {
                        $reg = $regions[$y]['reg_id'];
                        $in_graph .= "'". $var_id . '-' . $reg . "'" . ",";
                    }
                } else {
                    $graph_msg = 'Please select vars to include in graph.';
                    $show_graph = 0;
                }
            }
        }
        $in_graph = '(' . substr($in_graph,0,strlen($in_graph)-1) . ')';
        $graph_col = ($show_graph == 1) ? 'inline-show' : 'hide';
		
		// print years
		echo "<div class='tbl-body row'>";
		$wd_html .= "<tr>";
		$wd_html .= "<td></td>";
		echo "<span class='cell small center in-graph bold $graph_col'>In Graph</span>";
		echo "<input class='cell large center bold' id='$var_id:0:0' value='Region'/>";
		for($z=0; $z<count($years); $z++) {
			$year = $years[$z]['year_id'];
            $cell_indx = $var_id . ':0:' . ($z+1);
			echo "<input class='cell center medium bold' id='$cell_indx' value='$year'/>";
			
			$wd_html .= "<td>$year</td>";
		}
		$wd_html .= "</tr>";
		echo "</div>";
		
		$count = 0;
		// get value per region and year
		for($y=0; $y<count($regions); $y++) {
			$region = $regions[$y]['reg_id'];
            $even = ($y%2==0) ? 'even' : 'odd';

			// checks if there are non-zero results
			$has_res = exec_select($conn,"SELECT 1 FROM re_tables WHERE table_id = $tbl_id AND reg_id = '$region' AND var_id = '$var_id' AND value > 0");
			if (count($has_res) == 0 ) { continue;}
			$wd_html .= "<tr>";
			$region_desc = $regions[$y]['reg_id'] . ' - ' . $regions[$y]['label'];
			echo "<div class='row tbl-body'>";
            $checked = (contains($in_graph, $region)) ? 'checked' : '';

			echo "<input type='checkbox' name='in-graph[]' id='chk-$var_id-$y' value='$var_id-$region' class='$graph_col' $checked/>";
			echo "<label for='chk-$var_id-$y' class='cell small check in-graph $even $graph_col'></label>";
            $cell_indx = $var_id . ':' . ($y+1) . ':0';
			echo "<input class='cell label large left $even' type='text' value='$region_desc' id='$cell_indx'/></input>";
			
			$wd_html .= "<td>$region</td>";
			
			for($z=0; $z<count($years); $z++) {
				$year = $years[$z]['year_id'];
				$sql = "SELECT value FROM re_tables WHERE table_id = $tbl_id and reg_id = '$region' AND year_id = '$year' and var_id = '$var_id'";
				$val = exec_select($conn,$sql);
				$value = ($val[0]['value']>0) ? number_format($val[0]['value'],2,".","") : 0;
                $cell_indx = $var_id . ':' . ($y+1) . ':' . ($z+1);
				echo "<input class='cell medium right $even' name='$cell_indx' value='$value' id='$cell_indx' type='text'/>";
				
				$wd_html .= "<td>$value</td>";
			}
			echo "</div>";
			
			$wd_html .= "</tr>";
			$count++;
		}
		echo "</div>";
		echo "</div>";
		$wd_html .= "</table>";
		
		$res = array('wd_html'=>$wd_html, 'in_graph'=> $in_graph, 'count'=> $count, 'show_graph'=>$show_graph , 'graph_msg'=> $graph_msg, 'rows'=>count($regions)+1, 'cols'=>count($years)+1);
		
		return $res;
	}
	
?>