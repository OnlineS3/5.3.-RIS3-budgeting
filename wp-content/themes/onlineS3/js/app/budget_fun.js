

function new_budget(args) {
    
    var budget_id = args.budget_id;
    var description = $('#'+$('#active-parent').val()+'_'+budget_id+'_measure').val();
    
    $('#measure').val(description);
    $('#programme').val('');
    $('#object').val('').trigger("chosen:updated");
    $('#inter').val('').trigger("chosen:updated");
    $('#finance').val('').trigger("chosen:updated");
    $('#funding').val('').trigger("chosen:updated");
    $('.budget-form #budget-id').val(budget_id);
    $('.budget-form #edit-type').val('new');
    
    var win_height;
    
    if ($('.budget-table.parent th.new-col:not(.deleted)').length > 0) {
        gen_budget_table();
        win_height = $('.budget-form .popup-content').height();
    } else {
        $('.budget-form .popup-content').css('height',530);
        win_height = 530;
    }
    
    var win_width = $('.budget-form .popup-content').width();
    var win_top = ((1-(win_height/screen.height))/ 3)*screen.height;
    var win_left = ((1-(win_width/screen.width))/ 2)*screen.width;
    
    $('.budget-form .popup-content').css('top',win_top).css('left',win_left);
    
    $('.budget-form').css('display','block');
    
    $('#programme').get(0).focus();
    
    AddBudgetFormListener(args);
    
    return false;
}

function gen_budget_table() {
    
    $('.tbl-label').remove();
    
    $('#user-budgets').remove();
    
    var table_html =  "<label class='tbl-label'>Budget values:</label>";
    table_html += '<table id="user-budgets">';
    table_html += '<thead><tr><th></th>';
    var parent_row = Number($('#active-parent').val());
    var child_row = $('#budget-id').val();
    var inner_length = Number($('#c_' + parent_row + ' #' + child_row + ' .budgets tr:not(.budget-val tr)').length) + 1;
    
    var year;
    
    $('.budget-table.parent th.new-col:not(.deleted)').each(function() {
        year = $(this).html();
        table_html += '<th>' + year + '</th>';
    });
    
    table_html += "<tr class='planned'>";
    table_html += "<td class='header'><p>Planned Value</p></td>";
    $('.budget-table.parent th.new-col:not(.deleted)').each(function() {
        year = $(this).html();
        table_html += "<td><input type='text' name='budget_val' id='" + year + "_planned' class='is_numeric " + year + "_planned'/></td>";
    });
    table_html += '</tr>';
    
    table_html += "<tr class='committed'>";
    table_html += "<td class='header'><p>Committed Value</p></td>";
    $('.budget-table.parent th.new-col:not(.deleted)').each(function() {
        year = $(this).html();
        table_html += "<td><input type='text' id='" + year + "_commit' class='is_numeric " + year + "_commit'/></td>";
    });
    table_html += '</tr>';
    
    table_html += "<tr class='spent'>";
    table_html += "<td class='header'>Spent Value</td>";
    $('.budget-table.parent th.new-col:not(.deleted)').each(function() {
        year = $(this).html();
        table_html += "<td><input type='text' id='" + year + "_spent' class='is_numeric " + year + "_spent'/></td>";
    });
    table_html += '</tr>';
    
    table_html += '</table>';
    
    $('.budget-form .btn-area').before(table_html);
    
    $("#user-budgets input[type='text']").on('change',function(e) {
        if (isNumber($(this).val())) {
            return;
        } 
        return false;
    });
    
    
//    $('.budget-form .popup-content').css('height','84%').css('top','8%').css('padding','32px 49px');
}

function edit_budget(budget_id) {
    var sep_2 = budget_id.indexOf('_',budget_id.indexOf('_')+1);
    var sep_3 = budget_id.indexOf('_',sep_2+1);
    var description = $('#'+budget_id.substring(sep_2,sep_3)+'_measure').val();
    
    var programme = $('#'+budget_id+'_programme').val();
    var object = $('#'+budget_id+'_object').val();
    var inter = $('#'+budget_id+'_inter').val();
    var finance = $('#'+budget_id+'_finance').val();
    var funding = $('#'+budget_id+'_funding').val();
    
    $('#measure').val(description);
    $('#programme').val(programme);
    $('#object').val(object).trigger("chosen:updated");
    $('#inter').val(inter).trigger("chosen:updated");
    $('#finance').val(finance).trigger("chosen:updated");
    $('#funding').val(funding).trigger("chosen:updated");
    
    var budget_val;
    $('#user-budgets input').val('');
    
    $('.budget-form #budget-id').val(budget_id);
    
    $('.budget-form #edit-type').val('edit');
    
    var win_height;
    
    $('#user-budgets').remove();
    
    var win_height;
    
    if ($('.budget-table.parent th.new-col:not(.deleted)').length > 0) {
        gen_budget_table();
        win_height = $('.budget-form .popup-content').height();
    } else {
        $('.budget-form .popup-content').css('height',530);
        win_height = 530;
    }
    
    var win_width = $('.budget-form .popup-content').width();
     
    var win_top = ((1-(win_height/screen.height))/ 3)*screen.height;
    var win_left = ((1-(win_width/screen.width))/ 2)*screen.width;
    
    $('.budget-form .popup-content').css('top',win_top).css('left',win_left);
    $('#'+budget_id+' td:not(.deleted) .budget-val tr td:not(.deleted) input').each(function() {
        budget_id = $(this).attr('id');
        budget_val = $(this).val();
        
        var sec_dash = budget_id.indexOf('_', budget_id.indexOf('_',0)+1);
        var third = budget_id.indexOf('_', sec_dash+1);
        var cls = budget_id.substring(third+1,budget_id.length);
        
        $('.'+cls).val(budget_val);
    });
    
    $('.budget-form').css('display','block');
    
    return false;
}

var return_vals = function(args) {
    
    var programme = $('#programme').val();
    var object = $('#object').val();
    var inter = $('#inter').val();
    var finance = $('#finance').val();
    var funding = $('#funding').val();
    var row_id;
    var editType = $('#edit-type').val();
    
    if (editType==='new') {
        
        row_id = create_budget_line(args);
    } else {
        row_id = $('.budget-form #budget-id').val();
    }
    
    $('#'+row_id+'_programme').val(programme);
    $('#'+row_id+'_object').val(object).trigger("chosen:updated");
    $('#'+row_id+'_object + div + input').val(object);
    $('#'+row_id+'_inter').val(inter).trigger("chosen:updated");
    $('#'+row_id+'_inter + div + input').val(inter);
    $('#'+row_id+'_finance').val(finance).trigger("chosen:updated");
    $('#'+row_id+'_finance + div + input').val(finance);
    $('#'+row_id+'_funding').val(funding).trigger("chosen:updated");
    $('#'+row_id+'_funding + div + input').val(funding);
    
    //updateParent('measure');
    updateParentCol({type:'programme'});
    updateParentCol({type:'object'});
    updateParentCol({type:'inter'});
    updateParentCol({type:'finance'});
    updateParentCol({type:'funding'});
    
    var budget_id, budget_val, cell_id, parent_id,parent_row;
    
    parent_row = row_id.substring(0,row_id.indexOf('_'));
    
    $('#user-budgets').find('tr td input').each(function() {
        
        $('.step-1 #data-analysis').prop("disabled",false);
        $('#analysis-active').val(1);
        
        budget_val = $(this).val();
        
        
        
        budget_id = $(this).attr('class').replace("is_numeric", "").replace("valid", "").replace(" ", "");
        
        cell_id = row_id + '_' + budget_id;
        $('#'+cell_id).val(budget_val);
        
        parent_id = cell_id.substring(0,cell_id.indexOf('_')) + '_' + budget_id;
        
        var sum_value=0, cur_value=0;
        parent_row = cell_id.substring(0,cell_id.indexOf('_'));
        
        $('#'+parent_id).val(0);
        
        $("[id^="+parent_row+"_][id$="+budget_id+"]").each(function(){
            cur_value = ($(this).val()) ? Number($(this).val()) : 0;
            sum_value += cur_value;
        });
        
        
        $('#'+parent_id).val(sum_value);
        
        $('#'+parent_id).parent().parent().parent().parent().removeClass('hide');
        $('#'+parent_id).parent().parent().parent().parent().parent().find('p').remove();
    });
    
    $('.budget-form').css('display','none');
    
    var parent_id = '.parent #' + parent_row;
    autoHeight(parent_id);
    
    return false;
};

function create_budget_line(args) {
    var child_row = $('#budget-id').val();
    var object_data = args.object;
    var inter_data = args.inter;
    var finance_data = args.finance;
    var funding_data = args.funding;
    var object_id, object_desc, inter_id, inter_desc, fin_id, fin_desc, fund_id,fund_desc;
    
    var hide = ($('#show_overview').is(':checked')) ? '' : 'hide';
    
    var parent_row = Number($('#active-parent').val());
    var inner_length = Number($('#c_' + parent_row + ' #' + child_row + ' .budgets tr:not(.budget-val tr)').length) + 1;
    var row_id = parent_row + '_' + child_row + '_' + inner_length;
    
    var programme = "<td class='program-td'><input type='text'  id='" + row_id + "_programme' name='" + row_id + "_programme' readonly/></td>";
    
    var object_select = "<td class='object-td list extra "+hide+"'>\n\
        <select id ='" + row_id + "_object' class='chosen-select' data-placeholder='-'>";
    for(var i = 0; i < object_data.length; i++) {
        object_id = object_data[i]['id'];
        object_desc = object_id + '-' + object_data[i]['description']; 
        object_select += "<option value='" + object_id + "'>" + object_desc + "</option>";
    }
    object_select += "</select><input type='text' class='hide' name='" + row_id + "_object'/></td>";
    
    var inter_select = "<td class='select extra "+hide+"'>\n\
        <select id ='" + row_id + "_inter' class='chosen-select' data-placeholder='-'>";
    for(var i = 0; i < inter_data.length; i++) {
        inter_id = inter_data[i]['id'];
        inter_desc = inter_id + '-' + inter_data[i]['description']; 
        inter_select += "<option value='" + inter_id + "'>" + inter_desc + "</option>";
    }
    inter_select += "</select><input type='text' class='hide' name='" + row_id + "_inter' value='" + inter_id + "'/></td>";
    
    var fin_select = "<td class='select extra "+hide+"'>\n\
        <select id ='" + row_id + "_finance' class='chosen-select' data-placeholder='-'>";
    
    for(var i = 0; i < finance_data.length; i++) {
        fin_id = finance_data[i]['id'];
        fin_desc = fin_id + '-' + finance_data[i]['description'];
        fin_select += "<option value='" + fin_id + "'>" + fin_desc + "</option>";
    }
    fin_select += "</select><input type='text' class='hide' name='" + row_id + "_finance'/></td>";
    
    var fund_select = "<td class='select extra "+hide+"'>\n\
        <select id ='" + row_id + "_funding' class='chosen-select' data-placeholder='-'>";
    for(var i = 0; i < funding_data.length; i++) {
        fund_id = funding_data[i]['id'];
        fund_desc = funding_data[i]['description'];
        fund_select += "<option value='" + fund_id + "'>" + fund_desc + "</option>";
    }
    fund_select += "</select><input type='text' class='hide' name='" + row_id + "_funding'/></td>";
    
    var edit_button = '<td class="edit-td">\n\
        <a href="#" onclick="edit_budget(\'' + row_id + '\')" id="child-0"><i class="fa fa-pencil-square-o edit-btn" aria-hidden="true"></i></a>\n\
        </td>';
    
    var budget_cols = $('#main-table').find('thead tr:first-child th.new-col:not(.deleted)');
    
    budget_cols.each(function () { 
        var year = $(this).attr('id');
        var planned_name = row_id + '_' + year + '_planned';
        var commit_name = row_id + '_' + year + '_commit';
        var spent_name = row_id + '_' + year + '_spent';
        
        budget_cols += "<td class='new-col "+ year + "'>\n\
            <table class='budget-val'>\n\
            <tr><td class='header' style='border-bottom: none !important;'>Planned:</td><td style='border-bottom: none !important;'><input type='text' class='"+ year + "_planned_val' id='"+planned_name+"' name='"+planned_name+"' placeholder='0.00' readonly/></td></tr>\n\
            <tr><td class='header' style='border-bottom: none !important;'>Committed:</td><td style='border-bottom: none !important;'><input type='text' class='"+ year + "_commit_val' id='"+commit_name+"' name='"+commit_name+"' placeholder='0.00' readonly/></td></tr>\n\
            <tr><td class='header' style='border-bottom: none !important;'> Spent:</td><td style='border-bottom: none !important;'><input type='text' class='"+ year + "_spent_val' id='"+spent_name+"' name='"+spent_name+"' placeholder='0.00' readonly/></td></tr></table></td>";
    });
    
    var new_row = "<tr id='"+row_id+"'>" + programme + object_select + inter_select + fin_select + fund_select + budget_cols + edit_button + "</tr>";
    
    if ($('#c_' + parent_row + ' #' + child_row + ' .budget-val tr').length > 0) {
        $('#c_' + parent_row + ' #' + child_row + ' .budgets tr:not(.budget-val tr):last-child').after(new_row);
    } else {
        $('#c_' + parent_row + ' #' + child_row + ' .budgets').append(new_row);
    }
    
    $('#c_' + parent_row + ' #' + child_row + ' .budgets').parent().removeClass('hide');
    
//    if ($('.parent th.new-col').length>0 || $('#show_overview').is(':checked')) {
//        $('#c_' + parent_row + ' #' + child_row + ' .budgets').parent().removeClass('hide');
//        $('#c_' + parent_row + ' #' + child_row + ' .budgets').parent().removeClass('empty');
//    }
    
    $(".chosen-select").chosen();
    
    $('.budget-table.child .chosen-select').attr('disabled', true).trigger("chosen:updated");
    
    return row_id;
}

var close_popup = function() {
    $('.budget-form').css('display','none');
    
    return false;
};

function AddBudgetFormListener(args) {
    var object = args.object;
    var inter = args.inter;
    var finance = args.finance;
    var funding = args.funding;
    $('.popup-box.budget-form input, .popup-box.budget-form select').keydown(function (e){
        if(e.keyCode === 13){
            return_vals({object:object,inter:inter,finance:finance,funding:funding});
        }
    });
}