<?php

function get_nuts_labels($conn) {
    $nuts_0 = exec_select($conn, "SELECT code, label FROM nuts0 ORDER BY code");
    $nuts_1 = exec_select($conn, "SELECT code, label FROM nuts1 ORDER BY code");
    $nuts_2 = exec_select($conn, "SELECT code, label FROM region ORDER BY code");
    
    $nuts_0_json = json_encode($nuts_0,JSON_UNESCAPED_UNICODE);
    $nuts_1_json = json_encode($nuts_1,JSON_UNESCAPED_UNICODE);
    $nuts_2_json = json_encode($nuts_2,JSON_UNESCAPED_UNICODE);
    
    return array('nuts_0'=>$nuts_0,'nuts_1'=>$nuts_1,'nuts_2'=>$nuts_2,'nuts_0_json'=>$nuts_0_json,'nuts_1_json'=>$nuts_1_json,'nuts_2_json'=>$nuts_2_json);
}

function get_dd_res($conn,$user_id) {
    
    $fund_encoded = $inter_encoded = array();
    
    $prio_res = exec_select($conn, "SELECT id, description FROM priority WHERE user_id=$user_id");
    $programme_res = exec_select($conn, "SELECT distinct budget.programme FROM budget JOIN measure ON measure.id = budget.measure JOIN priority ON priority.id = measure.prio_id WHERE priority.user_id=$user_id");
    $year_res = exec_select($conn, "SELECT distinct budget_val.year as year FROM budget_val JOIN budget ON budget_val.budget_id = budget.id JOIN measure ON measure.id = budget.measure JOIN priority ON priority.id = measure.prio_id WHERE priority.user_id=$user_id");
    $object_res = exec_select($conn, "SELECT * FROM objective");
    $object_json = json_encode($object_res);
    $fund_res = exec_select($conn, "SELECT * FROM funding");
    $inter_res = exec_select($conn, "SELECT * FROM inter");
    $fin_res = exec_select($conn, "SELECT * FROM finance");
    $fin_json = json_encode($fin_res);
    
    for($x = 0; $x < count($fund_res); $x++) {
        $fund_id = $fund_res[$x]['id'];
        $fund_desc = utf8_encode($fund_res[$x]['description']);
        array_push($fund_encoded,array('id'=>$fund_id,'description'=>$fund_desc));
    }

    $fund_json = json_encode($fund_encoded);
    
    for($x = 0; $x < count($inter_res); $x++) {
        $inter_id = $inter_res[$x]['id'];
        $inter_desc = $inter_id . '-' . normalize_input($inter_res[$x]['description']);
        array_push($inter_encoded,array('id'=>$inter_id,'description'=>normalize_input($inter_res[$x]['description'])));
        $inter_json = normalize_input(json_encode($inter_encoded));
    }
    
    return array('prio'=>$prio_res,'programme'=>$programme_res,'object'=>$object_res,'funding'=>$fund_res,'inter'=>$inter_res,'finance'=>$fin_res,'year'=>$year_res,
        'object_json'=>$object_json,'funding_json'=>$fund_json,'inter_json'=>$inter_json,'finance_json'=>$fin_json);
}

function get_published_values($conn) {
    $regions = exec_select($conn, "SELECT distinct plan.region_id as region_id,
                                    nuts0.label as region_lb 
                                    FROM budget_plan plan 
                                    JOIN nuts0 ON nuts0.code = plan.region_id 
                                    WHERE plan.published=1
                                    UNION
                                    SELECT distinct plan.region_id as region_id,
                                    nuts1.label as region_lb 
                                    FROM budget_plan plan 
                                    JOIN nuts1 ON nuts1.code = plan.region_id 
                                    WHERE plan.published=1
                                    UNION
                                    SELECT distinct plan.region_id as region_id,
                                    region.label as region_lb 
                                    FROM budget_plan plan 
                                    JOIN region ON region.code = plan.region_id 
                                    WHERE plan.published=1");
    $years = exec_select($conn, "SELECT distinct year FROM prio_years years JOIN budget_plan plan ON years.user_id = plan.user_id AND plan.published=1");
    
    
    
    $chart_data = exec_select($conn, "SELECT budget_plan.region_id as region, 
                                        budget_val.year as year, 
                                        sum(budget_val.planned) as planned,
                                        sum(budget_val.commit) as commit,
                                        sum(budget_val.spent) as spent
                                        FROM budget_val 
                                        JOIN budget ON budget_val.budget_id = budget.id  
                                        JOIN measure ON measure.id = budget.measure 
                                        JOIN priority ON priority.id = measure.prio_id 
                                        JOIN budget_plan ON budget_plan.user_id = priority.user_id
                                        GROUP BY budget_plan.region_id, budget_val.year");
    
    return array('regions'=>$regions,'years'=>$years,'chart_data'=>$chart_data);
}

function get_budget_values($conn,$user_id) {
    
    $region_res = exec_select($conn, "SELECT distinct region_id FROM budget_plan WHERE user_id=$user_id");
    
    $year_res = exec_select($conn, "SELECT distinct year FROM prio_years WHERE user_id=$user_id");
    
    $prios_res = exec_select($conn, 
            "SELECT prio.id as prio_id,
                prio.description as description,
                group_concat(distinct nullif(measure.description,'')) as measure,
                group_concat(distinct budget.programme) AS programme,
                group_concat(distinct nullif(concat(object.id,'-',object.description),'')) AS object,
                group_concat(distinct nullif(concat(inter.id,'-',inter.description),'')) AS inter,
                group_concat(distinct nullif(concat(finance.id,'-',finance.description),'')) AS finance,
                group_concat(distinct funding.description) AS funding,
                prio.comment as comment
            FROM priority prio
            LEFT JOIN measure ON prio.id = measure.prio_id
            LEFT JOIN budget ON budget.measure = measure.id
            LEFT JOIN objective object ON object.id = budget.object
            LEFT JOIN inter ON inter.id = budget.inter
            LEFT JOIN finance finance ON finance.id = budget.finance
            LEFT JOIN funding funding ON funding.id = budget.funding
            WHERE user_id = $user_id
            GROUP BY prio.id ");
    
    return array('region'=>$region_res[0],'years'=>$year_res,'prios'=>$prios_res);
}

function load_prio_budget($conn,$prio_id, $year) {
    $res = exec_select($conn,
        "SELECT prio.id as prio_id,
            budget_val.year AS year,
            sum(coalesce(budget_val.planned,0)) AS planned,
            sum(coalesce(budget_val.commit,0)) AS commit,
            sum(coalesce(budget_val.spent,0)) AS spent
        FROM priority prio
        JOIN measure ON prio.id = measure.prio_id
        JOIN budget ON budget.measure = measure.id
        JOIN budget_val ON budget.id = budget_val.budget_id 
        WHERE prio.id = $prio_id and budget_val.year = '$year'");
    
    return $res;
}

function load_prio_measures($conn,$prio_id) {
    $res = exec_select($conn,
        "SELECT prio.id AS prio_id,
            measure.id AS measure_id,
            measure.description as measure
        FROM priority prio
        JOIN measure ON prio.id = measure.prio_id
        WHERE prio_id=$prio_id");
    
    return $res;
}
    
function get_budget_by_measure($conn,$measure_id) {
    $res = exec_select($conn,
        "SELECT measure.id AS id,
        budget.programme AS programme,
        object.id AS object,
        inter.id AS inter,
        finance.id AS finance,
        funding.id AS funding,
        budget.id AS budget_id
    FROM measure
    JOIN budget ON budget.measure = measure.id
    LEFT JOIN objective object ON object.id = budget.object
    LEFT JOIN inter ON inter.id = budget.inter
    LEFT JOIN finance finance ON finance.id = budget.finance
    LEFT JOIN funding funding ON funding.id = budget.funding
    WHERE measure.id = $measure_id");
    
    return $res;
}

function get_budget_vals($conn,$budget_id) {
    $res = exec_select($conn,
        "SELECT year, planned, commit, spent FROM budget_val WHERE budget_id=$budget_id");
    
    return $res;
}

function get_summary($conn,$user_id,$filters,$show_col,$group_type) {
    //$user_id = 1;
    $tbl_res = array();
    $sql = create_sql($user_id,$group_type,$filters);
    $tbl_res = exec_select($conn,$sql);
    
    return $tbl_res;
}

function create_sql($user_id,$group_table,$filters) {
    $prio = $filters['prio'];
    $programme = $filters['programme'];
    $object = $filters['object'];
    $inter = $filters['inter'];
    $finance = $filters['finance'];
    $funding = $filters['funding'];
    $year = $filters['year'];
    
    $sql_str = 
    "SELECT '$group_table' as group_table, 
        $group_table.id AS row_id,
        $group_table.description as group_col,
        group_concat(distinct prio.description) AS prio,
        group_concat(distinct budget.programme) AS programme,
        group_concat(distinct nullif(concat(object.id,'-',object.description),'')) AS object,
        group_concat(distinct nullif(concat(inter.id,'-',inter.description),'')) AS inter,
        group_concat(distinct nullif(concat(finance.id,'-',finance.description),'')) AS finance,
        group_concat(distinct funding.description) AS funding,
        coalesce(budget_val.year,'') AS year,
        sum(coalesce(budget_val.planned,0)) AS planned,
        sum(coalesce(budget_val.commit,0)) AS commit,
        sum(coalesce(budget_val.spent,0)) AS spent
    FROM priority prio
    JOIN measure ON prio.id = measure.prio_id AND (prio.id IN " . $prio . ")
    JOIN budget ON budget.measure = measure.id
    JOIN budget_val ON budget.id = budget_val.budget_id AND coalesce(budget_val.year,'') <> ''
    LEFT JOIN objective object ON object.id = budget.object
    LEFT JOIN inter ON inter.id = budget.inter
    LEFT JOIN finance finance ON finance.id = budget.finance
    LEFT JOIN funding funding ON funding.id = budget.funding
    WHERE prio.user_id = $user_id AND 
        (budget.programme IN " . $programme  . " OR coalesce(budget.programme,'')='') AND
        (budget.object IN " . $object  . " OR coalesce(budget.object,'')='') AND
        (budget.inter IN " . $inter  . " OR coalesce(budget.inter,'')='') AND
        (budget.finance IN " . $finance  . " OR coalesce(budget.finance,'')='') AND
        (budget.funding IN " . $funding  . " OR coalesce(budget.funding,0)=0) AND
        (budget_val.year IN " . $year  . " OR coalesce(budget_val.year,'')='')
    GROUP BY $group_table.id, coalesce(budget_val.year,'')";
    
    return $sql_str;
}
