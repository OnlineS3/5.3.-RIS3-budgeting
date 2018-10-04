
<?php

	echo "<div class='graph'>";
	echo "<div class='hor-line'></div>";
	echo "<div class='ver-line'></div>";
		
	$x_count = count($x_axis);
	$x_margin = 215 / ($x_count*1.4);
	if ($x_count<5) {
		$grp_x_width = 380 / ($x_count/(1+ .035*($x_count*1.15)));
	} else {
		$grp_x_width = 380 / ($x_count/(1+ .045*($x_count*1.25)));
	}
	
	echo "<div class='hor-titles'>";
	
	for ($i=0; $i<count($x_axis); $i++) {
		echo "<label style='margin: 0 " . $x_margin . "px'>$x_axis[$i]</label>";
		
		$x_val = $x_axis[$i];
		$x_order[$x_val] = $i;
	}
	
	echo "</div>";
	
	$bar_width = 26;
	$y_count = count($var);
	$pad = 3*$y_count;
	$bar_no = count($y_count) * count($x_count);
	
	echo "<div class='annex' style='padding:". (3*$y_count) ."px'>";
	echo "<ul>";
	for ($i=0; $i<$y_count; $i++) {
		$y_label = $var[$i];
		$col2var[$y_label] = 'color-'.$i;
		echo "<li><p class=color-$i>$var[$i]</p></li>";
	}
	echo "</ul>";
	echo "</div>";
	
	echo "<div class='ver-titles'>";
	echo "<p class='unit'>$unit</p>";
	for ($i=0; $i<count($y_steps)-1; $i++) {
		$y_steps[$i] = number_format($y_steps[$i],0,"",".");
		echo "<div class='steps'><label>$y_steps[$i]</label>";
		echo "<div class='step-line'></div></div>";
	}
	echo "</div>";

	echo "<div class='values'>";
	$values_no = count($values);
	$tot_width = 0;
	
	echo "<p class='group-label'>$label</p>";
	for ($y=0; $y<count($x_axis); $y++) {
		$x_val = $x_axis[$y];
		
		if ($group_type == 'reg'){
			$val = get_valByYearRG($conn, $tbl_id, $x_val, $group_id, $var_ls);
		} else {
			$val = get_valByYearVar($conn, $tbl_id, $x_val, $group_id, $var_ls);
		}
		
		if (count($val) == 1) {
			$bar_width = 20;
			$tot_width = $bar_width;
		} else {
			$bar_width = $grp_x_width/1.5 * (.2 *$x_count) / (count($val)+1.2) ;
			$tot_width = count($val) * ($bar_width +4);
		}
		
		$grp_x_left = $grp_x_width * $y + ($grp_x_width / 2);
		
		echo "<div class='year-bars' style='text-align:center; left: $grp_x_left" . "px'>";
		for ($i=0; $i<count($val); $i++) {
			if ($group_type == 'reg'){
				$var = $val[$i]['var_id'];
			} else {
				$var = $val[$i]['reg_id'];
			}
				
			$color = $col2var[$var];
			$left = (($bar_width) * ($i));
			$value = $val[$i]['value'];
			$value_txt = number_format($value,0,"",".");
			
			$tool_value = "<div style='text-align:left'>
				<span style='font-weight:bold'>Variable:</span> $var <br>
				<span style='font-weight:bold'>Value:</span> $value_txt <br>
				<span style='font-weight:bold'>Year:</span> $x_val</div>";
			
			$height = $value / $max_y * 264;
			
			$bar_style = "margin: 0 2px; width:" . $bar_width . "px; height:".$height."px";
			$tooltip_style = "bottom: ".($height+10)."px; ";
			
			echo "<a class='tooltip-container'>";
			echo "<div class='bar $color' style='$bar_style'></div>";
			echo "<span class='tooltiptext arrow-bottom' style='$tooltip_style'>$tool_value</span>";
			echo "</a>";
		}
		echo "</div>";
	}	
	
	echo "</div>";
	echo "</div>";
	
?>