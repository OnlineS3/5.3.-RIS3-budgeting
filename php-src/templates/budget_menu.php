<?php

echo "<div class='step-1 budget-menu tools'>
    
<button id='save-data' name='save-data'>save<i class='fa fa-floppy-o' aria-hidden='true'></i></button>
<button id='clear-data' name='clear-data'>clear<i class='fa fa-eraser' aria-hidden='true'></i></button> 
<button onclick='return exportMainXLS(\"budgets.xlsx\");'>download<i class='fa fa-download' aria-hidden='true'></i></button> 
<div class='tooltip-container'>
<button disabled style='margin-top: -3px;border-bottom: none'>publish <img src='images/publish.png' width='18'></button> 
<span class='tooltiptext arrow-left near' style='left: 100px'>Not available in beta version</span>
</div>
</div>";

echo "<div class='step-1 budget-menu show-all chk-primary'>
    <input type='checkbox' name='show_all' id='show_budget' value='show_budget' checked>
    <label class='check' for='show_budget'>Show only budget</label>  
    <input type='checkbox' name='show_overview' id='show_overview' value='show_overview'>
    <label class='check' for='show_overview'>Show additional info</label>    
</div>";


$disabled = (isset($_POST['filter_results'])) ? '' : 'disabled';

echo "<div class='step-2 budget-menu tools hide'>
<button id='export-xls' onclick='return exportSummaryXLS(\"summary.xlsx\");' $disabled>download results in xls<i class='fa fa-file-excel-o' aria-hidden='true'></i></button>
<button id='export-word' onclick='$(\"#word-div\").wordExport();return false;' $disabled>download results in word<i class='fa fa-file-word-o' aria-hidden='true'></i></button> 
<div class='tooltip-container'>
<button disabled style='margin-top: -3px;border-bottom: none'>export for monitoring <img src='images/publish.png' width='18'></button> 
<span class='tooltiptext arrow-left near' style='left: 100px'>Not available in beta version</span>
</div>
</div>";

