
<?php
	echo "<div class='graph'>";
	
	$graph_width = 280;
	$x_count = count($x_axis);
	$x_margin = $graph_width / $x_count;
	$svg_height = 350;
	$height=330;
	$x_start = 85;
	$ver_height = 54;
	
	echo "<div class='svg-tooltip'></div>";
	
	$bar_width = 16;
	$y_count = count($var);
	$pad = 3*$y_count;
	$bar_no = count($var) * count($x_axis);
	
	echo "<div class='annex line' style='padding:". (3*$y_count) ."px; position:relative; right:0'>";
	echo "<ul>";
	for ($i=0; $i<$y_count; $i++) {
		$y_label = $var[$i];
		$col2var[$y_label] = 'color-'.$i;
		echo "<li><p class=color-$i>$var[$i]</p></li>";
	}
	echo "</ul>";
	echo "</div>";
	
	echo "<div style='position:absolute;'>";
	echo "<svg width='670' height='$svg_height'>";
	
	echo "<g Index='2'>";
	$year_x_txt = $x_start;
	$year_x = $x_margin + $x_start;
	$hor_height = $svg_height - 10;
	for ($i=0; $i<count($x_axis); $i++) {
		$year_x_txt = $year_x - 12;
		$x_label = $x_axis[$i];
		echo "<text x='$year_x_txt' style='color:#000000; cursor:default; font-size:11px; fill:#000000; width:72; text-overflow:ellipsis;' text-anchor='start' transform='translate(0,0)' y='350' opacity='1'><tspan>$x_label</tspan></text>";
		echo "<path fill='none' d='M $year_x 336 L $year_x 330' stroke='#d7d7d7' stroke-width='3' opacity='1'></path>";
		$year_x += $x_margin*2;
		$year_x_txt = $year_x+$x_margin;
		$year_order[$x_label] = $i;
	}
	echo "<path fill='none' d='M $x_start 330 L 1130 330' stroke='#d7d7d7' stroke-width='1' zIndex='7' visibility='visible'></path>";
	
	echo "</g>";
	
	$y_count = count($var);
	$pad = 3*$y_count;
	$bar_no = count($var) * count($x_axis);
	$bar_width = ($bar_no>10) ? 16 * (9 / $bar_no) : 16;
	$bar_width = 16;
	
	for ($i=0; $i<$y_count; $i++) {
		$y_label = $var[$i];
		$col2var[$y_label] = 'color-'.$i;
	} 

	for ($i=0; $i<count($y_steps); $i++) {
		$y_steps[$i] = number_format($y_steps[$i],0,"",".");
	}
	
	echo "<g Index='2'>";
	$y_steps = array_reverse($y_steps);
	echo "<text style='color:#B64343;cursor:default;font-size:12px;fill:#B64343;width:71.83333333333333;text-overflow:ellipsis;' text-anchor='start'
	opacity='1' x='10' y='210' transform='rotate(270 10 210)'><tspan>$unit</tspan></text>";
		
	for ($i=1; $i<count($y_steps); $i++) {
		$x_path=$x_start+3;
		$height = $height - $ver_height;
		$height_txt = $height + 4;
		echo "<text y='$height_txt' x='25' style='color:#000000;cursor:default;font-size:11px;fill:#000000;width:71.83333333333333;text-overflow:ellipsis;' 
		text-anchor='start' transform='translate(0,0)' opacity='1'><tspan>$y_steps[$i]</tspan></text>";
		echo "<path fill='none' d='M $x_start $height L $x_path $height' stroke='#d7d7d7' stroke-width='1' opacity='1'></path>";
	}
	echo "<path fill='none' d='M $x_start 30 L $x_start 330' stroke='#d7d7d7' stroke-width='1' zIndex='7' visibility='visible'></path>";
	
	echo "</g>";
	
	echo "<g zIndex='1'>";
	$height=330;
	for ($i=0; $i<count($y_steps)-1; $i++) {
		$height = $height - $ver_height;
		echo "<path fill='none' d='M $x_start $height L 1200 $height' stroke='#dedede' stroke-width='1' zIndex='1' opacity='1' class='step-lines'></path>";
	}
	echo "</g>";
	
	$values_no = count($values);
	
	// se sxolia epeidi xtypaei to export tis eikonas
	echo "<text style='font-weight: 600;color:#707070;font-size:12px;fill:#8F8C8C;width:72;text-overflow:ellipsis;text-align: center;width: 670px;' text-anchor='start' transform='translate(0,0)' opacity='1' x='250' y='14'>
	<tspan>$label</tspan></text>";
	
	$point_dist = 28;
	
	$colors = array('color-0'=>'#3366cc', 'color-1'=>'#dc3912', 'color-2'=>'#ff9900', 'color-3'=>'#109618', 
			'color-4'=>'#990099', 'color-5'=>'#0099c6', 'color-6'=>'#dd4477', 'color-7'=>'#66aa00');
	
	$graph_height = 330;
	
	echo "<g zIndex='1'>";
	for ($y=0; $y<count($var); $y++) {
		$var_id = $var[$y];
		$col1 = ($group_type=='reg') ? $group_id : $var_id;
		$col2 = ($group_type=='reg') ? $var_id : $group_id;
		
		$color = $col2var[$var_id];
		$color_rgb = $colors[$color];
		
		$pp_x = 0;
		$pp_y = 0;
		
		$left = $x_margin + $x_start;
		
		for ($z=0; $z<count($x_axis); $z++) {
			$x_label = $x_axis[$z];
			
			$val = get_valByVar($conn, $tbl_id, $col2, $col1, $x_label);
			$value = ($val[0]['value']>0) ? $val[0]['value'] : 0;
			$value_txt = number_format($value,0,"",".");
			$height = $value / $max_y * 234;
			$height = $graph_height - 7 - $height;
			$txt_height = $height - 10;
			$rect_height = $height - 1;
			
			$tip_value = "<div style='text-align:left'>
				<p style='font-weight:bold; margin:3px; display:inline-block'>Variable: </p>$var_id <br>
				<p style='font-weight:bold; margin:3px; display:inline-block'>Value: </p>$value_txt <br>
				<p style='font-weight:bold; margin:3px; display:inline-block'>Year: </p>$year_id</div>";
				
			$tip_value = htmlspecialchars($tip_value, ENT_QUOTES, 'UTF-8');
			
			echo "<rect x='$left' y='$rect_height' width='2' height='2' style='fill:rgb(0,0,255); stroke-width:3; stroke:$color_rgb' id='$tip_value'/>";
			
			if ($pp_x > 0) {
				echo "<line x1='$pp_x' y1='$pp_y' x2='$left' y2='$height' style='stroke:$color_rgb; stroke-width:1' />";
			}
			
			$pp_x = $left;
			$pp_y = $height;
			$left += $x_margin*2;
		}
	}
	echo "</g>";
	echo "</svg>";
	echo "</div>";	
	echo "</div>";
?>