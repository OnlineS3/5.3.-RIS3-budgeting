<?php

echo "<div class='options'>";

//$user_id=1;

$is_submitted = ((isset($_POST["filter_results"]) == "POST")) ? 1 : 0;
echo "<input id='is_submitted' name='is_submitted' class='hide' value='$is_submitted' />";

$sum_init = ((isset($_POST["sum_init"]) == "POST")) ? 1 : 0;
echo "<input id='sum_init' name='sum_init' class='hide' value='$sum_init' />";

$dd_res = get_dd_res($conn,$user_id);

// filters
$group_cols = array('prio'=>'Priority','object'=>'Objective','inter'=>'Intervention','finance'=>'Form of finance','funding'=>'Funding source');
$show_heads = array('prio'=>'Priority','programme'=>'Programme','object'=>'Objective','inter'=>'Intervention','finance'=>'Form of finance','funding'=>'Funding source');

$prios = $programmes = $objects = $inters = $finances = $funds = "('')";

echo "<div class='sub-section'>";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST["group_col"])) {
    
        $group_post = "";
        foreach ($_POST["group_col"] as $option) {
            $group_post .= $option . ","; 
        }
        $group_post = (strlen($group_post)>0) ? '(' . substr($group_post, 0, strlen($group_post)-1) . ')' : '';
    } else {
        $group_post = $_POST["group_post"];
    }
}
echo "<input type='text' name='group_post' id='group_post' class='hide' value=$group_post>";

// group cols
echo "<i class='fa fa-th-large title-icon' aria-hidden='true' style='margin-right: 8px;'></i>"
    . "<label for='group-col' class='group-title'><span>Group by</span></label>"
    . "<hr class='group-hr'>";

$group_cols = array('prio'=>'Priority','object'=>'Objective','inter'=>'Intervention','finance'=>'Form of finance','funding'=>'Funding source');

echo "<div class='group-area accordion-section'>";

$i=0;
foreach($group_cols as $key=>$text) {
    $id = 'group-'.$i;
    $checked = (!isset($_POST["filter_results"]) && $key=='prio') ? 'checked' : ((contains($group_post, $key)) ? 'checked' : '');
    
    echo "<input type='checkbox' id='$id' class='group-col hide' name='group_col[]' value='$key' $checked/>"
            . "<label for='$id'>$text</label><i class='group-icon fa fa-th-large'></i>";
     
    $i++;
}

echo "</div>";

echo "</div>";

echo "<div class='sub-section'>";
// show cols
$show_cols = array('group_col'=>1,'prio'=>0,'programme'=>0,'object'=>0,'inter'=>0,'finance'=>0,'funding'=>0);
$show_cc = "('')";

if (isset($_POST["filter_results"])) {
    if (isset($_POST["show_col"])) {
        $show_cols = array('group_col'=>1,'prio'=>0,'programme'=>0,'object'=>0,'inter'=>0,'finance'=>0,'funding'=>0);
        
        $show_cc = "";
        foreach ($_POST["show_col"] as $option) {
            $show_cc .= $option . ","; 
            $show_cols["$option"] = 1;
        }
        $show_cc = (strlen($show_cc)>0) ? '(' . substr($show_cc, 0, strlen($show_cc)-1) . ')' : '';
    } else {
        $show_cc = $_POST["show_cc"];
    }
}
echo "<input type='text' class='hide' name='show_cc' id='show_cc' value=$show_cc>";

echo "<input id='show-col' class='toggle-item' type='checkbox'>";
echo "<label for='show-col' class='show-col-lb show-extra'><span>show extra columns<i class='fa fa-angle-double-right'></i></span></label>";
echo "<div class='show-area chk-primary accordion-section'>";


$i=0;
foreach($show_heads as $key=>$text) {
    $id = 'show-'.$i;
    //if (!($_POST["group_col"][0]===$key)) {
        $checked = (contains($show_cc, $key)) ? 'checked' : '';
        echo "<input type='checkbox' id='$id' class='hide show-col' name='show_col[]' value='$key' $checked/>"
            . "<label class='check' for='$id'>$text</label>";

        $i++;
    //}
}
echo "</div>";
echo "</div>";

echo "<div class='sub-section' style='clear: both;'>";
echo "<input id='filters' class='toggle-item' class='hide' type='checkbox' checked><i class='fa fa-filter title-icon' aria-hidden='true' style='margin-right: 8px;'></i>"
    . "<label for='filters' class='group-title'><span>Add Filters</span></label>"
    . "<hr class='group-hr'><div class='filter-area'>";

echo "<div class='filter-item'>";
echo "<p>Priority:</p>";

if (isset($_POST["filter_results"])) {
    $prios = "";
    if ($_POST["choose_prio"]) {
        foreach ($_POST["choose_prio"] as $option) {
            $prios .= $option . ","; 
        }
        $prios = (strlen($prios)>0) ? '(' . substr($prios, 0, strlen($prios)-1) . ')' : '';
    }
} else {
    $prios = normalize_input($_POST["prios"]);
}

echo "<input class='hide' type='text' name='prios' id='prios' value=$prios>";

$prios = ($prios=="") ? normalize_input("('')") : $prios;
    
echo "<select class='multi-filters' name='choose_prio[]' id='choose-prio' multiple>";
   $res = $dd_res['prio'];
   
   for($x = 0; $x < count($res); $x++) {
       $id = $res[$x]['id'];
       $desc = $res[$x]['description'];
       $selected = ($is_submitted==1) ? ((contains($prios, $id)) ? 'selected' : '') : 'selected';
       echo "<option value='$id' $selected>$desc</option>";
   }
echo "</select>";

echo "</div>";

$programmes = get_post_val('choose_programme','programmes');
echo "<input class='hide' type='text' name='programmes' id='programmes' value=$programmes>";

$programmes = ($programmes=="") ? normalize_input("('')") : $programmes;

echo "<div class='filter-item'>";
echo "<p>Programme:</p>";
echo "<select class='multi-filters' name='choose_programme[]' id='choose-programme' multiple>";
   $res = $dd_res['programme'];
   for($x = 0; $x < count($res); $x++) {
       $desc = $res[$x]['programme'];
       $selected = ($is_submitted==1) ? ((contains($programmes, $desc)) ? 'selected' : '') : 'selected';
       echo "<option value='$desc' $selected>$desc</option>";
   }
echo "</select>";
echo "</div>";

$objects = get_post_val('choose_object','objects');
$objects = ($objects=="") ? normalize_input("('')") : $objects;

echo "<input class='hide' type='text' name='objects' id='objects' value=$objects>";

echo "<div class='filter-item'>";
echo "<p>Thematic objective:</p>";
echo "<select class='multi-filters' name='choose_object[]' id='choose-object' multiple>";
   $res = $dd_res['object'];
   for($x = 0; $x < count($res); $x++) {
       $id = $res[$x]['id'];
       $desc = $id . ' - ' . utf8_encode($res[$x]['description']);
       $selected = ($is_submitted==1) ? ((contains($objects, $id)) ? 'selected' : '') : 'selected';
       echo "<option value='$id' $selected>$desc</option>";
   }
echo "</select>";
echo "</div>";

$inters = get_post_val('choose_inter','inter');
echo "<input class='hide' type='text' name='inter' id='inters' value=$inters>";
$inters = ($inters=="") ? normalize_input("('')") : $inters;

echo "<div class='filter-item'>";
echo "<p>Intervention code:</p>";
echo "<select class='multi-filters' name='choose_inter[]' id='choose-inter' multiple>";
   $res = $dd_res['inter'];
   
   for($x = 0; $x < count($res); $x++) {
       $id = $res[$x]['id'];
       $desc = $id  . ' - ' . utf8_encode($res[$x]['description']);
       $selected = ($is_submitted==1) ? ((contains($inters, $id)) ? 'selected' : '') : 'selected';
       
       echo "<option value='$id' $selected>$desc</option>";
   }
echo "</select>";
echo "</div>";

$finances = get_post_val('choose_finance','finance');
echo "<input class='hide' type='text' name='finance' id='finances' value=$finances>";
$finances = ($finances=="") ? normalize_input("('')") : $finances;

echo "<div class='filter-item'>";
echo "<p>Form of finance:</p>";

echo "<select class='multi-filters' id='choose-finance' name='choose_finance[]' multiple>";
   $res = $dd_res['finance'];
   
   for($x = 0; $x < count($res); $x++) {
       $id = $res[$x]['id'];
       $desc = $id . ' - ' . $res[$x]['description'];
       $selected = ($is_submitted==1) ? ((contains($finances, $id)) ? 'selected' : '') : 'selected';
       echo "<option value='$id' $selected>$desc</option>";
   }
echo "</select>";
echo "</div>";

if (isset($_POST["filter_results"])) {
    if($_POST["choose_funding"]) {
        $funds = ",";
        foreach ($_POST["choose_funding"] as $option) {
            $funds .= $option . ","; 
        }
        $funds = (strlen($funds)>0) ? '(' . $funds . ')' : '';
    }
} else {
    $funds = $_POST["funding"];
}
    
echo "<input class='hide' type='text' name='funding' id='fundings' value=$funds>";

echo "<div class='filter-item'>";
echo "<p>Funding source:</p>";
echo "<select class='multi-filters' id='choose-funding' name='choose_funding[]' multiple>";
   $res = $dd_res['funding'];
   
   for($x = 0; $x < count($res); $x++) {
       $id = $res[$x]['id'];
       $desc = utf8_encode($res[$x]['description']);
       $selected = ($is_submitted==1) ? ((contains($funds, ','.$id.',')) ? 'selected' : '') : 'selected';
       echo "<option value='$id' $selected>$desc</option>";
   }
echo "</select>";
echo "</div>";

$funds = substr($funds, 0, 1) . substr($funds, 2, strlen($funds)-4) . substr($funds, strlen($funds)-1);

$funds = ($funds=="()") ? normalize_input("('')") : $funds;

//echo $funds;

$years = get_post_val('choose_year','filter_years');
echo "<input class='hide' type='text' name='filter_years' id='filter-years' value=$years>";
$years = ($years=="") ? normalize_input("('')") : $years;

echo "<div class='filter-item'>";
echo "<p>Year:</p>";
echo "<select class='multi-filters' id='choose-year' name='choose_year[]' multiple>";
   $res = $dd_res['year'];
   
   for($x = 0; $x < count($res); $x++) {
       $desc = utf8_encode($res[$x]['year']);
       $selected = ($is_submitted==1) ? ((contains($years, $desc)) ? 'selected' : '') : 'selected';
       echo "<option value='$desc' $selected>$desc</option>";
   }
echo "</select>";
echo "</div>";
echo "</div>";
echo "</div>";
echo "</div>";

function get_post_val($select_name,$input_name) {
    if (isset($_POST["filter_results"])) {
        if ($_POST["$select_name"]) {
            $post_val = "";
            foreach ($_POST["$select_name"] as $option) {
                $post_val .= "'". normalize_input($option) . "'" . ","; 
            }
            $post_val = (strlen($post_val)>0) ? '(' . substr($post_val, 0, strlen($post_val)-1) . ')' : '';
        }
    } else {
        $post_val = normalize_input($_POST["$input_name"]);
    }
    
    return $post_val;
}

