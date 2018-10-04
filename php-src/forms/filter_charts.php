<?php

$is_chart_submitted = ((isset($_POST["show-bar"]) == "POST")) ? 1 : 0;
echo "<input id='chart_submitted' name='chart_submitted' class='hide' value='$is_chart_submitted' />";

echo "<div class='chart options'>";

echo "<div class='sub-section'>";

echo "<input id='group-col' class='toggle-item' type='checkbox' checked><i class='fa  fa-filter title-icon' aria-hidden='true' style='margin-right: 8px;'></i>"
    . "<label for='group-col' class='group-title'><span>Filter regions</span></label>"
    . "<hr class='group-hr'>";

// get post data
$chart_regions = '';
if (isset($_POST['show-bar'])) {
    if (isset($_POST['chart_regions'])) {
        foreach ($_POST['chart_regions'] as $option) {
            $chart_regions .= "'". $option . "'" . ","; 
        }
        $chart_regions = substr($chart_regions, 1, strlen($chart_regions)-3);
    }
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

echo "<div class='sub-section'>";

echo "<input id='group-col' class='toggle-item' type='checkbox' checked><i class='fa fa-th-large title-icon' aria-hidden='true' style='margin-right: 8px;'></i>"
    . "<label for='group-col' class='group-title'><span>Choose year</span></label>"
    . "<hr class='group-hr'>";

//$years = $published_vals['years'];

$years = array('2013','2014','2015','2016','2017','2018','2019','2020');


// get post data
if (isset($_POST['chart_years'])) {
    foreach ($_POST['chart_years'] as $option) {
        $graph_year = $option; 
        break;
    }

} else {
    $graph_year = $_POST['post_years'];
}
echo "<input type='text' name='post_years' class='hide' value=$graph_year>";

echo "<div class='group-area accordion-section'>";

echo "<input type='text' name='budget_type_ps' id='budget_type_ps' class='hide' value=$budget_type>";

$i=0;
foreach($years as $year) {
    $val = $year;
    $checked = (!isset($_POST["post_years"]) && $i==0) ? 'checked' : (($graph_year==$val) ? 'checked' : '');
    $id = 'chart_' . $val;
    echo "<input type='checkbox' id='$id' class='hide chart-year' name='chart_years[]' value='$val' $checked/>"
            . "<label for='$id'>$val</label>";

    $i++;
}

echo "</div>";

echo "</div>";

echo "</div>";

