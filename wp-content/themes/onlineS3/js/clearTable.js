
/*
 * clears table data
 * @param {numeric} tbl_id 
 */

var clearTable = function(args) {
    var img_elem = $('#'+args.tbl_id);  // gets image div
    
    var confirm_val = confirm('Are you sure you want to clear the data of the table ?');
    if (confirm_val == true) {
        $(img_elem).find('td input').val('');
    }
    return false;
};
