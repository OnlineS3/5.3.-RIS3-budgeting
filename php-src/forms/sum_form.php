<?php
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['filter_results'])) {
    
    $group_type = $_POST['group_col'][0];
        
    $prio_filters=$programme_filters=$object_filters=$inter_filters=$fin_filters=$fund_filters=array();
    
    $filters = array('prio'=>$prios,'programme'=>$programmes,'object'=>$objects,
        'inter'=>$inters,'finance'=>$finances,'funding'=>$funds,'year'=>$years);
    
    $summary_tbl = get_summary($conn,$user_id,$filters,$show_col,$group_type);
    
    $headers = array('group_col'=>$group_type,'prio'=>'Priority','programme'=>'Programme','object'=>'Objective',
        'inter'=>'Intervention','finance'=>'Finance','funding'=>'Funding',
        'year'=>'Year','planned_val'=>'Planned Value','committed_val'=>'Committed Value','spent_val'=>'Spent Value');

    if(count($summary_tbl)>0) {
        $years = array_unique(array_map(function ($i) { return $i['year']; }, $summary_tbl));
        $budget_tbl = array('year','planned','commit','spent');
    }
    
    if(count($summary_tbl)>0) {
        $z=0;

        foreach ($summary_tbl as $row) {

            $group_val = $row['row_id'];
            foreach ($row as $key=>$cell) {
                $year = $row['year'];
                if (in_array($key, $budget_tbl)) {
                    $budget_res[$group_val][$year][$key] = $cell;
                }
            }
            $z++;
        }
    }
    
    echo "<div class='results'>";
    if(count($summary_tbl)>0) {
        echo "<div class='summary-div'>";
    
        echo "<table class='budget-table summary' id='summary'>";
        echo "<thead>";
        $i=0;
        foreach ($headers as $key=>$header) {

            if($show_cols[$key]==1 && $key!=$group_type) {
                //$cls = ($key == 'group_col') ? 'group_col headcol' : '';
                $cls = ($key == 'group_col') ? 'group_col' : '';
                $val = ($key == 'group_col') ? $headers[$header] : $header;
                $id = '0_'.$i;
                echo "<th id='$id' class='$cls'>$val</th>";
                $i++;
            }
        }

        if(count($summary_tbl)>0) {
            foreach ($years as $year) {
                echo "<th style='padding-bottom:0' class='header-div'><table class='budget-headers'>";
                echo "<tr><td colspan='3' class='year-header'>$year</td></tr>";
                $id = '0_'.$i;$i++;
                echo "<tr><th id='$id'>Planned Value</th>";
                $id = '0_'.$i;$i++;
                echo "<th id='$id'>Committed Value</th>";
                $id = '0_'.$i;$i++;
                echo "<th id='$id'>Spent Value</td></tr>";
                echo "</table></th>";
            }
        }

        echo "</thead>";
        echo "<tbody>";



        if($summary_tbl) {
            $group_prev = '-100';
            $z=1;
            foreach ($summary_tbl as $row) {
                $group_val = $row['row_id'];

                if ($group_prev==$group_val) {
                    continue;
                }

                echo "<tr>";
                $i=0;

                foreach ($row as $key=>$cell) {
                    if(($show_cols[$key]==1) && $key!=$group_type) {

                        if(strripos($cell,',') > 0 && strripos($cell,',') == strlen($cell)-1) {
                            $cell = substr($cell,1,strlen($cell)-2);
                        }

                        if ($key == 'group_col') {
                            $cell = ($group_type == 'object' || $group_type == 'finance' || $group_type == 'inter' ) ? ($row['row_id'] . '-' . $row['group_col']) : $row['group_col'];
                            //$cls = 'group_col headcol';
                            $cls = 'group_col';

                        } else {
                            $cell = utf8_encode(str_replace(',','<hr>',$cell)); 
                            $cls = '';
                        }
                        $id = $z.'_'.$i;
                        echo "<td id='$id' class='$cls'>$cell</td>";
                        $i++;
                    }  
                }

                $y=0;
                foreach ($years as $year) {

                    $planned_val = $budget_res[$group_val][$year]['planned'];
                    $commit_val = $budget_res[$group_val][$year]['commit'];
                    $spent_val = $budget_res[$group_val][$year]['spent'];

                    echo "<td class='budget-vals'><table><tr>";

                    $id = $z.'_'. ($i+$y);$y++;
                    echo "<td id=$id>$planned_val</td>";
                    $id = $z.'_'. ($i+$y);$y++;
                    echo "<td id=$id>$commit_val</td>";
                    $id = $z.'_'. ($i+$y);$y++;
                    echo "<td id=$id>$spent_val</td>";

                    echo "</tr></table></td>";
                }

                $group_prev = $group_val;
                $z++;
            }
        }

        echo "</tbody>";
        echo "</table>";
        echo "</div>";
    } else {
        echo "<p class='no-results'>No results found.</p>";
    }
    

    echo "</div>";
}

