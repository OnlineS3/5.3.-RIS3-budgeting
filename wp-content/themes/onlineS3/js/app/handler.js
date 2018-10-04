/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function addYearListener(parent_id,year_id) {
    var child_id = year_id + '_child';
    $('#'+year_id).on('change', function() {
        var year = $(this).val();
        
        var col_id = year_id.substr(0,1);
        var child_id = parent_id + '_0_' + (col_id-1) + '_c';
        
        $('#'+child_id + ' input').val(year);
    });
}

function addParentListener(row_id) {
    
    $('.textarea [contenteditable]').on("input",function(){
        $(this).parent().find('textarea').val($(this).html());
    });
    
    $("#main-table tr#"+row_id).on('click', function() {
        $(this).parent().find('tr').removeClass('active');
        $(this).addClass('active');
        
        var row_id = $(this).attr('id');
        
        $('.child-div .inner').addClass('hide');
        
        if(!$('#c_'+row_id).parent().hasClass('made')) {
            $('#c_'+row_id).parent('.inner').addClass('hide');
            $('#add-child-row').addClass('hide');
            $('.fill-measures .tip').addClass('hide');
        } else {
            $('.inner').addClass('hide');
            $('#c_'+row_id).parent('.inner').removeClass('hide');
            $('#add-child-row').removeClass('hide');
            $('.fill-measures .tip').removeClass('hide');
        }
        if($(this).find('.priority').val()) {
            $('.title-1 #prio-title').html('(<span class="cl">'+$(this).find('.priority').val()+'</span>)');
        } else {
            $('.title-1 #prio-title').html('');
        }        
        $('#active-parent').val(row_id);
    });
    
    $('.priority-td .priority').on('change', function() {
        $('#prio-title').html('(<span class="cl">'+$(this).val()+'</span>)');
        return false;
    });
    
    $('.prio-options').on('click',function() {
        $(this).parent().css('border-color','rgb(0, 112, 224)').css('box-shadow','0px 0px 0px 2px #a0d1fa');
        $(this).parent().parent().parent().find('.table-menu').removeClass('hide');
        $('.table-div').scrollLeft(500);
        return false;
    });
}

function addChildListener(parent_row,child_row) {
    $('.measure').on('change', function() {
        var child_table = 'c_'+ parent_row;
        if($(this).parent().parent().parent().parent().attr('id')==child_table && $(this).parent().parent().attr('id')==child_row) {
            var value = $(this).val();
            var ta_id = $(this).attr('id');
            var parent = ta_id.substring(0,ta_id.indexOf('_'));
            
            $('#' + parent + '_measure .add-measure').remove();
            
            updateParentCol({type:'measure',parent:parent});
        }
    });
}

function addBudgetListener(parent_row,child_row) {
    $('#c_'+parent_row + ' #' + child_row +' .budget-val input').on('change', function() {
        var td_id = $(this).parents('.new-col').attr('id');
        var dash_1 = td_id.indexOf('_', 0);
        var dash_2 = td_id.indexOf('_', dash_1+1);
        var dash_3 = td_id.indexOf('_', dash_2+1);
        var parent_id = Number($('#active-parent').val());
        var parent_td_id = (parent_id) + '_' + (Number(td_id.slice(dash_2+1,dash_3))+1) + '_p';
        var base_id = td_id.slice(dash_2+1);
        
        var sum_value=0,cur_value=0;
        
        var cls = '.'+ $(this).attr("class");
        
        var match_id = "#child-" + parent_id + " [id$="+base_id+"]";
        $(match_id).each(function(){
            cur_value = ($(this).find(cls).val()) ? Number($(this).find(cls).val()) : 0;
            sum_value += cur_value;
        });
        
        $('#'+parent_td_id + ' ' + cls).val(sum_value);
    });
    
    
}

function getMaxCol() {
    var col_id, max=0;
    var headers = $('#main-table th');
    headers.each(function(index, value) {
		
    col_id = Number($(this).attr('id'));
        if (col_id > max) {
            max = col_id;
        }
    });
    
    return max+1;
}

