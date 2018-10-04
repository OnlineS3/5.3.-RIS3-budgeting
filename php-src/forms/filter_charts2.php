<?php

$is_chart_submitted = ((isset($_POST["show-bar"]) == "POST")) ? 1 : 0;
echo "<input id='chart_submitted' name='chart_submitted' class='hide' value='$is_chart_submitted' />";

echo "<div class='chart options'>";

echo "<div class='sub-section'>";

echo "<input id='group-col' class='toggle-item' type='checkbox' checked><i class='fa  fa-filter title-icon' aria-hidden='true' style='margin-right: 8px;'></i>"
    . "<label for='group-col' class='group-title'><span>Filter regions</span></label>"
    . "<hr class='group-hr'>";

// get post data
if (isset($_POST['chart_regions'])) {
    foreach ($_POST['chart_regions'] as $option) {
        $chart_regions .= "'". $option . "'" . ","; 
    }
    $chart_regions = substr($chart_regions, 1, strlen($chart_regions)-3);
    
} else {
    $chart_regions = $_POST['post_regions'];
}

echo "<input type='text' name='post_regions' class='hide' value=$chart_regions>";

echo "<select class='multi-filters' id='chart-region' name='chart_regions[]' multiple>";

if($regions) {
    foreach($regions as $region) {
        $region_id = $region['region_id'];
        $region_lb = $region_id . '-'. $region['region_lb'];
        $selected = ($is_chart_submitted==1) ? ((contains($chart_regions, $region_id)) ? 'selected' : '') : 'selected';
        if($selected=='selected') {
            array_push($graph_regions,$region_id);
        }
        
        echo "<option value='$region_id' $selected>$region_lb</option>";
    }
}
echo "</select>";
echo "</div>";

$years = $published_vals['years'];

// get post data
if (isset($_POST['chart_years'])) {
    foreach ($_POST['chart_years'] as $option) {
        $chart_years .= "'". $option . "'" . ","; 
        array_push($graph_years,$option);
    }
    $chart_years = substr($chart_years, 1, strlen($chart_years)-3);

} else {
    $chart_years = $_POST['post_years'];
}
echo "<input type='text' name='post_years' class='hide' value=$chart_years>";

echo "<div class='sub-section'>";

echo "<input id='group-col' class='toggle-item' type='checkbox' checked><i class='fa fa-filter title-icon' aria-hidden='true' style='margin-right: 8px;'></i>"
    . "<label for='group-col' class='group-title'><span>Filter years</span></label>"
    . "<hr class='group-hr'>";


    echo "<select class='multi-filters' id='chart-year' name='chart_years[]'>";
    if($years) {
        foreach($years as $year) {
            $val = $year['year'];
            $selected = ($is_chart_submitted==1) ? ((contains($chart_years, $val)) ? 'selected' : '') : 'selected';
            echo "<option value='$val' $selected>$val</option>";
        }
    }
    echo "</select>";
echo "</div>";

echo "<div class='sub-section'>";

echo "<input id='group-col' class='toggle-item' type='checkbox' checked><i class='fa fa-th-large title-icon' aria-hidden='true' style='margin-right: 8px;'></i>"
    . "<label for='group-col' class='group-title'><span>Budget Type</span></label>"
    . "<hr class='group-hr'>";

$group_cols = array('planned'=>'Planned','commit'=>'Committed','spent'=>'Spent');

echo "<div class='group-area accordion-section'>";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST["budget_type"])) {
        $budget_type = $_POST["budget_type"][0];
    } else {
        $budget_type = $_POST["budget_type_ps"];
    }
}

echo "<input type='text' name='budget_type_ps' id='budget_type_ps' class='hide' value=$budget_type>";

$i=0;
foreach($group_cols as $key=>$text) {
    $checked = (!isset($_POST["budget_type"]) && $key=='planned') ? 'checked' : (($budget_type==$key) ? 'checked' : '');

    echo "<input type='checkbox' id='$key' class='group-col hide' name='budget_type[]' value='$key' $checked/>"
            . "<label for='$key'>$text</label>";

    $i++;
}

echo "</div>";

echo "</div>";

echo "</div>";

