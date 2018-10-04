
$(document).ready(function(){
    
    $(window).keydown(function(event){
        if(event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });
    
    $('#logged-out').on('click', function() {
        sessionStorage.setItem('logged_out','1');
    });
    
    $('.login').on('click', function() {
        sessionStorage.setItem('logged_out',null);
        sessionStorage.setItem('logged_in',1);
    });
    
    
    var session_cookie = document.cookie;
    
    var menu_clicked;
    if (session_cookie.indexOf(";",session_cookie.indexOf("menu_budget=")+12) > 0) {
        menu_clicked = session_cookie.substring(session_cookie.indexOf("menu_budget=")+12,session_cookie.indexOf(";",session_cookie.indexOf("menu_budget")+12));
    } else {
        menu_clicked = session_cookie.substring(session_cookie.indexOf("menu_budget=")+12);
    }
    
    menu_clicked = (menu_clicked!="about" && menu_clicked!="guide" && menu_clicked!="docs" && menu_clicked!="tool") ? 'about' : menu_clicked;
    
//    var session_cookie = document.cookie;
//    var sep_1 = session_cookie.indexOf("=",session_cookie.indexOf("menu_budget")+1)+1;
//    var sep_2 = (session_cookie.indexOf(";",session_cookie.indexOf("menu_budget"))>0) ? (session_cookie.indexOf(";",session_cookie.indexOf("menu_budget")+1)) : session_cookie.length;
//    
//    
//    
//    var menu_clicked = session_cookie.substring(sep_1,sep_2);
//    menu_clicked = (menu_clicked=="tool") ? ((sessionStorage.getItem('logged_out')=='1') ? "about" : "tool") : menu_clicked;
//    menu_clicked = (menu_clicked!="about" && menu_clicked!="guide" && menu_clicked!="docs" && menu_clicked!="tool") ? 'about' : menu_clicked;
    
    if (menu_clicked=='tool' && sessionStorage.getItem('logged_in')==1) {
        showTutorial();
        sessionStorage.setItem('logged_in',null);
    }
        
    setPage(menu_clicked);
    
    var step_no = sessionStorage.getItem('step_no');
    
    $.validator.addClassRules("is_numeric", {
        number: true
    });
    
    // If IE, display not-support messages
    if (window.navigator.userAgent.indexOf("MSIE") > 0 || window.navigator.userAgent.indexOf("Trident/") > 0) {
        $('.ie-message').removeClass('hide');
        $('.ie-disabled').attr('disabled','disabled');
    }
    
    $('#budget-form').validate({
        submitHandler: function (form) {
            form.submit();
        }
    });
    
    $('#filter_results').on('click',function() {
        sessionStorage.setItem('step_no', 'step-2');
        sessionStorage.setItem('filtered', 1);
    });
    
    $('#benchmarking').on('click',function() {
        sessionStorage.setItem('step_no', 'step-3');
    });
    
    if(step_no=='step-2') {
        setStep('step-2','step-1','auto');
    }
    
    if(step_no=='step-3') {
        setStep('step-3','step-2','auto');
    }
    
    fill_options();
    
    $(".chosen-select").chosen();
    
    $("tr:not(.active) .chosen-select").prop('readonly', 'readonly').trigger("chosen:updated");
    
    $("tr:not(.active) input").on('click',function(){
        $('table.child tr').removeClass('active');
        $(this).parents('tr').addClass('active');
    });
    
    $('.textarea [contenteditable]').on("input",function(){
        $(this).parent().find('textarea').val($(this).html());
    });

    // uncheck other categories
    $('.group-col').on('change', function() {
        
        $('.group-col').not(this).prop('checked', false); 
        $(this).prop('checked', true);
        
        var group_id = $(this).attr('id').substring(6,7);
        
        $('#show-'+group_id).prop('checked', true);
        
        var group_val = $(this).val();
        
        $('.show-col').prop('checked', false);
        $("input[value='"+group_val+"'].show-col").prop('checked', true);
        
        return false;
    });
    
    $('#show-col').on('change', function() {
        if($(this).next().hasClass('show-extra')) {
            $(this).next().removeClass('show-extra').addClass('hide-extra');
            $(this).next().find('span').html('hide extra columns <i class="fa fa-angle-double-left"></i>');
        } else {
            $(this).next().removeClass('hide-extra').addClass('show-extra');
            $(this).next().find('span').html('show extra columns <i class="fa fa-angle-double-right"></i>');
        }
    });
    
    $('.chart-year').on('change', function() {
        $('.chart-year').not(this).prop('checked', false); 
        $(this).prop('checked', true);
    });
    
    $("#main-table tr#1").on('click', function() {
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
            $('#prio-title').html('(<span class="cl">'+$(this).find('.priority').val()+'</span>)');
        } else {
            $('#prio-title').html('');
        }
        
        $('#active-parent').val(row_id);
    });
    
    $(".budget-table.child tr").on('click', function() {
        var row_id = $(this).attr('id');
        $('#active-child').val(row_id);
    });
    
    $('#choose-years').change(function() {
        var current_val = $('#years').val();
        if (!current_val.includes($(this).val())) {
            var val = $('#years').val() + ' ' + $(this).val();
            $('#years').val(val);
            var year = $(this).val();
            var del_id = 'del_'+ year;
            $('table#selected-years tr').append('<td><span>'+ year + '<i class="fa fa-times" id="'+ del_id + '" style="cursor:pointer" title="remove year" onclick="return delCol(\''+year+'\',\''+del_id+'\');"></i>' +'</span></td>');
            return addCol($(this).val());
        }
    });
    
    $('#active-parent').each(function() {
        var current = $(this).val();
        $("#main-table tr#"+current).click()[0];
    });
    
    $('#show_overview').each(function() {
        if ($(this).is(':checked')) {
            $('.parent .extra').removeClass('hide');
            $('.child th.extra, .child td.extra').removeClass('hide');
            $('#show_budget').prop('checked',false);
        } 
    });
    
    $('#show_budget').each(function() {
        if ($(this).is(':checked')) {
            $('.parent .extra').addClass('hide');
            $('.child th.extra, .child td.extra').addClass('hide');
            $('#show_overview').prop('checked',false);
        } 
    });
    
    $('#show_overview').change(function() {
        
        if ($(this).is(':checked')) {
            $('.parent .extra').removeClass('hide');
            $('.child th.extra, .child td.extra').removeClass('hide');
            
            $('.parent .extra').parent().each(function(){
                autoHeight('.parent #'+$(this).attr('id'));
            });
            $('#show_budget').prop('checked',false);
        } else {
            $('.parent .extra').addClass('hide');
            $('.child th.extra, .child td.extra').addClass('hide');
            $('#show_budget').prop('checked',true);
        }
        return false;
    });
    
    $('#show_budget').change(function() {
        if ($(this).is(':checked')) {
            $('.parent .extra').addClass('hide');
            $('.child th.extra, .child td.extra').addClass('hide');
            $('#show_overview').prop('checked',false);
        } else {
            $('.parent .extra').removeClass('hide');
            $('.child th.extra, .child td.extra').removeClass('hide');
            
            $('.parent .extra').parent().each(function(){
                autoHeight('.parent #'+$(this).attr('id'));
            });
            $('#show_overview').prop('checked',true);
        }
        return false;
    });
    
    $('.budget-table.child .chosen-select').attr('disabled', true).trigger("chosen:updated");
    
    $('.section .fa-times').on('click', function() {
        $(this).parent().addClass('hide');
    });
    
    $('textarea.measure').on('change', function() {
        if($(this).parent().parent().parent().parent().attr('id')=='c_1' && $(this).parent().parent().attr('id')=='1') {
            var value = $(this).val();
            var ta_id = $(this).attr('id');
            var parent = ta_id.substring(0,ta_id.indexOf('_'));
            $('#' + parent + '_measure .add-measure').remove();
            $('#' + parent + '_measure p').append(value+'</br>').removeClass('hide');
        }
    });
    
    $('#clear-data').on('click',function(event) {
        event.preventDefault();
        
        swal({
            title: 'Are you sure?',
            text: "All budget data will be removed.",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#ccc',
            confirmButtonText: 'Yes, remove it!'
            }).then(function () {
                $('#form-cleared').val('1');
                $('#years').val('');
                $('#clear-data').unbind('click').click();
            });
    });
    
    $('#data-analysis,#save-data,#publish-data').on('click',function() {
        
        var i=1;
        var prios,measures,budgets;
        prios = $('#main-table tbody tr:not(.budget-val tr)').length;
        
        $('.prio_rows').val(prios);
        $('#main-table tbody tr:not(.budget-val tr)').each(function(){
            measures = $('.made #c_'+i+' tbody tr:not(.budgets tr):not(.budget-val tr)').length;
            $('.measure_rows_'+i).val(measures);
            
            var y=1;
            $('.made #c_'+i+' tbody tr:not(.budgets tr):not(.budget-val tr)').each(function(){
                budgets = $(this).find('.budgets tr:not(.budget-val tr)').length;
                $(this).find('#budget_rows_' + i + '_' + y).val(budgets);
                
                y++;
            });
            i++;
        });
        
        if($(this).attr('id')=='data-analysis') {
            sessionStorage.setItem('step_no', 'step-2');
            sessionStorage.setItem('filtered', 0);
        }
    });
    
    $('.priority-td .priority').on('change', function() {
        $('#prio-title').html('(<span class="cl">'+$(this).val()+'</span>)');
    });
    
    $('div#tool.hide').removeClass('hide').addClass('hide-removed');
    $('.parent tbody tr:not(.budget-val tr)').each(function(){
        autoHeight('#'+$(this).attr('id'));
    });
    $('div#tool.hide-removed').addClass('hide');
    
    $("#analysis-active[value='1']").each(function() {
        $('.step-1 #data-analysis').prop("disabled",false);
    });
    
    $('.parent tr:not(.deleted) .budget-val:not(.hide)').each(function() {
        $('.step-1 #data-analysis').prop("disabled",false);
    });
    
    $('.prio-options').on('click',function(e) {
        e.stopPropagation();
        $(this).parent().css('border-color','rgb(0, 112, 224)').css('box-shadow','0px 0px 0px 2px #a0d1fa');
        $(this).parent().parent().parent().find('.table-menu').removeClass('hide');
        $('.table-div').scrollLeft(500);
    });
    
    $('body,html').click(function(e){
        $('.table-menu').addClass('hide');
        $('.prio-options').parent().css('border-color','#ccc').css('box-shadow','none');
    });
    
    if (localStorage.getItem('show_tutorial')=='1') {
        showTutorial();
        localStorage.setItem('show_tutorial',null);
    }
    
    $('.ms-selectall').on('click', function() {
        if($(this).text().toLowerCase()==='select all') {
            $(this).addClass('selectAll');
        }else {
            $(this).removeClass('selectAll');
        }
    });
    
    var menu_clicked = localStorage.getItem('menu_clicked');
    
    if (menu_clicked=='tool') {
        $('#site-header ul li a').removeClass('active');
        $('.section-page').addClass('hide');
        $('a#tool').addClass('active');
        $('div#tool').removeClass('hidden').removeClass('hide');
        $('#download-guide').addClass('hide');
        $('.base-sidebar').addClass('hide');
        $('.tool-sidebar').removeClass('hide').removeClass('hidden');
        
        sessionStorage.getItem('menu_clicked',null);
        return false;
    }
});

function fillRegions(regions) {
    var xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            
            $('#choose-region').empty();
            
            for (var i=0; i<regions.length; i++) {
                $('#choose-region').append($('<option>', {
                    value: regions[i]['code'],
                    text: regions[i]['code'] + ' - ' + regions[i]['label']
                }));
                $('#choose-region').trigger("chosen:updated");
            }
			
        }
    };
    xmlhttp.open("POST", window.location.href, true);
    xmlhttp.send();
}


var close_popup = function() {
    $('.budget-form').css('display','none');
    
    return false;
};
