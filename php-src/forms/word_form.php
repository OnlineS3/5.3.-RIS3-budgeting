<?php

echo "<div id='word-div' class='hide'>";
    
    
    
    if($summary_tbl) {
        $group_prev = '-100';
        $z=1;
        foreach ($summary_tbl as $row) {
            
            if($z>1) {echo '<br>';}
            
            $group_val = $row['row_id'];
            
            if ($group_prev==$group_val) {
                continue;
            }
            echo "<table style='font-family: calibri'>";
            $i=0;
            foreach ($headers as $key=>$header) {
                
                if(($show_cols[$key]==1 && $key!=$group_type)) {
                    echo "<tr>";
                    $style = ($key == 'group_col') ? "style='font-weight:bold; text-transform:uppercase'" : "style='text-transform:uppercase'";    
                    $val = ($key == 'group_col') ? $headers[$header] : $header;
                    $val .= ':';
                    echo "<td $style>$val</td>";
                    $i++;
                    
                $style = ($key == 'group_col') ? "style='text-align:left;font-weight:bold'" : "style='text-align:left;'";    
                echo "<td $style>";
 
                    $cell = $row[$key];
                    echo $cell;
  
                    echo "</td>";
                    echo "</tr>";
                }
            }
            
            $y=0;
            foreach ($years as $year) {
                
                $planned_val = $budget_res[$group_val][$year]['planned'];
                echo "<tr>";
                echo "<td style='width:180px'>$year - Planned Value:</td>";
                echo "<td style='text-align:left'>$planned_val</td>";
                echo "</tr>";
                
                $commit_val = $budget_res[$group_val][$year]['commit'];
                echo "<tr>";
                echo "<td style='width:180px'>$year - Committed Value:</td>";
                echo "<td style='text-align:left'>$commit_val</td>";
                echo "</tr>";
                
                $spent_val = $budget_res[$group_val][$year]['commit'];
                echo "<tr>";
                echo "<td style='width:180px'>$year - Spent Value:</td>";
                echo "<td style='text-align:left'>$spent_val</td>";
                echo "</tr>";
                
                echo "</tr>";
                
            }
            
            $group_prev = $group_val;
            $z++;
            
            echo "</table>";
        }
    }
    
    
    
    
echo "</div>";
