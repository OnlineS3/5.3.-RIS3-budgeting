<?php

include 'php-src/forms/load_tables.php';

$years = array('2013','2014','2015','2016','2017','2018','2019','2020');

//$user_id = 1;

$tips[0] = "In this section, you have to select the region that RIS financial plan refers to. Initially you have to select the NUTS level (0/1/2) which you want to use for your selection (e.g. NUTS 0 refers to country level).";

$tips[1] = "Choose the years for which you want to elaborate the RIS3 financial "
        . "plan. All the selected years will appear in the budgeting tables below."
        . "<br>Note: Select the years in chronological order, so that the budgeting tables are properly presented.";

$tips[2] = "For each priority you create enter a short description and "
        . "click the 'define measures' option. Then, a nested table built up by measures will be generated in the 'Measure per Priority' section, where you can enter the financial data regarding this priority."
        . "<br>You can also add qualitative data by clicking the more '...' button and selecting 'comment'."
        . "<br>Note: The columns regarding the budget information and the main categories in this table are not editable. They will be updated by the data inserted in the nested table generated.";

$tips[3] = "In this step, you can describe the measures under each priority and add budget data. "
        . "<br>Enter a short description for each measure and click 'add budget' "
        . "button to insert financial data and information regarding the five categories provided."
        . "<br>Note: One measure can have more than one entry for budget, as it might receive funding from different operational programmes, funding sources etc.";

echo "<form action='$home' id='budget-table' method='post'>";

if($user_id>0) {
    $res = exec_select($conn, "SELECT 1 FROM priority WHERE user_id=$user_id");
    $budget_exists = (count($res)>0) ? true : false;
} else {
    $budget_exists = false;
}

if($budget_exists) {
    $budget_values = get_budget_values($conn,$user_id);
}

echo "<div class='step-1 content'>";

echo "<div class='section fill-region' style='margin-top: 8px;'>";

echo "<div class='title-1' style='margin-top: 0;margin-bottom: 9px;'>"
    . "<p style='padding-top:0'>1. Definition of the region ";
echo "<div class='tooltip-container'>
        <i class='fa fa-info-circle' aria-hidden='true'></i>
        <span class='tooltiptext arrow-left near tip-body'>$tips[0]</span></div>";
echo "</div>";

//echo "<p class='tip' style='display:inline-block'>Choose the region that RIS financial plan refers to:</p>";

$regions = exec_select($conn, "SELECT * FROM region WHERE code <> '' ORDER BY code");

if($budget_exists && !isset($_POST['clear-data'])) {
    load_region($conn,$regions,$budget_values['region']['region_id']);
} else {
    create_region($conn,$regions);
}

echo "</div>";

echo "<div class='section fill-years' style='margin-top: 48px;'>";

echo "<div class='title-1' style='margin-top: 0;margin-bottom: 9px;'>"
    . "<p style='padding-top:0'>2. Years for budgeting ";
echo "<div class='tooltip-container'>
        <i class='fa fa-info-circle' aria-hidden='true'></i>
        <span class='tooltiptext arrow-left near tip-body'>$tips[1]</span></div>";
echo "</div>";

echo "<p class='tip'>Choose the years to elaborate the RIS3 financial plan:</p>";


if($budget_exists && !isset($_POST['clear-data'])) {
    load_years($years,$budget_values['years']);
} else {
    create_years($conn,$years);
}

echo "</div>";

echo "<div class='section fill-prios'>";

echo "<div class='title-1'><p>3. Definition of priorities";
echo "<div class='tooltip-container'>
        <i class='fa fa-info-circle' aria-hidden='true'></i>
        <span class='tooltiptext arrow-left near tip-body'>$tips[2]</span></div>";
echo "</div>";

$checked = isset($_POST['show_prio_cols']) ? 'checked' : '';

echo "<p class='tip'>Define the priorities of your RIS3 strategy:</p>";
echo "<input id='show-prio-cols' name='show_prio_cols' class='hide' type='checkbox' $checked/><label for='show-prio-cols' class='show-columns hide' style='color: #007ce2;'>Show extra columns <i class='fa fa-columns'></i></label>";

if($budget_exists && !isset($_POST['clear-data'])) {
    load_parent($conn,$user_id,$budget_values['years'],$budget_values['prios']);
} else {
    create_parent($conn,$user_id);
}

echo "</div>";

$hide = 'hide';

if($budget_exists && !isset($_POST['clear-data'])) {
    $res = exec_select($conn, "SELECT 1 FROM measure JOIN priority ON measure.prio_id = priority.id and priority.user_id = $user_id");
    $measure_exists = (count($res)>0) ? true : false;
    $prio_one = $budget_values['prios'][0]['prio_id'];
    $res = exec_select($conn, "SELECT 1 FROM measure JOIN priority ON measure.prio_id = $prio_one");
    $hide = (count($res)>0) ? '' : 'hide';
}

echo "<div class='section fill-measures'>";

echo "<div class='title-1'><p style='padding-top: 3px;'>4. Measures per Priority <span id='prio-title'></span></p>";
echo "<div class='tooltip-container'>
        <i class='fa fa-info-circle' aria-hidden='true'></i>
        <span class='tooltiptext arrow-left near tip-body'>$tips[3]</span></div>";
echo "</div>";

$checked = (isset($_POST['save-data']) || isset($_POST['publish-data'])) ? (isset($_POST['show_measure_cols']) ? 'checked' : '') : '';

echo "<p class='tip $hide' style='display: inline-block;'>Describe the measures under this priority and add budget information:</p>";
echo "<input id='show-measure-cols' name='show_measure_cols[]' class='hide' type='checkbox' $checked/><label class='show-columns hide' for='show-measure-cols' style='color: #8cba54;'>Hide extra columns</button>"
. "<i class='fa fa-columns' style='left: 6px;position: relative;'></i></label>";

if($budget_exists && !isset($_POST['clear-data'])) {
    load_children($conn,$user_id,$budget_values['years'],$budget_values['prios'],$hide);
} else {
    create_child($conn,$hide,$user_id);
}

echo "</div>";

echo "</div>";

//include 'budget_menu.php';

echo "<div class='step-1 budget-menu tools'>
    <div class='cat-caption'><p>Menu</p></div>";
    
if (is_user_logged_in()) {
    echo "<button id='save-data' name='save-data'>save<i class='fa fa-floppy-o' aria-hidden='true'></i></button>";
} else {
    echo "<div class='tooltip-container'>";
    echo "<button id='save-data' name='save-data' disabled>save<i class='fa fa-floppy-o' aria-hidden='true'></i></button>";
    echo "<span class='tooltiptext arrow-left far tip-body'>You have to sign in to save the financial plan.</span>";
    echo "</div>";
}
   
echo "<button id='clear-data' name='clear-data'>clear<i class='fa fa-eraser' aria-hidden='true'></i></button>
<button onclick='return exportMainXLS(\"budgets.xlsx\");'>download<i class='fa fa-download' aria-hidden='true'></i></button>";
        
if (is_user_logged_in()) {
    echo "<button name='publish-data' id='publish-data' style='margin-top: -3px;border-bottom: none'>publish <img src='images/publish.png' width='18'></button>";
} else {
    echo "<div class='tooltip-container'>";
    echo "<button name='publish-data' id='publish-data' style='margin-top: -3px;border-bottom: none' disabled>publish <img src='images/publish.png' width='18' ></button>";
    echo "<span class='tooltiptext arrow-left far tip-body'>You have to sign in to publish the financial plan.</span>";
    echo "</div>";
}  

echo "</div>";

echo "<div class='step-1 budget-menu show-all chk-primary'>
    <input type='checkbox' name='show_all' id='show_budget' value='show_budget' checked>
    <label class='check' for='show_budget'>Show only budget</label>  
    <input type='checkbox' name='show_overview' id='show_overview' value='show_overview'>
    <label class='check' for='show_overview'>Show additional info</label>    
</div>";


echo "<div class='step-1 budget-menu export-monitoring'>
    <p><span>CONNECT</span> with Monitoring Tool
    <div class='tooltip-container'>
    <i class='fa fa-info-circle' aria-hidden='true' style=''></i>
    <span class='tooltiptext arrow-left far tip-body'>mpla mpla mpla</span>
    </div>
    </p>
    <button class='button' onclick='return generateMonitoringFile(\"monitoring_data\");'>
    Export Data
    <img src='images/export_icon.png' width='13'>
    </button>
</div>";

echo "<div class='step-1 btn-section'>
        <div style='float: right;font-size: 14px;font-family: tahoma;color: grey;'>
        Data Analysis";
if (is_user_logged_in()) {
    echo "<button class='btn btn-default btn-circle' type='submit' name='data-analysis' id='data-analysis' disabled>
        <i class='fa fa-arrow-right'></i></button>";
} else {
    echo "<div class='tooltip-container'>";
    echo "<button class='btn btn-default btn-circle' name='data-analysis' id='data-analysis' disabled>
        <i class='fa fa-arrow-right'></i></button>";
    echo "<span class='tooltiptext arrow-left tip-body'>You have to sign in to proceed to the analysis step.</span>";
    echo "</div>";
}  
echo "</div></div>";
        
$current_prio = ($_POST['current_prio']) ? $_POST['current_prio'] : 1;
$analysis_active = ($_POST['analysis_active']) ? $_POST['analysis_active'] : 0;
$form_cleared = (isset($_POST['save-data'])) ? 0 : (($_POST['form_cleared']) ? $_POST['form_cleared'] : 0);

echo "<input type='text' id='active-parent' class='hide' name='current_prio' value='$current_prio'/>";
echo "<input type='text' id='del-years' class='hide' name='del_years'/>";
echo "<input type='text' id='analysis-active' class='hide'  name='analysis_active' value='$analysis_active'/>";
echo "<input type='text' id='form-cleared' class='hide'  name='form_cleared' value='$form_cleared'/>";

echo "</form>";

include 'php-src/forms/budget_form.php';

include 'php-src/forms/comment.php';


