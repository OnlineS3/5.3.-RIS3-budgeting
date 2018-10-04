<?php

function publish_data($conn,$user) {
    
    $res = exec_select($conn, "SELECT plan_id FROM budget_plan WHERE user_id=$user");
    $plan_id = $res[0]['plan_id'];
    
    if ($plan_id > 0) {
        exec_upd($conn, "UPDATE budget_plan SET published=1 WHERE plan_id=$plan_id");
    } else {
        $plan_id = exec_ins($conn, "INSERT INTO budget_plan (user_id,published) "
                    . "VALUES ($user,1)");
    }
    
    save_plan($conn,$user);
}

function save_plan($conn,$user) {

    if ($_POST['form_cleared']=='1') {
        exec_del($conn, "DELETE FROM budget_plan WHERE user_id=$user");
    }
    
    if (isset($_POST['select_region'])) {
        foreach ($_POST['select_region'] as $option) {
            $region = $option; 
        }
    } else {
        $region = $_POST['region'];
    }
    
    $res = exec_select($conn, "SELECT plan_id FROM budget_plan WHERE user_id=$user");
    $plan_id = $res[0]['plan_id'];
    
    if ($plan_id > 0) {
        exec_upd($conn, "UPDATE budget_plan SET region_id='$region' WHERE plan_id=$plan_id");
    } else {
        $plan_id = exec_ins($conn, "INSERT INTO budget_plan (user_id,region_id) "
                    . "VALUES ($user,'$region')");
    } 
    
    save_years($conn,$user);
    
    $prio_rows = $_POST['prio_rows'];
    
    for($i=1;$i<=$prio_rows;$i++){
        $prio_id = save_prio($conn,$i,$user);
        //mysqli_query($conn, "CALL reorder_measure(".$prio_id.")");
    }
    
    //mysqli_query($conn, "CALL reorder_prio(".$user.")") or die("Query fail: " . mysqli_error());
    
    del_years($conn,$user);
    
    return $prio_id;
}

function save_prio($conn,$row,$user) {
    $prio = $_POST[$row . '_priority'];
    $comment = $_POST[$row . '-comment'];
    
    $res = exec_select($conn, "SELECT id FROM priority WHERE user_id=$user and prio_order=$row");
    $prio_id = $res[0]['id'];
    
    $del_name = 'deleted_' . $row;
    $is_deleted = $_POST[$del_name];
        
    if($prio_id>0) {
        if ($is_deleted != 'deleted') {
            exec_upd($conn, "UPDATE priority SET description='$prio', comment='$comment' WHERE user_id=$user and prio_order=$row");
        } else {
            exec_del($conn, "DELETE FROM priority WHERE user_id=$user and prio_order=$row");
            mysqli_query($conn, "CALL reorder_prio(".$prio_id.")");
        }
    } else {
        if ($is_deleted != 'deleted') {
            $prio_id = exec_ins($conn, "INSERT INTO priority (user_id,description,comment,prio_order) "
                    . "VALUES ($user,'$prio','$comment',$row)");
        }
    }
    
    if ($is_deleted != 'deleted') {
        $rows = 'measure_rows_' . $row;
        $measure_rows = $_POST[$rows];


        for($i=1;$i<=$measure_rows;$i++){
            $measure_id = save_measure($conn,$row,$i,$prio_id);
        }
    }
    
    return $prio_id;
}

function save_region($conn,$user) {
    
}

function save_years($conn,$user) {
    
    $res = exec_select($conn, "SELECT 1 FROM prio_years WHERE user_id=$user");
    $user_exists = (count($res)>0) ? true : false;
    
    $years = explode(" ",$_POST['years']);
    
    if($user_exists) {
        if($years) {
            for ($i=1;$i<count($years);$i++) {
                $year = $years[$i];
                
                $res = exec_select($conn, "SELECT 1 FROM prio_years WHERE user_id=$user AND year='$year'");
                
                if(strlen($year)>0 && count($res)==0) {
                    exec_ins($conn, "INSERT INTO prio_years (year,user_id) VALUES ('$year',$user)");
                }
                
            }
        }
    } else {
        if($years) {
            for ($i=1;$i<count($years);$i++) {
                $year = $years[$i];
                if(strlen($year)>0) {
                    exec_ins($conn, "INSERT INTO prio_years (year,user_id) VALUES ('$year',$user)");
                }
            }
        }
    }
}

function save_measure($conn,$prio_row,$mea_row,$prio) {
    $measure_name = $prio_row . '_' . $mea_row . '_measure';
    $measure = $_POST[$measure_name];
    
    $res = exec_select($conn, "SELECT id FROM measure WHERE prio_id=$prio AND measure_order=$mea_row");
    $measure_exists = (count($res) > 0) ? true : false;
    
    $del_name = 'deleted_'.$prio_row.'_'.$mea_row;
    $is_deleted = $_POST[$del_name];
       
    if($measure_exists) {
        $measure_id = $res[0]['id'];
        if ($is_deleted != 'deleted') {
            exec_upd($conn, "UPDATE measure SET description='$measure' WHERE prio_id=$prio AND measure_order=$mea_row");
        } else {
            exec_del($conn, "DELETE FROM measure WHERE id=$measure_id");
            mysqli_query($conn, "CALL reorder_measure(".$measure_id.")");
        }
    } else {
        if ($is_deleted != 'deleted') {
            $measure_id = exec_ins($conn, "INSERT INTO measure (prio_id,measure_order,description) VALUES ($prio,$mea_row,'$measure')");
        }
    }
    
    if ($is_deleted != 'deleted') {
        $rows = 'budget_rows_' . $prio_row . '_' . $mea_row;
        $budget_rows = $_POST[$rows];

        for($i=1;$i<=$budget_rows;$i++){
            $budget_id = save_budget($conn,$prio_row,$mea_row,$i,$measure_id);
        }
    }
    
    return $measure_id;
}

function save_budget($conn,$prio_row,$mea_row,$budget_row,$measure_id) {
    $programme_name = $prio_row . '_' . $mea_row . '_' . $budget_row . '_programme';
    $object_name = $prio_row . '_' . $mea_row . '_' . $budget_row . '_object';
    $inter_name = $prio_row . '_' . $mea_row . '_' . $budget_row . '_inter';
    $finance_name = $prio_row . '_' . $mea_row . '_' . $budget_row . '_finance';
    $funding_name = $prio_row . '_' . $mea_row . '_' . $budget_row . '_funding';
    
    $budget_id = 0;
    
    $programme_val = $_POST[$programme_name];
    $object_val = $_POST[$object_name];
    $inter_val = $_POST[$inter_name];
    $finance_val = $_POST[$finance_name];
    $funding_val = ($_POST[$funding_name]) ? $_POST[$funding_name] : 0;
    
    $res = exec_select($conn, "SELECT id FROM budget WHERE measure=$measure_id AND budget_order=$budget_row");
    $budget_exists = (count($res) > 0) ? true : false;
    
    if($budget_exists) {
        $budget_id = $res[0]['id'];
        
        exec_upd($conn, "UPDATE budget SET programme = '$programme_val', object='$object_val',inter='$inter_val',finance='$finance_val',funding=$funding_val 
                        WHERE id=$budget_id");
    } else {
        $budget_id = exec_ins($conn, "INSERT INTO budget (measure,programme,object,inter,finance,funding,budget_order) "
                . "VALUES ($measure_id,'$programme_val','$object_val','$inter_val','$finance_val',$funding_val,$budget_row)");
    }
    
    $years = explode(" ",$_POST['years']);
    
    for ($i=0;$i<count($years);$i++) {
        if(strlen($years[$i])>0) {
            $budget_val_id = save_budget_val($conn,$prio_row,$mea_row,$budget_row,$years[$i],$budget_id);
        }
    }
    
    return $budget_id;
}

function save_budget_val($conn,$prio_row,$mea_row,$budget_row,$year,$budget_id) {
    $planned_name = $prio_row . '_' . $mea_row . '_' . $budget_row . '_' . $year . '_planned';
    $commit_name = $prio_row . '_' . $mea_row . '_' . $budget_row . '_' . $year . '_commit';
    $spent_name = $prio_row . '_' . $mea_row . '_' . $budget_row . '_' . $year . '_spent';
    
    $planned_val = ($_POST[$planned_name]) ? $_POST[$planned_name] : 0;
    $commit_val = ($_POST[$commit_name]) ? $_POST[$commit_name] : 0;
    $spent_val = ($_POST[$spent_name]) ? $_POST[$spent_name] : 0;
    
    $res = exec_select($conn, "SELECT 1 FROM budget_val WHERE budget_id=$budget_id AND year='$year'");
    $budget_val_exists = (count($res) > 0) ? true : false;
    
    if($budget_val_exists) {
        $budget_val_id = exec_upd($conn, "UPDATE budget_val SET planned=$planned_val, commit=$commit_val, spent=$spent_val "
                . " WHERE budget_id=$budget_id AND year='$year'");
    } else {
        $budget_val_id = exec_ins($conn, "INSERT INTO budget_val "
                . "VALUES ($budget_id,'$year',$planned_val,$commit_val,$spent_val)");
    }
    
    return $budget_val_id;
}

function del_years($conn,$user) {
    $years = explode(" ",$_POST['del_years']);
    
    if(count($years)>0) {
        
        foreach($years as $year) {
            if(strlen($year)>0) {
                exec_del($conn, "DELETE FROM prio_years WHERE year=$year");
                exec_del($conn, "DELETE FROM budget_val 
                        WHERE EXISTS (SELECT 1 FROM budget 
                        JOIN measure ON measure.id=budget.measure 
                        JOIN priority ON priority.id = measure.prio_id 
                        WHERE priority.user_id=$user AND budget.id=budget_val.budget_id ) AND budget_val.year='$year'");
            }
            
        }
    }
    
    
}