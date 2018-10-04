
function addParentRow(args) {
    var row_id = $('#main-table tbody tr:not(.budget-val tr)').length+1;
    
    var year;
    
    var object_list = JSON.stringify(args.object);
    var inter_list = JSON.stringify(args.inter);
    var finance_list = JSON.stringify(args.finance);
    var funding_list = JSON.stringify(args.funding);
    
    $('.prio_rows').val(row_id);
    $('#active-parent').val(row_id);
    
    var cols_no = $('#main-table thead tr:first-child th.new-col:not(.deleted)').length;
    
    var all_cols = ($('#show_overview').is(':checked')) ? '' : 'hide'; 
    
    var new_row = "<tr class='' id='" + row_id + "'>\n\
        <td class='priority-td textarea base headcol' id='" + row_id + "_priority'>\n\
        <textarea name='" + row_id + "_priority' class='priority' type='text' placeholder='description...'></textarea>\n\
        </td>\n\
        <td id='" + row_id + "_measure' class='measures measure-td list base'><p class='hide'></p><button id='add-" + row_id + "' \n\
                onclick='return addMeasure({btn:\"add-"+row_id+"\",prio:\""+row_id+"\",object:"+object_list+",inter:"+inter_list+",finance:"+finance_list+",funding:"+funding_list+"});' class='add-measure' id='add-measure'>+ define measures</button><ul id='"+row_id+"-measure-text' class='ellipse dashed hide'></ul> <input type='text' name='" + row_id + "_1_p' class='hide' id='"+row_id+"-measure-text-hide'/></td>\n\
        <td id='" + row_id + "_programme' class='programme programme-td list disable'><p class='load-measure'>&#8208;&#8208;</p><ul id='"+row_id+"-programme-text' class='ellipse dashed hide'></ul> <input type='text' name='" + row_id + "_1_p' class='hide' id='"+row_id+"-programme-text-hide'/></td>\n\
        <td id='" + row_id + "_object'  class='object object-td list extra disable " + all_cols + "'><p class='load-measure'>&#8208;&#8208;</p><ul id='"+row_id+"-object-text' class='ellipse dashed hide'></ul> <input type='text' name='" + row_id + "_1_p' class='hide' id='"+row_id+"-object-text-hide'/></td>\n\
        <td id='" + row_id + "_inter'  class='inter inter-td list extra disable " + all_cols + "'><p class='load-measure'>&#8208;&#8208;</p><ul id='"+row_id+"-inter-text' class='ellipse dashed hide'></ul> <input type='text' name='" + row_id + "_1_p' class='hide' id='"+row_id+"-inter-text-hide'/></td>\n\
        <td id='" + row_id + "_finance' class='finance fin-td list extra disable " + all_cols + "'><p class='load-measure'>&#8208;&#8208;</p><ul id='"+row_id+"-fin-text' class='ellipse dashed hide'></ul> <input type='text' name='" + row_id + "_2_p' class='hide' id='"+row_id+"-fin-text-hide'/></td>\n\
        <td id='" + row_id + "_funding' class='funding fund-td list extra disable " + all_cols + "'><p class='load-measure'>&#8208;&#8208;</p><ul id='"+row_id+"-fund-text' class='ellipse dashed hide'></ul> <input type='text' name='" + row_id + "_3_p' class='hide' id='"+row_id+"-fund-text-hide'/></td>\n\
        <td id='" + row_id + "_comment' class='comment-td extra disable " + all_cols + "'><p class='load-measure'>&#8208;&#8208;</p><input type='text' class='hide' id='"+row_id+"-comment' name='"+row_id+" comment'/></td>";
        
        var i=0; 
        $('.parent th.new-col:not(.deleted)').each(function() {
            year = $(this).attr('id');
            var p_row_id = row_id + '_' + (i+5) + '_p';
            var budget_cols = "<td class='new-col base disable "+year+"' id='"+p_row_id+"'><p class='load-measure'>--</p>\n\
                <table class='budget-val hide'>\n\
                <tr><td class='header'>Planned:</td><td><input type='text' class='planned_val' id='"+row_id+"_"+year + "_planned' name='"+row_id+"_"+year + "_planned' disabled/></td></tr>\n\
                <tr><td class='header'>Committed:</td><td><input type='text' class='commit_val' id='"+row_id+"_"+year + "_commit' name='"+row_id+"_"+year + "_commit' disabled/></td></tr>\n\
                <tr><td class='header'> Spent:</td><td><input type='text' class='spent_val' id='"+row_id+"_"+year + "_spent' name='"+row_id+"_"+year + "_spent' disabled/></td></tr>\n\
                </table></td>";
            new_row += budget_cols;
            i++;
        });
    
    new_row += "<td class='del-td'><div><a href='#' class='del-row prio-options'>\n\
        ...</a></div><input name='deleted_"+row_id+"' id='deleted_"+row_id+"' class='hide' type='text'/></td>\n\
        <td class='table-menu hide'><div><ul><li><a href='#' onclick='return set_comment("+row_id+");'>Comment</a></li><li><a href='#' onclick='delRow("+row_id+")'>Delete</a></li></ul></div></td>\n\
        </tr>";
    
    $('#main-table').append(new_row);
    
    $('.inner').addClass('hide');
    $('#add-child-row').addClass('hide');
    $('.fill-measures .tip').addClass('hide');
    
    $('#'+row_id).parent().find('tr').removeClass('active');
    $('#'+row_id).addClass('active');
    
    //createChildTable(args);
    
    $("#" + row_id + "_priority").find('textarea').get(0).focus();
    
    addParentListener(row_id);
    
    return false;
}

function addMeasure(args) {
    var btn = args.btn;
    
    createChildTable(args);
    
    $('#'+btn).parent().parent().parent().find('tr').removeClass('active');
    $('#'+btn).parent().parent().addClass('active');

    var row_id = args.prio;
    
    $('#'+btn).parent().parent().parent().find('tr').removeClass('active');
    $('#'+btn).parent().parent().addClass('active');
    $('.fill-measures').removeClass('hide');
    //$('#'+btn).css('color','#b7b7b7').prop('disabled',true);
    $('#'+btn).parent().append("<p class='load-measure'>‐‐</p>");
    
    $('#'+btn).css('display','none');
    $('.inner').addClass('hide');
    
    $('#c_'+row_id).parent().addClass('made').removeClass('hide');

    var prio = $('#'+btn).parent().parent().find('.priority').val();
    if(prio) {
        $('.fill-measures #prio-title').html('(<span class="cl">'+prio+'</span>)');
    } else {
        $('.fill-measures #prio-title').html('');
    }

    $('#active-parent').val(row_id);
    
    $("#" + row_id + "_1_measure").get(0).focus();

    return false;
}

function createChildTable(args) {
    
    $('.inner').addClass('hide');
    
    var all_cols = ($('#show_overview').is(':checked')) ? '' : 'hide'; 
    
    var parent_id = (args.prio) ? args.prio : Number($('.prio_rows').val());
    var cols_no = $('#main-table thead tr:first-child th.new-col:not(.deleted)').length;
    var year;
   
    var new_table = "<div class='inner hide'>\n\
        <input type='text' class='hide measure_rows_" + parent_id +"' name='measure_rows_" + parent_id +"' value='0'/>\n\
        <table class='budget-table child' id='c_"+parent_id+"'>\n\
        <thead><tr>\n\
        <th id=''>Measure</th>\n\
        <th id='' class='add-budget'></th>\n\
        <th id='' class=''>Programme</th>\n\
        <th id='' class='extra " + all_cols + "'>Objective</th>\n\
        <th id='' class='extra " + all_cols + "'>Intervention</th>\n\
        <th id='' class='extra " + all_cols + "'>Form of finance</th>\n\
        <th id='' class='extra " + all_cols + "'>Funding</th>";
    
    $('#main-table thead tr:first-child th.new-col:not(.deleted)').each(function() {
        year = $(this).attr('id');
        new_table += "<th class='new-col "+year+"' id=''>" + year + "</th>";
    });
    
    new_table += "<th id='' class='edit-td'>&nbsp;</th>\n\
     <th class='del-td extra'></th></tr></thead>\n\
        <tbody>\n\
        </tbody>\n\
        </table></div>";
    
    
    
    $('#add-child-row').before(new_table);
    
    $('.section.fill-measures').addClass('hide');
    
    addChildRow(args);
}

function addChildRow(args) {
 
    var object = JSON.stringify(args.object);
    var inter = JSON.stringify(args.inter);
    var finance = JSON.stringify(args.finance);
    var funding = JSON.stringify(args.funding);
    
    var parent_row = (args.prio) ? args.prio : Number($('#active-parent').val());
    
    var child_row_id = 'measure_rows_' + parent_row;
    
    var child_row = $('#c_'+parent_row+' tbody tr:not(.budget-val tr):not(.budgets tr)').length+1;
    
    $('.'+child_row_id).val(child_row);
    
    var table_id = 'c_' + parent_row;
        
    var measure_input = "<td class='measure-td textarea'>\n\
            <textarea name='" + parent_row + "_" + child_row + "_measure' id='" + parent_row + "_" + child_row + "_measure' class='measure' type='text' placeholder='measure..'></textarea>\n\
            <input class='hide' id='budget_rows_" + parent_row + '_' + child_row + "' type='text' name='budget_rows_" + parent_row + '_' + child_row + "'/>\n\</td>";
    
    var add_btn = "<td class='add-budget-td'><button class='btn-primary button add-budget' id='add-'"+ child_row +"' onclick='return new_budget({budget_id:"+child_row+",object:"+object+",inter:"+inter+",finance:"+finance+",funding:"+funding+"});'>Add budget</button>\n\
                    <input id='active-child' class='hide' value='" + child_row + "'/></td>";
    
    var colspan=6+$('.parent th.new-col:not(.deleted)').length;
    
    var years = $('.parent th.new-col:not(.deleted)').length;
    var show_years = (years>0 || $('#show_overview').is(':checked')) ? '' : 'hide';

    var budgets_tbl = "<td class='budget-tr' colspan='"+ colspan +"'><table class='budgets'></table></td>";   
 
    var del_button = "<td class='del-td'><div><a href='#' class='del-row' title='remove measure' onclick='delRow("+parent_row +","+child_row+")'>\n\
        <i class='fa fa-times' aria-hidden='true'></i></div><input name='deleted_"+parent_row +"_"+child_row+"' id='deleted_"+parent_row +","+child_row+"' class='hide' type='text'/></td>";
    
    var c_id = child_row;
    
    var new_row = "<tr id='"+c_id+"'>" + measure_input + add_btn + budgets_tbl + del_button + "</tr>";
    $('#'+table_id).append(new_row);
    
    $("#" + parent_row + "_" + child_row + "_measure").get(0).focus();
    
    $(".chosen-select").chosen();
    
    addChildListener(parent_row,child_row);
    
    addBudgetListener(parent_row,child_row);
    
    return false;
}

function addCol(year) {
    var table_id = 'main-table';
    
    var row_id = $('#active-parent').val();
    var col_id = $('#main-table th').length;
    
    var year_id=col_id+'_year';
    
    // add column to parent header
    $("#" + table_id + " thead tr th.btn-td").before("<th class='new-col "+year+"' id='"+year+"'>"+year+"</th>");
    
    // add columns to parent rows
    var row=1;
    $("#" + table_id + " tbody tr:not(.budget-val tr)").each(function(index) {
        var parent_budget = "<td class='new-col "+year+"' id='"+year+"'><p class='load-measure'>--</p>\n\
            <table class='budget-val hide'>\n\
            <tr><td class='header'>Planned:</td><td><input type='text' class='planned_val' id='"+row+"_"+year + "_planned' name='"+row+"_"+year + "_planned' disabled/></td></tr>\n\
            <tr><td class='header'>Committed:</td><td><input type='text' class='commit_val' id='"+row+"_"+year + "_commit' name='"+row+"_"+year + "_commit' disabled/></td></tr>\n\
            <tr><td class='header'> Spent:</td><td><input type='text' class='spent_val' id='"+row+"_"+year + "_spent' name='"+row+"_"+year + "_spent' disabled/></td></tr>\n\
            </table></td>";
        $(this).find('.del-td').before(parent_budget);
        row++;
    });
    
    // add column to children
    var child_tbl = $(".child");
    child_tbl.each(function() { 
        
        $(this).find("thead th.edit-td").before("<th class='new-col "+year+"' id='c_"+year+"'>"+year+"</th>");
        
        var child_rows = $(this).find("tbody .budgets tr:not(.budget-val tr)");
        
        child_rows.each(function() {
            
            var child_id = $(this).attr('id');
            
            $(this).find("td.edit-td").before("<td class='new-col "+year+"'>\n\
            <table class='budget-val'>\n\
            <tr><td class='header' style='border-bottom: none !important;'>Planned:</td><td style='border-bottom: none !important;'><input type='text' class='"+ year + "_planned_val' id='"+child_id+'_'+year+"_planned' name='"+child_id+'_'+year+"_planned' placeholder='0.00'/></td></tr>\n\
            <tr><td class='header' style='border-bottom: none !important;'>Committed:</td><td style='border-bottom: none !important;'><input type='text' class='"+ year + "_commit_val' id='"+child_id+'_'+year+"_commit' name='"+child_id+'_'+year+"_commit' placeholder='0.00'/></td></tr>\n\
            <tr><td class='header' style='border-bottom: none !important;'>Spent:</td><td style='border-bottom: none !important;'><input type='text' class='"+ year + "_spent_val' id='"+child_id+'_'+year+"_spent' name='"+child_id+'_'+year+"_spent' placeholder='0.00'/></td></tr>\n\
            </table></td>");
            
            addBudgetListener(row_id,child_id);
        });
        
        $('#c_' + row_id + ' .budget-tr').removeClass('hide');
        
    }); 
    
    var current_cols = Number($('.budget-tr').attr('colspan'));
    
    $('.budget-tr').attr('colspan',current_cols+1);
    
    var budget_cols = Number($('#budget-cols').val())+1;
    $('#budget-cols').val(budget_cols);
    
    addYearListener(row_id,year_id);
    
    
    
    return false;
}

function delRow(parent_id, child_id=null) {
    if(!child_id) {
        swal({
        title: 'Are you sure?',
        text: "Measure data related to this priority will be removed.",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#ccc',
        confirmButtonText: 'Yes, remove it!'
      }).then(function () {
            $('#main-table tr#' + parent_id).addClass('deleted');
            $('#c_'+parent_id).parent().parent().parent().addClass('hide');
            $('#c_'+parent_id).addClass('deleted');
            $('#deleted_'+parent_id).val('deleted');
            $('#main-table tr#1').click();
      });
        
        
    } else {
        
        swal({
            title: 'Are you sure?',
            text: "Budget related to this measure will be removed.",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#ccc',
            confirmButtonText: 'Yes, remove it!'
          }).then(function () {
                $('#c_'+parent_id+' tr#' + child_id).addClass('deleted');
                $('#c_'+parent_id+' #deleted_'+parent_id+'_'+child_id).val('deleted');
                updateParentRow(parent_id);
        });
    }
}

function delCol(col_id,btn_id) {
    alert(col_id);
    
    swal({
        title: 'Are you sure?',
        text: "All budget data related to this year will be removed.",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#ccc',
        confirmButtonText: 'Yes, remove it!'
      }).then(function () {
            var years = $('#years').val();
            years = years.replace(col_id, "");
            $('#years').val(years);
            $('#del-years').val($('#del-years').val()+' '+col_id);
            $('#years'+btn_id).parent().parent().addClass('deleted');
            $('#'+btn_id).parent().parent().addClass('deleted');
            $(".new-col."+col_id).find('input').attr('id','').attr('name','');
            $("."+col_id).addClass('deleted');
            
            var colspan = $(".child .budget-tr").attr('colspan');
            $(".child .budget-tr").attr('colspan',colspan-1);
            
      });
    
}

function updateParentRow(row) {
    var cols = ['programme','object','inter','finance','funding'], col;
    
    for(var i=0;i<cols.length;i++) {
        col = cols[i];
        updateParentCol({type:col,parent:row});
    }
       
}

function updateParentCol(args) {
    var type = args.type;
    var parent_row = args.parent;
    
    if((!$('#'+type).val())&&(!parent_row)) {
        return false;
    }
    
    parent_row = (parent_row) ? parent_row : Number($('#active-parent').val());
    var cell_id = parent_row + '_' + type;
    var new_val='',added_val='';
    
    $("#c_" + parent_row + " tr:not(.budget-tr tr):not(tr.deleted)").each(function() {
        $(this).find("[id^="+parent_row+"_][id$=_"+type+"]").each(function(){
            if (type !== 'measure' && type !== 'programme') {
                new_val = ($(this).find("option:selected").text()) ? ("<li>" + $(this).find("option:selected").text() + "</li>") : '';
                added_val = (!added_val.includes(new_val)) ? (added_val + new_val) : added_val;

            } else {
                new_val += ($(this).val()) ? ("<li>" + $(this).val() + "</li>") : '';
                added_val += ($(this).val()) ? ("<li>" + $(this).val() + "</li>") : '';
            }
        });
    });
    
    var upd_cell_hidden = '#main-table #' + cell_id + ' input';
    var upd_cell = '#main-table #' + cell_id + ' ul.ellipse';
    
    $(upd_cell_hidden).parent().find('p').remove();
    $(upd_cell_hidden).val(added_val);
    
    var cell_hidden;
    if ($(upd_cell).parent().hasClass('hide')) {
        cell_hidden=true;
        $(upd_cell).parent().removeClass('hide');
    }
    
    $(upd_cell).removeClass('hide');
    
    ellipsizeTextBox($(upd_cell).attr('id'),$(upd_cell_hidden).attr('id'),cell_hidden);
    
    if (cell_hidden) {
        $(upd_cell).parent().addClass('hide');
    }
    
}

function setActive() {
    var active_row = $('#active-parent').val();
    
    $('.child-div .inner').addClass('hide');
    $('#child-'+active_row).parent().removeClass('hide');
    
    return false;
}
