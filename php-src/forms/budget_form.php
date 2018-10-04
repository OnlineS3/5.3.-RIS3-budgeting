
<?php
 
$dd_res = get_dd_res($conn,$user_id);

echo "<div class='popup-box budget-form'>";

echo "<form id='budget-form' class='validate-form'>";

echo "<div class='popup-content'>";

echo "<i class='fa fa-times close-popup close-post' aria-hidden='true' style='color: #dbdbdb !important;' onclick='return close_popup();'></i>";

echo "<p class='popup-title'>Budget details</p>";

echo "<div class='elem'>";
echo "<label>Measure Description:</label>";
echo "<input id='measure' value='$measure' disabled/>";
echo "</div>";

echo "<div class='elem'>";
echo "<label>Operational Programme:</label>";
echo "<input id='programme' value='$programme'/>";
echo "</div>";

echo "<div class='elem'>";
echo "<label>Thematic Objective:</label>";
echo "<select id ='object' class='chosen-select' data-placeholder='form of finance.. '>"; 
        echo "<option value=''></option>";
        $object_res = $dd_res['object'];
        
        for($x = 0; $x < count($object_res); $x++) {
            $object_id = $object_res[$x]['id'];
            $object_desc = $object_id . '-' . $object_res[$x]['description'];
            echo "<option value='$object_id' $selected>$object_desc</option>";
        }
        echo "</select>";
echo "</div>";

echo "<div class='elem'>";
echo "<label>Intervention code:</label>";
echo "<select id ='inter' class='chosen-select' data-placeholder='intervention.. '>";
        echo "<option value=''></option>";
        $inter_res = $dd_res['inter'];
        for($x = 0; $x < count($inter_res); $x++) {
            $inter_id = $inter_res[$x]['id'];
            $inter_desc = $inter_id . '-' . utf8_encode($inter_res[$x]['description']);
            echo "<option value='$inter_id' $selected>$inter_desc</option>";
        }
        echo "</select>";
echo "</div>";

echo "<div class='elem'>";
echo "<label>Form of finance:</label>";
echo "<select id='finance' class='chosen-select' data-placeholder='form of finance.. ' >"; 
        echo "<option value=''></option>";
        $fin_res = $dd_res['finance'];
        for($x = 0; $x < count($fin_res); $x++) {
            $fin_id = $fin_res[$x]['id'];
            $fin_desc = $fin_id . '-' . $fin_res[$x]['description'];
            echo "<option value='$fin_id' $selected>$fin_desc</option>";
        }
        echo "</select>";
echo "</div>";

echo "<div class='elem'>";
echo "<label>Funding source:</label>";
echo "<select id ='funding' class='chosen-select' data-placeholder='funding source.. ' >";
        echo "<option value=''></option>";
        $fund_res = $dd_res['funding'];
        for($x = 0; $x < count($fund_res); $x++) {
            $fund_id = $fund_res[$x]['id'];
            $fund_desc = utf8_encode($fund_res[$x]['description']);
            echo "<option value='$fund_id' $selected>$fund_desc</option>";
       }
       echo "</select>";
echo "</div>";

$object = $dd_res['object_json'];
$inter = $dd_res['inter_json'];
$finance = $dd_res['finance_json'];
$funding = $dd_res['funding_json'];

echo "<input class='hide' id='budget-id' />";
echo "<input class='hide' id='edit-type' />";
echo "<input class='hide' id='edited-child' />";

echo "<div class='btn-area'>";
echo "<button type='submit' onclick='return return_vals({object:$object,inter:$inter,finance:$finance,funding:$funding})'>OK</button>";
echo "<button style='color: #989898 !important;' onclick='return close_popup()'>Cancel</button>";
echo "</div>";

echo "</div>";
echo "</form>";

echo "</div>";
?>