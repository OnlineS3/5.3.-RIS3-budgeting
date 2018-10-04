/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function fill_options() {
    
    $('.multi-filters#choose-prio').multiselect({
        search: true,
        selectAll: true,
        maxWidth: 100,
        placeholder: 'choose priority'
    });
    
    $('.multi-filters#choose-programme').multiselect({
        search: true,
        selectAll: true,
        maxWidth: 200,
        placeholder: 'choose program'
    });
    
    $('.multi-filters#choose-object').multiselect({
        search: true,
        selectAll: true,
        maxWidth: 200,
        placeholder: 'choose objective'
    });
    
    $('.multi-filters#choose-inter').multiselect({
        search: true,
        selectAll: true,
        maxWidth: 200,
        placeholder: 'choose intervention'
    });
    
    $('.multi-filters#choose-finance').multiselect({
        search: true,
        selectAll: true,
        maxWidth: 200,
        placeholder: 'choose finance'
    });
    
    $('.multi-filters#choose-year').multiselect({
        search: true,
        selectAll: true,
        maxWidth: 150,
        placeholder: 'choose year'
    });
    
    
    $('.multi-filters#choose-funding').multiselect({
        search: true,
        selectAll: true,
        maxWidth: 200,
        placeholder: 'choose funding'
    });
    
    $('.multi-filters#chart-region').multiselect({
        search: true,
        selectAll: true,
        maxWidth: 100,
        placeholder: 'choose regions'
    });
    
    $('.multi-filters#chart-year').multiselect({
        search: false,
        selectAll: false,
        maxWidth: 100,
        placeholder: 'choose years'
    });
    
    return false;
}

var clearFilters = function(args) {
    
    alert('clearFilters');
    
    $('.group-col').prop('checked', false);
    $('.show-col').prop('checked', false);
    
    $('#group-0').prop('checked', true);
    $('#show-0').prop('checked', true);
    
    $('.ms-selectall').each(function(){
	if($(this).text()==='Select all'){
            $(this).click();
	}
    });
    
    return false;
};