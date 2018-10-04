
function generateMain(table_id) {
    var tbl_data=[[]], cell_id, cell_content, year;
    var rows = $('#' + table_id + ' tbody tr:not(.budget-val tr)').length;
    
    var cols = ['priority','measure','programme','object','inter','finance','funding','comment'];
    
    var headers = ['RIS3 priority','Measures','Programme','Objective','Intervention','Form of finance','Funding source','Comment'];
    
    var i=0;
    $('#main-table th.new-col:not(.deleted)').each(function(){
        year = $(this).attr('id');
        var cols_len = headers.length;
        headers[cols_len++] = year + ' - planned value';
        headers[cols_len++] = year + ' - committed value';
        headers[cols_len++] = year + ' - spent value';
        i++;
    });
    
    var tbl_row, row_counter=0;
    for(var i=0;i<rows;i++) {
        if(!$('#' + (i+1)).hasClass('deleted')) {
            tbl_row = [];
            for(var j=0;j<cols.length;j++) {
                cell_id = '#' + (i+1) + '_' + cols[j];

                if($(cell_id).hasClass('list')){
                    cell_content = $(cell_id).find('.ellipse').attr('id');
                    tbl_row[j] = getText(cell_content);
                } else {
                    tbl_row[j] = $(cell_id).find('input,textarea').val();
                } 
            }

            $('#' + table_id + ' th.new-col:not(.deleted)').each(function(){
                year = $(this).attr('id');

                tbl_row[j++] = $('#' + (i+1) + '_' + year + '_planned').val();
                tbl_row[j++] = $('#' + (i+1) + '_' + year + '_commit').val();
                tbl_row[j++] = $('#' + (i+1) + '_' + year + '_spent').val();

            });

            tbl_data[row_counter++] = tbl_row;
        }
    }
    
    tbl_data.unshift(headers);
    
    return tbl_data;
}

function generateChild(parent_id) {
    var tbl_data=[[]],tbl_row=[],years=[],cell_id,measure,year;
    
    var cols = ['measure','programme','object','inter','finance','funding'];
    var headers = ['Measure','Programme','Objective','Intervention','Form of finance','Funding source'];
    
    var i=0;
    $('#c_' + parent_id + ' th.new-col').each(function(){
        years[i] = $(this).text();
        var cols_len = headers.length;
        headers[cols_len++] = years[i] + ' - planned value';
        headers[cols_len++] = years[i] + ' - committed value';
        headers[cols_len++] = years[i] + ' - spent value';
        i++;
    });
    
    var measure_row=1, tbl_count=0;
    $('#c_' + parent_id + ' tbody tr:not(.budgets tr):not(.budget-val tr)').each(function() {
        measure = $(this).find('#'+parent_id+'_'+measure_row+'_measure').val();
        var budget_row = 1;
        tbl_row = [];
        if($(this).find('.budgets tr:not(.budget-val tr):not(.deleted)').length>0) {
            $(this).find('.budgets tr:not(.budget-val tr):not(.deleted)').each(function() {
                tbl_row = [];
                tbl_row[0] = measure;
                for(var j=1;j<cols.length;j++) {
                    cell_id = '#' + parent_id + '_' + measure_row + '_' + budget_row + '_' + cols[j];

                    if($(cell_id).is('select')){
                        tbl_row[j] = $(cell_id).find("option:selected").text();
                    } else if ($(cell_id).is('input')) {
                        tbl_row[j] = $(cell_id).val();
                    } 
                }

                $('#c_' + parent_id + ' th.new-col').each(function() {
                    year = $(this).text();

                    tbl_row[j++] = $('#' + parent_id + '_' + measure_row + '_' + budget_row + '_' + year + '_planned').val();
                    tbl_row[j++] = $('#' + parent_id + '_' +  measure_row + '_' + budget_row + '_' + year + '_commit').val();
                    tbl_row[j++] = $('#' + parent_id + '_' + measure_row + '_' + budget_row + '_' + year + '_spent').val();
                });

                tbl_data[tbl_count++] = tbl_row;
                budget_row++;
            });
        } else {
            tbl_row[0] = measure;
            tbl_data[tbl_count++] = tbl_row;
        }
        
        measure_row++;
    });
    
    tbl_data.unshift(headers);
    
    return tbl_data;
}

function generateMonitoringFile(filename) {
    var tbl_data=[],tbl_row=[],years=[];
    var tbl_count=0,mea_count=1,budget_count,measure,year,col_count,programme,sum_planned=0,max_year='0';
    
    var headers = ['a_index_code','series_unit','action_axis','action_axis_title','programme_code','programme_title','title','target_value','target_year'];
    
    var i=0;
    $('table#selected-years tr td span').each(function(){
        years[i] = $(this).text();
        var cols_len = headers.length;
        headers[cols_len++] = 'Y' + years[i];
        if (Number(years[i]) > Number(max_year)) {
            max_year = years[i];
        }
        i++;
    });
    
    var rows = $('#main-table tbody tr:not(.budget-val tr)').length;
    for(var i=1;i<=rows;i++) {
        mea_count=1;
        $('#c_' + i + ' tbody tr:not(.budgets tr):not(.budget-val tr)').each(function() {
            measure = $(this).find('#'+i+'_'+mea_count+'_measure').val();
            
            
            if($(this).find('.budgets tr:not(.budget-val tr):not(.deleted)').length>0) {
                budget_count = 1;
                $(this).find('.budgets tr:not(.budget-val tr):not(.deleted)').each(function() {
                    programme = $('#' + i + '_' + mea_count + '_' + budget_count + '_programme').val();
                    
                    col_count=0;
                    tbl_row=[];
                    sum_planned = 0;
                    tbl_row[0] = 'budget_' + Number(tbl_count+1);
                    tbl_row[1] = 'EUR';
                    tbl_row[2] = 'measure_' + mea_count;
                    tbl_row[3] = measure;
                    tbl_row[4] = 'programme_' + Number(tbl_count+1);
                    tbl_row[5] = programme;
                    tbl_row[6] = 'budget_' + Number(tbl_count+1);
                    
                    
                    col_count = 9;
                    $('#c_' + i + ' th.new-col').each(function() {
                        year = $(this).text();
                        tbl_row[col_count++] = $('#' + i + '_' + mea_count + '_' + budget_count + '_' + year + '_spent').val();
                        sum_planned += Number($('#' + i + '_' + mea_count + '_' + budget_count + '_' + year + '_planned').val());
                    });
                    
                    tbl_row[7] = sum_planned;
                    tbl_row[8] = max_year;
                    
                    tbl_data[tbl_count++] = tbl_row;
                    budget_count++;
                });
            }
            mea_count++;
        });
    }
    tbl_data.unshift(headers);
    export2csv({'filename':filename,'data':tbl_data});
    return false;
}

function getText(list) {
    var ul_text="", li_text;
    var ul_items = $('#'+list).find('li');
    var ul_length = $('#'+list).find('li').length;
    
    var i=0;
    ul_items.each(function() {
        li_text = $(this).html();
        ul_text += (i===ul_length-1) ? li_text : (li_text + ' / ');
        i++;
    });
    
    return ul_text;
}

function Prio() {
}

function exportMainXLS(filename) {
    var tbl_data=new Prio();
    var sheet;
    var main_tbl=[],child_tbl=[],sheets=[];
    main_tbl = generateMain('main-table');
    
    tbl_data['main'] = main_tbl;
    
    var rows = $('#main-table tr:not(.budget-val tr)').length;
    for(var i=0;i<rows-1;i++) {
        if ($('#c_'+(i+1)).parent().hasClass('made') && (!$('#c_'+(i+1)).hasClass('deleted'))) {
            child_tbl = generateChild(i+1);
            sheet=$('#'+(i+1)+'_priority').find('textarea').val();
            
            if(sheet.length===0 || sheets.indexOf(sheet)) {
                sheet = 'Priority ' + String(i+1);
            }
            
            sheets[i] = sheet;
            tbl_data[sheet] = child_tbl;
        }
    }
    
    export2xlsMultiple({data:tbl_data,filename:filename});
    
    return false;
}

function exportSummaryXLS(filename) {
    var row_data=[],tbl_data=[],cell,cell_value,year;
    
    var i=0,j=0;
    $('#summary tr:not(.budget-vals tr):not(.budget-headers tr)').each(function(){
        row_data=[];
        j=0;
        $('#summary th:not(.header-div)').each(function() {
            cell = $('#'+i+'_'+j);
            if(cell.parent().parent().parent().hasClass('budget-headers')) {
                year = cell.parent().parent().parent().find('.year-header').html();
                cell_value = year + ' - ' + cell.html();
            } else {
                cell_value = (cell=='undefined') ? '' : cell.html();
            } 
            
            row_data[j++] = cell_value;
        });
        
        tbl_data[i++] = row_data;
    });
    
    export2xls({data:tbl_data,filename:filename});
    
    return false;
}