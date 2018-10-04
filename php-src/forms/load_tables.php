<?php

function load_region($conn,$regions,$chosen) {

    $nuts_labels = get_nuts_labels($conn);
    $nuts_0 = $nuts_labels['nuts_0'];
    $nuts_1 = $nuts_labels['nuts_1'];
    $nuts_2 = $nuts_labels['nuts_2'];
    $nuts_0_json = $nuts_labels['nuts_0_json'];
    $nuts_1_json = $nuts_labels['nuts_1_json'];
    $nuts_2_json = $nuts_labels['nuts_2_json'];
    
    if ($chosen) {
        $chosen_len = strlen($chosen);
        switch($chosen_len) {
            case 2:
                $level_db = 0;
                break;
            case 3:
                $level_db = 1;
                break;
            case 4:
                $level_db = 2;
                break;
            default:
                $level_db = 0;
        }
    }
    
    $nuts_level = ($chosen) ? $level_db : (($_POST['nuts_level']) ? $_POST['nuts_level'] : 0);
    
    $nuts_0_checked = $nuts_1_checked = $nuts_2_checked = '';
    switch($nuts_level) {
        case 0:
            $case = 0;
            $regions = $nuts_0;
            $nuts_0_checked = 'checked';
            break;
        case 1:
            $case = 1;
            $regions = $nuts_1;
            $nuts_1_checked = 'checked';
            break;
        case 2:
            $case = 2;
            $regions = $nuts_2;
            $nuts_2_checked = 'checked';
            break;
        default:
            $case = -1;
    }
    
    echo "<p class='tip hide' style='display:inline-block; margin-right: -6px;'>Choose Nuts level:</p>";

    echo "<div class='radio-primary check-import'>
    <div><input id='nuts-0' value='0' class='nuts_level' name='nuts_level' type='radio' onchange='return fillRegions($nuts_0_json);' $nuts_0_checked><label for='nuts-0'>NUTS 0</label></div>
    <div><input id='nuts-1' value='1' class='nuts_level' name='nuts_level' type='radio' onchange='return fillRegions($nuts_1_json);' $nuts_1_checked><label for='nuts-1'>NUTS 1</label></div>
    <div><input id='nuts-2' value='2' class='nuts_level' name='nuts_level' type='radio' onchange='return fillRegions($nuts_2_json);' $nuts_2_checked><label for='nuts-2'>NUTS 2</label></div>
    </div>";
    
    if($chosen) {
        $post_region = $chosen;
    } else if (isset($_POST['select_region'])) {
        foreach ($_POST['select_region'] as $option) {
            $post_region = $option; 
        }
    } else {
        $post_region = $_POST['region'];
    }
    
    echo "<select id='choose-region' name='select_region[]' class='choose-region chosen-select' data-placeholder='region ..' >";
    echo "<option value=''></option>";
    foreach ($regions as $region) {
        $region_id = $region['code'];
        $region_lb = $region['label'];
        $selected = ($post_region) ? ((contains($post_region, $region_id)) ? 'selected' : '') : (($chosen) ? ((contains($chosen, $region_id) ? 'selected' : '')) : '');
        echo "<option value='$region_id' $selected>$region_id - $region_lb</option>";
    }
    echo "</select>";
    
    echo "<input id='region' class='hide' name='region' type='text' value='$post_region' />";
}

function load_years($years,$chosen) {

    echo "<select id='choose-years' class='choose-years chosen-select' data-placeholder='year ..' >";
    echo "<option value=''></option>";
    foreach ($years as $year) {
        echo "<option>$year</option>";
    }
    echo "</select>";
    
    echo "<span class='show-years'>Selected years:</span>";
    echo "<table id='selected-years' cellspacing='7'><tr>";
    
    if($chosen) {
        foreach($chosen as $cell) {
            $year = $cell['year'];
            $del_id = 'del_'+ $year;
            echo "<td><span>" . $year . "<i class='fa fa-times' id='" . $del_id . 
                    "' style='cursor:pointer' title='remove year' "
                    . "onclick='return delCol(\"$year\",\"$del_id\");'></i></span>"
                    . "</td>";
            
            $post_years .= $year . ' ';
        }
    } else {
        $post_years = $_POST['years'];
    }
    
    echo "<input id='years' class='hide' name='years' type='text' value='$post_years' />";
    
    echo "</tr></table>";

}

function load_parent($conn,$user_id,$years,$prios) {
    
    $headers_ini = array('RIS3 priority','Funding source','Intervention field','Form of finance');
    
    $dd_res = get_dd_res($conn,$user_id);
    
    $object_list = $dd_res['object_json'];
    $inter_list = $dd_res['inter_json'];
    $finance_list = $dd_res['finance_json'];
    $funding_list = $dd_res['funding_json'];
    
    
    echo "<div class='parent-div'>";
    
    echo "<div class='table-div'>";
    
    echo "<table class='budget-table parent' id='main-table'>";

    // render cols
    echo "<thead><tr>";
    echo "<th class='base headcol'>RIS3 priority</th>";
    echo "<th class='base'>Measures</th>";
    echo "<th class=''>Programme</th>";
    echo "<th class='extra hide'>Objective</th>";
    echo "<th class='extra hide'>Intervention</th>";
    echo "<th class='extra hide'>Form of finance</th>";
    echo "<th class='extra hide'>Funding source</th>";
    echo "<th class='comment-td extra hide'>Comment</th>";
    
    if($years) {
        foreach($years as $cell) {
            $year = $cell['year'];
            echo "<th class='new-col ".$year."' id='".$year."'>".$year."</th>";
        }
    }
    echo "<th class='btn-td'></th>";
    
    echo "</tr></thead>";
    
    echo "<tbody>";
    $i=1;
    
    if($prios) {
        foreach($prios as $prio){    
            $cls = ($i==1)? 'active' : '$i';
            $id = $prio['prio_id'];
            $description = $prio['description'];
            $measure = $prio['measure'];
            
           // $measure = ($prio['measure']) ? str_replace(",","<br>",$prio['measure']) : '';
            $measure = ($prio['measure']) ? "<li>".str_replace(",","</li><li>",$prio['measure'])."</li>" : '';
            $programme = ($prio['programme']) ? "<li>".str_replace(",","</li><li>",$prio['programme'])."</li>" : '';
            $object = ($prio['object']) ? "<li>".str_replace(",","</li><li>",$prio['object'])."</li>" : '';
            $inter = ($prio['inter']) ? "<li>".str_replace(",","</li><li>",$prio['inter'])."</li>" : '';
            $finance = ($prio['finance']) ? "<li>".str_replace(",","</li><li>",$prio['finance'])."</li>" : '';
            $funding = ($prio['funding']) ? "<li>".str_replace(",","</li><li>",$prio['funding'])."</li>" : '';
            
            $comment = $prio['comment'];
            
            $has_measure = (strlen($prio['measure'])>0) ? '' : 'hide';
            $has_programme = (strlen($prio['programme'])>0) ? '' : 'hide';
            $has_object = (strlen($prio['object'])>0) ? '' : 'hide';
            $has_inter = (strlen($prio['inter'])>0) ? '' : 'hide';
            $has_finance = (strlen($prio['finance'])>0) ? '' : 'hide';
            $has_funding = (strlen($prio['funding'])>0) ? '' : 'hide';
            $has_comment = (strlen($prio['comment'])>0) ? '' : 'hide';

            $null_measure = (strlen($prio['measure'])==0) ? '' : 'hide';
            $null_programme = (strlen($prio['programme'])==0) ? '' : 'hide';
            $null_object = (strlen($prio['object'])==0) ? '' : 'hide';
            $null_inter = (strlen($prio['inter'])==0) ? '' : 'hide';
            $null_finance = (strlen($prio['finance'])==0) ? '' : 'hide';
            $null_funding = (strlen($prio['funding'])==0) ? '' : 'hide';
            $null_comment = (strlen($prio['comment'])==0) ? '' : 'hide';
            
            $res = exec_select($conn, "SELECT 1 FROM measure WHERE prio_id=$id;");
            $measure_style = (count($res)==0 && strlen($prio['measure'])==0) ? "" : "hide";

            echo "<tr class='$cls' id='$i'>

            <td class='priority-td textarea base headcol' id='".$i."_priority'>
                <textarea name='".$i."_priority' class='priority' type='text' placeholder='description…' value='$description'>$description</textarea>
            </td>
            
            <td id='".$i."_measure' class='measures measure-td list base disable'><button id='add-$i' onclick='return addMeasure({btn:\"add-$i\", prio:\"$i\", object:$object_list, inter:$inter_list,finance:$finance_list,funding:$funding_list});' class='add-measure $measure_style' id='add-measure'>+ define measures</button>";
                    
            if ((count($res)>0 && strlen($prio['measure'])==0)) {
                echo "<p class='load-measure'>‐‐</p>";
            }
            echo "<ul id='$i-measure-ul' class='ellipse dashed $has_measure'>$measure</ul><input type='text' class='hide' id='$i-measure-text'/></td>
            <td id='".$i."_programme' class='program program-td list disable'><p class='load-measure $null_programme'>&#8208;&#8208;</p><ul id='$i-programme-ul' class='ellipse dashed $has_programme'>$programme</ul><input type='text' class='hide' id='$i-programme-text'/></td>
            <td id='".$i."_object' class='object object-td list extra disable hide'><p class='load-measure $null_object'>&#8208;&#8208;</p><ul id='$i-object-ul' class='ellipse dashed $has_object'>$object</ul><input type='text' class='hide' id='$i-object-text'/></td>
            <td id='".$i."_inter' class='inter inter-td list extra hide disable hide'><p class='load-measure $null_inter'>&#8208;&#8208;</p><ul id='$i-inter-ul' class='ellipse dashed $has_inter'>$inter</ul><input type='text' class='hide' id='$i-inter-text'/></td>
            <td id='".$i."_finance' class='funding funding-td list extra hide disable hide'><p class='load-measure $null_finance'>&#8208;&#8208;</p><ul id='$i-finance-ul' class='ellipse dashed $has_finance'>$finance</ul> <input type='text' class='hide' id='$i-finance-text'/></td>
            <td id='".$i."_funding' class='finance fin-td list extra hide disable hide'><p class='load-measure $null_funding'>&#8208;&#8208;</p><ul id='$i-funding-ul' class='ellipse dashed $has_funding'>$funding</ul> <input type='text' class='hide' id='$i-funding-text'/></td>
            <td id='".$i."_comment' class='comment-td extra hide'><input type='text' class='$has_comment' id='$i-comment' name='$i-comment' value='$comment'/><p class='load-measure $null_comment'>&#8208;&#8208;</p></td>";

            if($years) {
                foreach($years as $cell) {
                    $year = $cell['year'];
                    echo "<td class='new-col ".$year."' id='".$year."'>";
                    $prio_budgets = load_prio_budget($conn,$id,$year);  
                    
                    
                    if(strlen($prio_budgets[0]['year']) > 0) {
                        $planned=$prio_budgets[0]['planned'];
                        $commit=$prio_budgets[0]['commit'];
                        $spent=$prio_budgets[0]['spent'];

                        echo "<table class='budget-val'>
                        <tr><td class='header'>Planned:</td><td><input value='$planned' type='text' class='planned_val' id='".$i."_".$year."_planned' name='".$i."_".$year."_planned' disabled/></td></tr>
                        <tr><td class='header'>Committed:</td><td><input value='$commit' type='text' class='commit_val' id='".$i."_".$year."_commit' name='".$i."_".$year."_commit' disabled/></td></tr>
                        <tr><td class='header'> Spent:</td><td><input value='$spent' type='text' class='spent_val' id='".$i."_".$year."_spent' name='".$i."_".$year."_spent' disabled/></td></tr></table>";
                    }
                    echo "</td>";
                }     
            }
            
            echo "<td class='del-td'><div><a href='#' class='del-row prio-options'>
            ...</a></div> <input name='deleted_$i' id='deleted_$i' class='hide' type='text'/></td>
                
            <td class='table-menu hide'><div><ul><li><a href='#' onclick='return set_comment($i);'>Comment</a></li><li><a href='#' onclick='delRow($i)'>Delete</a></li></ul></div></td>
            
            </tr>";
            ?>
            <script type='text/javascript'>
                
                addParentListener(<?php echo $i; ?>);
            </script>
            
            <?php
            
            $i++;
        }
    }
    
    echo "</tbody>";
    
    echo "</table>";
    
    echo "<input type='text' class='hide prio_rows' name='prio_rows' value='1'/>";
    
    echo "<input id='budget-cols' type='text' class='hide' name='budget_cols' value='0'/>";
    
    echo "</div>";
    
    echo "<button id='new-prio' class='add-item-alt prio' onclick='return addParentRow({table:\"main-table\", object:$object_list, inter:$inter_list,finance:$finance_list,funding:$funding_list});'>"
            . "<i class='fa fa-plus' aria-hidden='true'></i>Add Priority</button><div class='add-row-lb'>Add Priority</div>";
  
    echo "<button class='add-item-alt year hide' onclick='return addCol({table:\"main-table\"});'>"
    . "<i class='fa fa-plus ' aria-hidden='true'></i>Add Year</button>";
    
    echo "</div>";
    
    
}

function load_children($conn,$user_id,$years,$prios,$hide) {
    
    $dd_res = get_dd_res($conn,$user_id);
    
    $object = $dd_res['object_json'];
    $inter = $dd_res['inter_json'];
    $finance = $dd_res['finance_json'];
    $funding = $dd_res['funding_json'];
    $objects = $dd_res['object'];
    $inters = $dd_res['inter'];
    $finances = $dd_res['finance'];
    $fundings = $dd_res['funding'];
    
    echo "<div class='child-div'>";
    
    $row = 1;
    foreach($prios as $prio) {
        $prio_id = $prio['prio_id'];
        $measures = load_prio_measures($conn,$prio_id);
        
        if($measures) {
            $hide = ($row==1) ? '' : 'hide';
            echo "<div class='inner made $hide'>";
            echo "<input class='measure_rows_$row hide' type='text' name='measure_rows_$row' value='$row'/>";

            $id = 'c_'.$row;
            echo "<table class='budget-table child' id='$id'>";

            echo "<thead><tr>";
            echo "<th>Measure</th>";
            echo "<th class='add-budget'></th>";
            echo "<th class=''>Programme<i class='fa fa-info-circle hide' aria-hidden='true'></i></th>";
            echo "<th class='extra'>Objective<i class='fa fa-info-circle hide' aria-hidden='true'></i></th>";
            echo "<th class='extra'>Intervention<i class='fa fa-info-circle hide' aria-hidden='true'></i></th>";
            echo "<th class='extra'>Form of finance<i class='fa fa-info-circle hide' aria-hidden='true'></i></th>";
            echo "<th class='extra'>Funding source<i class='fa fa-info-circle hide' aria-hidden='true'></i></th>";
            if($years) {
                foreach($years as $cell) {
                    $year = $cell['year'];
                    echo "<th class='new-col ".$year."' id='c_".$year."'>".$year."</th>";
                }
            }
            echo "<th class='edit-td'></th>";
            echo "<th class='del-td'></th>";
            echo "</tr></thead>";

            echo "<tbody>";

            $y=1;
            $colspan = 6 + count($years);
            foreach($measures as $measure) {
                $cls = ($row==1)? 'active' : '';
                $description = $measure['measure'];
                
                echo "<tr class='$cls' id='$y'>
                    <td class='measure-td textarea'>
                        <textarea name='".$row."_".$y."_measure' id='".$row."_".$y."_measure' class='measure' type='text' placeholder='measure... ' value='$description'>$description</textarea>
                        <input class='hide' id='budget_rows_".$row."_".$y."' type='text' name='budget_rows_".$row."_".$y."' value=''/>
                    </td>

                    <td class='add-budget-td'>
                        <button class='btn-primary button add-budget' id='add-$y' onclick='return new_budget({budget_id:$y,object:$object,inter:$inter,finance:$finance,funding:$funding});'>Add budget</button>
                        <input type='text' class='hide' id='active-child' value='$y'/>
                    </td>

                    <td class='budget-tr' colspan='$colspan'><table class='budgets'>";
                        $measure_id = $measure['measure_id'];
                        $measure_budgets = get_budget_by_measure($conn,$measure_id);
                        if($measure_budgets) {
                            $z=1;
                            foreach ($measure_budgets as $budget) {
                                $budget_id=$budget['budget_id'];
                                $programme=$budget['programme'];
                                $object_val=$budget['object'];
                                $inter_val=$budget['inter'];
                                $finance_val=$budget['finance'];
                                $funding_val=$budget['funding'];
                                
                                $budget_vals = get_budget_vals($conn,$budget_id);
                                $row_id = $row.'_'.$y.'_'.$z;
                                
                                echo "<tr id='".$row_id."'>";
                                echo "<td class='program-td'><input type='text'  id='".$row_id."_programme' name='".$row_id."_programme' value='$programme' readonly/></td>";
                                echo "<td class='object-td list extra'>
                                    <select id ='".$row_id."_object' class='chosen-select' data-placeholder='-'>";
                                        echo "<option></option>";
                                        for($i=0;$i<count($objects);$i++) {
                                            $object_id=$objects[$i]['id'];
                                            $object_desc=$object_id.'-'.$objects[$i]['description']; 
                                            $selected = ($object_id==$object_val) ? 'selected' : '';
                                            echo "<option value='".$object_id."' $selected>".$object_desc."</option>";
                                        }
                                        echo "</select>";
                                        $object_name = $row_id. '_object';
                                        $object_post = ($_POST[$object_name]) ? ($_POST[$object_name]) : $object_val;
                                        echo "<input type='text' value='$object_post' class='hide' name='$object_name'/></td>";
                                        
                                echo "<td class='inter-td list extra'>
                                    <select id ='".$row_id."_inter' class='chosen-select' data-placeholder='-'>";
                                        echo "<option></option>";
                                        for($i=0;$i<count($inters);$i++) {
                                            $inter_id=$inters[$i]['id'];
                                            $inter_desc=$inter_id.'-'.$inters[$i]['description']; 
                                            $selected = ($inter_id==$inter_val) ? 'selected' : '';
                                            echo "<option value='".$inter_id."' $selected>".$inter_desc."</option>";
                                        }
                                        echo "</select>";
                                        $inter_name = $row_id. '_inter';
                                        $inter_post = ($_POST[$inter_name]) ? $_POST[$inter_name] : $inter_val;
                                        echo "<input type='text' value='$inter_post' class='hide' name='$inter_name'/></td>";
                                
                                echo "<td class='finance-td list extra'>
                                    <select id ='".$row_id."_finance' class='chosen-select' data-placeholder='-'>";
                                        echo "<option></option>";
                                        for($i=0;$i<count($finances);$i++) {
                                            $finance_id=$finances[$i]['id'];
                                            $finance_desc=$finance_id.'-'.$finances[$i]['description']; 
                                            $selected = ($finance_id==$finance_val) ? 'selected' : '';
                                            echo "<option value='".$finance_id."' $selected>".$finance_desc."</option>";
                                        }
                                        echo "</select>";
                                        $finance_name = $row_id. '_finance';
                                        $finance_post = ($_POST[$finance_name]) ? $_POST[$finance_name] : $finance_val;
                                        echo "<input type='text' value='$finance_post' class='hide' name='$finance_name'/></td>";
                                        
                                echo "<td class='funding-td list extra'>
                                    <select id ='".$row_id."_funding' class='chosen-select' data-placeholder='-'>";
                                        echo "<option></option>";
                                        for($i=0;$i<count($fundings);$i++) {
                                            $funding_id=$fundings[$i]['id'];
                                            $funding_desc=$fundings[$i]['description']; 
                                            $selected = ($funding_id==$funding_val) ? 'selected' : '';
                                            echo "<option value='".$funding_id."' $selected>".$funding_desc."</option>";
                                        }
                                        echo "</select>";
                                        $funding_name = $row_id. '_funding';
                                        $funding_post = ($_POST[$funding_name]) ? $_POST[$funding_name] : $funding_val;
                                        echo "<input type='text' value='$funding_post' class='hide' name='$funding_name'/></td>";
                                        
                                if($budget_vals) {
                                    foreach ($budget_vals as $val) {
                                        $year=$val['year'];
                                        $planned=$val['planned'];
                                        $commit=$val['commit'];
                                        $spent=$val['spent'];
                                        $planned_name = $row_id.'_'.$year.'_planned';
                                        $commit_name = $row_id.'_'.$year.'_commit';
                                        $spent_name = $row_id.'_'.$year.'_spent';

                                        echo "<td class='new-col ".$year."'>
                                                <table class='budget-val'>
                                                <tr><td class='header' style='border-bottom: none !important;'>Planned:</td><td style='border-bottom: none !important;'><input type='text' class='".$year."_planned_val' id='".$planned_name."' name='".$planned_name."' placeholder='0.00' value='$planned' readonly/></td></tr>
                                                <tr><td class='header' style='border-bottom: none !important;'>Committed:</td><td style='border-bottom: none !important;'><input type='text' class='".$year."_commit_val' id='".$commit_name."' name='".$commit_name."' placeholder='0.00' value='$commit' readonly/></td></tr>
                                                <tr><td class='header' style='border-bottom: none !important;'> Spent:</td><td style='border-bottom: none !important;'><input type='text' class='".$year."_spent_val' id='".$spent_name."' name='".$spent_name."' placeholder='0.00' value='$spent' readonly/></td></tr></table></td>";
                                    }
                                }
                                        
                                echo "<td class='edit-td'><a href='#' onclick='edit_budget(\"$row_id\")'><i class='fa fa-pencil-square-o edit-btn' aria-hidden='true'></i></a></td>";
                                echo "</tr>";
                                $z++;
                            }
                        }
                        
                    echo "</table></td>

                    <td class='del-td'>
                        <div><a href='#' class='del-row' onclick='delRow($row,$y)' id='child-$i'><i class='fa fa-times' title='remove measure' aria-hidden='true'></i></a></div>
                            <input name='deleted_".$row."_$y' id='deleted_".$row."_$y' class='hide' type='text'/>
                    </td>
                </tr>";
                
                 ?>
                <script type='text/javascript'>
                    addChildListener(<?php echo $row; ?>,<?php echo $y; ?>);
                </script>

                <?php
                
                $y++;
            }

            echo "</tbody>";
            echo "</table>";

            echo "</div>";
        }
        $row++;
    }
    
    echo "<button id='add-child-row' class='add-item-alt $hide' onclick='return addChildRow({object:$object,inter:$inter,finance:$finance,funding:$funding});'><i class='fa fa-plus' aria-hidden='true'></i>Add Measure</button>";
    
    echo "</div>";
}