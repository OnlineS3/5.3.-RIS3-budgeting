<?php

//echo "<input type='text' id='chart_type' value='' name='chart_type' class='hide'/>";

// secret image for export
echo "<input type='text' id='wd_chart' name='wd_chart' class='hide'/>";
 
$legends_lb = ($group_type=='var') ? 'variables' : 'regions';
if (count($legends) > 30) {
    echo "<p class='graph-up'>* Only 30 $legends_lb can be displayed in the graph</p>";
}

echo "<div id='graph'></div>";

echo "<div class='new-btns hide'>";
echo "<div class='tooltip-container'>";
echo "<button class='button btn-secondary-alt ie-disabled' onclick='return exportSvg2PNG"
    . "({ container: \"export-svg\", filename: \"online_graph.png\" });'>Export as Image"
    . "&nbsp; <i class='fa fa-file-image-o' aria-hidden='true'></i></button>";
echo "</button>";
echo "<span class='tooltiptext arrow-right far tip-body ie-message hide' style='left: auto !important;width: 363px !important; top: -11px;'>
        Sorry, downloading graphs is not supported by Internet Explorer.
        It is recommended to use a different browser for this functionality.</span>";
echo "</div>";
echo "<input class='button btn-primary-alt insert-btn' name='insert-chart' type='submit' value='Insert to Report'/>"
        . "<i class='fa fa-file-pdf-o insert-icon' aria-hidden='true'></i>";

echo "</div>";

