<?php

echo "<div class='step-2 content hide'>";

echo "<form action='$home' id='budget-results' method='post'>";

include "php-src/forms/filter_form.php";

echo "<div class='filter-btns'>"
        . "<button class='button btn-primary ' id='reset-btn' name='filter_results'" 
        . "onclick='return clearFilters();'>Reset <img class='reset-icon' src='images/reset.png' width='14'></button>" 
        . "<button class='button btn-primary' id='filter_results' name='filter_results'>Apply <i class='fa fa-search' id='search-icon'></i></button>" 
        . "</div>";

include "php-src/forms/sum_form.php";

include "php-src/forms/word_form.php";

//include 'budget_menu.php';

$disabled = (isset($_POST['filter_results'])) ? '' : 'disabled';

//echo "<div class='step-2 budget-menu tools hide'>
//<button id='export-xls' onclick='return exportSummaryXLS(\"summary.xlsx\");' $disabled>download results in xls<i class='fa fa-file-excel-o' aria-hidden='true'></i></button>
//<button id='export-word' onclick='$(\"#word-div\").wordExport();return false;' $disabled>download results in word<i class='fa fa-file-word-o' aria-hidden='true'></i></button> 
//<div class='tooltip-container'>
//<button disabled style='margin-top: -3px;border-bottom: none'>export for monitoring <img src='images/publish.png' width='18'></button> 
//<span class='tooltiptext arrow-left near' style='left: 100px'>Not available in beta version</span>
//</div>
//</div>";

echo "<div class='step-2 budget-menu tools hide'>
<button id='export-xls' onclick='return exportSummaryXLS(\"summary.xlsx\");' $disabled>download results in xls<i class='fa fa-file-excel-o' aria-hidden='true'></i></button>
<button id='export-word' onclick='$(\"#word-div\").wordExport();return false;' $disabled>download results in word<i class='fa fa-file-word-o' aria-hidden='true'></i></button> 
</div>";

//
//echo "<div class='step-2 btn-section hide' style='margin-top: 1rem;'>
//    <button class='next-btn' disabled>Benchmarking<i class='fa fa-chevron-right' aria-hidden='true'></button></i>
//    <button class='next-btn' disabled>Benchmarking<i class='fa fa-chevron-right' aria-hidden='true'></button></i>
//    </div>";

echo "<div class='step-2 btn-section'>
        <div style='float:left; font-size:14px; font-family:tahoma; color:grey;'>
        
        <button class='btn btn-default btn-circle' onclick='return setStep(\"step-1\",\"step-2\",\"proceed\");' style='margin-right: 6px;'>
        <i class='fa fa-arrow-left'></i></button>Create Plan</div>

        <div style='float: right;font-size: 14px;font-family: tahoma;color: grey;'>
        Benchmarking
        <button class='btn btn-default btn-circle' onclick='return setStep(\"step-3\",\"step-2\",\"proceed\")'; name='benchmarking' id='benchmarking'>
        <i class='fa fa-arrow-right'></i></button></div></div>";

echo "</form>";
echo "</div>";