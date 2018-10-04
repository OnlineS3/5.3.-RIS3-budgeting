<?php

?>

<div class='steps'>
    <div class="tooltip-container">
        <div class='step-1 choice active'>
            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
            <p><a href='#' onclick='setStep("step-1","step-2","proceed")'>Create Plan</a></p>
        </div>
        <span class="tooltiptext arrow-down near hide" style='left: -55px;top: -42px;'>Create Plan</span>
    </div>
    <div class="tooltip-container">
        <div class='step-2 choice init'>
            <i class="fa fa-table" aria-hidden="true"></i>
            <p><a href='#' onclick='setStep("step-2","step-1","proceed")'>Data Analysis</a></p>
        </div>
        <span class="tooltiptext arrow-down near" style='left: -55px;top: -42px;'>Data Analysis</span>
    </div>
    <div class="tooltip-container">
        <div class='step-3 choice init'>
            <i class="fa fa-line-chart" aria-hidden="true"></i>
            <p>Benchmarking</p>
        </div>
        <span class="tooltiptext arrow-down near" style='left: -55px;top: -62px;line-height:1.6'>Budget Benchmarking</span>
    </div>
</div>
 