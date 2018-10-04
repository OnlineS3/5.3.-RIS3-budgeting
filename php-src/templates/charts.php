<?php

echo "<div class='step-3 content hide'>";

$graph_regions = $graph_years = $bar_data = array();
$budget_type = '';

$published_vals = get_published_values($conn,$user_id);

$regions = $published_vals['regions'];

if (count($regions) == 0) {
    echo '<p class="no-data">No published data available.</p>';
} else {
    echo "<form action='$home' id='charts' method='post'>";

    include 'php-src/forms/filter_charts.php';

    if (isset($_POST['show-bar'])) {
        $chart_data = $published_vals['chart_data'];
        
        if ($chart_data) {

            foreach ($chart_data as $row_data) {
                if ($row_data['year'] == $graph_year  && in_array ($row_data['region'],$graph_regions)) {
                    unset($row_data['year']);
                    array_push($bar_data,$row_data);
                }
            }

            $bar_data = json_encode($bar_data);
            $legends = json_encode($graph_regions);
            $states = json_encode(array('planned','commit','spent'));
            $bar_label = json_encode('Budgets by Region (Year ' . $graph_year . ')');
            $image_name = json_encode('Budgets by Region - ' . $graph_year);
            
            ?>
            <script type="text/javascript">
                showAjaxStackedBar({ container: "graph", data: <?php echo $bar_data ?>, vars: <?php echo $legends ?>, states: <?php echo $states ?>, title: <?php echo $bar_label  ?>, sub_title: "", width:"900" });
            </script>

            <?php

            }
        }

        echo "<div class='filter-btns chart'>"
            . "<button class='button btn-primary' id='filter_charts' name='show-bar'>Apply <i class='fa fa-search' id='search-icon'></i></button>" 
            . "</div>";

        echo "<div class='chart-container'>";

        include 'php-src/forms/chart_container.php';

        echo "</div>";
        
        echo "<div class='filter-btns chart' style='margin-bottom: 0; right:0; position: absolute;'>";
        echo "<div class='tooltip-container'>"
            . "<button class='button btn-primary hide ie-disabled' id='reset_chart'" 
            . "onclick='return exportSvg2PNG({ container: \"export-svg\", filename: $image_name });'>Download Image<i class='fa fa fa-file-image-o' id='export-icon'></i></button>" ;
            
        echo "<span class='tooltiptext arrow-right far tip-body ie-message hide' style='left: auto !important;width: 363px !important; top: -11px;'>
            Sorry, downloading graphs is not supported by Internet Explorer.
            It is recommended to use a different browser for this functionality.</span>";
        echo "</div></div>";
        echo "</div>";
    }

echo "<div class='step-3 btn-section hide'>
        <div style='float:left; font-size:14px; font-family:tahoma; color:grey;'>
        <button class='btn btn-default btn-circle' onclick='return setStep(\"step-2\",\"step-3\",\"proceed\");' style='margin-right: 6px;'>
        <i class='fa fa-arrow-left'></i></button>Data Analysis</div>";
echo "</form>";
echo "</div>";

