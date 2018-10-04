<?php

function create_region($conn,$regions) {
    
    $nuts_labels = get_nuts_labels($conn);
    $nuts_0 = $nuts_labels['nuts_0'];
    $nuts_1 = $nuts_labels['nuts_1'];
    $nuts_2 = $nuts_labels['nuts_2'];
    $nuts_0_json = $nuts_labels['nuts_0_json'];
    $nuts_1_json = $nuts_labels['nuts_1_json'];
    $nuts_2_json = $nuts_labels['nuts_2_json'];
    
    //echo '<br>nuts level: ' . $_POST['nuts_level'];
    
//    $nuts_level = ($_POST['nuts_level']) ? $_POST['nuts_level'] : 0;
//    
//    $nuts_0_checked = $nuts_1_checked = $nuts_2_checked = '';
//    switch($nuts_level) {
//        case 0:
//            $case = 0;
//            $regions = $nuts_0;
//            $nuts_0_checked = 'checked';
//            break;
//        case 1:
//            $case = 1;
//            $regions = $nuts_1;
//            $nuts_1_checked = 'checked';
//            break;
//        case 2:
//            $case = 2;
//            $regions = $nuts_2;
//            $nuts_2_checked = 'checked';
//            break;
//        default:
//            $case = -1;
//    }
    
    $nuts_level = 0;
    $regions = $nuts_0;
    $nuts_0_checked = 'checked';
    
    echo "<p class='tip hide' style='display:inline-block; margin-right: -6px;'>Choose Nuts level:</p>";

    //print_r($nuts_0_json);
    
    //print_r($nuts_1_json);
    
    //print_r($nuts_2_json);
    
    echo "<div class='radio-primary check-import'>
    <div><input id='nuts-0' value='0' class='nuts_level' name='nuts_level' type='radio' onchange='return fillRegions($nuts_0_json);' $nuts_0_checked><label for='nuts-0'>NUTS 0</label></div>
    <div><input id='nuts-1' value='1' class='nuts_level' name='nuts_level' type='radio' onchange='return fillRegions($nuts_1_json);' $nuts_1_checked><label for='nuts-1'>NUTS 1</label></div>
    <div><input id='nuts-2' value='2' class='nuts_level' name='nuts_level' type='radio' onchange='return fillRegions($nuts_2_json);' $nuts_2_checked><label for='nuts-2'>NUTS 2</label></div>
    </div>";
    
    if (isset($_POST['select_region'])) {
        foreach ($_POST['select_region'] as $option) {
            $post_region = $option; 
        }
    } else {
        $post_region = $_POST['region'];
    }
    
    echo "<select id='choose-region' name='select_region[]' class='choose-region chosen-select' data-placeholder='region ..' style='display:inline-block'>";
    echo "<option value=''></option>";
    foreach ($regions as $region) {
        $region_id = $region['code'];
        $region_lb = $region['label'];
        echo "<option value='$region_id' $selected>$region_id - $region_lb</option>";
    }
    echo "</select>";
    echo "<input id='region' class='hide' name='region' type='text' value='$post_region' />";
}

function create_years($conn,$years) {

    echo "<select id='choose-years' class='choose-years chosen-select' data-placeholder='year ..' >";
    echo "<option value=''></option>";
    foreach ($years as $year) {
        echo "<option>$year</option>";
    }
    echo "</select>";

    $years = $_POST['years'];

    echo "<input class='hide' id='years' name='years' type='text' value='$years' />";

    echo "<span class='show-years'>Selected years:</span>";

    echo "<table id='selected-years' cellspacing='7'><tr></tr></table>";
}

function create_parent($conn,$user_id) {
    
    $headers_ini = array('RIS3 priority','Funding source','Intervention field','Form of finance');
    $row_no = 1;
    //$user_id = 1;
    
    $dd_res = get_dd_res($conn,$user_id);
    
    $object = $dd_res['object_json'];
    $inter = $dd_res['inter_json'];
    $finance = $dd_res['finance_json'];
    $funding = $dd_res['funding_json'];
    
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
    echo "<th class='btn-td'></th>";
    
    echo "</tr></thead>";
    
    echo "<tbody>";
    for($i=1;$i<=$row_no;$i++) {
        $cls = ($i==1)? 'active' : '$i';
        $type = ($i%2==0) ? 'even' : 'odd';
        
        echo "<tr class='$cls $type' id='1'>
            
        <td class='priority-td textarea base headcol' id='1_priority'>
            <textarea name='1_priority' class='priority' type='text' placeholder='description…'></textarea>
        </td>

        <td id='1_measure' class='measures measure-td list base disable'>
        <button  id='add-$i' onclick='return addMeasure({btn:\"add-$i\", prio:\"$i\", object:$object, inter:$inter,finance:$finance,funding:$funding});' class='add-measure' id='add-measure'>+ define measures</button>
         <ul id='1-measure-ul' class='ellipse dashed hide'></ul><input type='text' class='hide' id='1-measure-text'/></td>
        <td id='1_programme' class='program program-td list disable'><p class='load-measure'>&#8208;&#8208;</p><ul id='1-programme-ul' class='ellipse dashed hide'></ul><input name='1_1_p' type='text' class='hide' id='0-programme-text'/></td>
        <td id='1_object' class='object object-td list extra disable hide'><p class='load-measure'>&#8208;&#8208;</p><ul id='1-object-ul' class='ellipse dashed hide'></ul><input name='1_1_p' type='text' class='hide' id='0-object-text'/></td>
        <td id='1_inter' class='funding fund-td list extra disable hide'><p class='load-measure'>&#8208;&#8208;</p><ul id='1-inter-ul' class='ellipse dashed hide'></ul><input name='1_1_p' type='text' class='hide' id='0-inter-text'/></td>
        <td id='1_finance' class='inter inter-td list extra disable hide'><p class='load-measure'>&#8208;&#8208;</p><ul id='1-finance-ul' class='ellipse dashed hide'></ul> <input name='1_2_p' type='text' class='hide' id='0-finance-text'/></td>
        <td id='1_funding' class='finance fin-td list extra disable hide'><p class='load-measure'>&#8208;&#8208;</p><ul id='-funding-ul' class='ellipse dashed hide'></ul> <input name='1_3_p' type='text' class='hide' id='0-funding-text'/></td>
        <td id='1_comment' class='comment-td extra hide'><input type='text' class='hide' id='1-comment' name='1_comment'/><p class='load-measure'>&#8208;&#8208;</p></td>
        
        <td class='del-td'><div><a href='#' class='prio-options' class='del-row'>
        ...</a></div><input name='deleted_1' id='deleted_1' class='hide' type='text'/></td>
        
        <td class='table-menu hide'><div><ul><li><a href='#' onclick='return set_comment(1);'>Comment</a></li><li><a href='#' onclick='delRow(1)' title='remove priority'>Delete</a></li></ul></div></td>
        </tr>";
    }
    
    echo "</tbody>";
    
    echo "</table>";
    
    echo "<input type='text' class='hide prio_rows' name='prio_rows' value='1'/>";
    
    echo "<input id='budget-cols' type='text' class='hide' name='budget_cols' value='0'/>";
    
    echo "</div>";
    
    echo "<button id='new-prio' class='add-item-alt prio' onclick='return addParentRow({table:\"main-table\", object:$object, inter:$inter,finance:$finance,funding:$funding});'>"
            . "<i class='fa fa-plus' aria-hidden='true'></i>Add Priority</button><div class='add-row-lb'>Add Priority</div>";
  
    echo "<button class='add-item-alt year hide' onclick='return addCol({table:\"main-table\"});'>"
    . "<i class='fa fa-plus ' aria-hidden='true'></i>Add Year</button>";
    
    echo "</div>";
}

function create_child($conn,$hide,$user_id) {
    
    $headers_ini = array('Measure','Funding source','Intervention field','Form of finance');
    $row_no = 1;
    //$user_id = 1;
	
    $dd_res = get_dd_res($conn,$user_id);
    
    $object = $dd_res['object_json'];
    $inter = $dd_res['inter_json'];
    $finance = $dd_res['finance_json'];
    $funding = $dd_res['funding_json'];
    
    echo "<div class='child-div'>";
    
    echo "<button id='add-child-row' class='add-item-alt $hide' onclick='return addChildRow({object:$object,inter:$inter,finance:$finance,funding:$funding});'><i class='fa fa-plus' aria-hidden='true'></i>Add Measure</button>";
    
    echo "</div>";
}

