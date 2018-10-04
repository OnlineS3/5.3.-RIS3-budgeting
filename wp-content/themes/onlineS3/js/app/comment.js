
var set_comment = function(prio_id) {
    $('.comment-form.popup-box').css('display','block');
    
    var current = $('#' + prio_id + '-comment').val();
    
    $('#comment').val(current);
    $('#comment').get(0).focus();
    
    $('#prio-id').val(prio_id);
};

var return_comment = function() {
    var comment = $('#comment').val();
    
    var parent_comment = '#' + $('#prio-id').val() + '-comment'; 
    
    $(parent_comment).val(comment);
    
    $(parent_comment).next('.fa').addClass('completed');
    
    $(parent_comment).parent().find('.load-measure').addClass('hide');
    $(parent_comment).removeClass('hide');
    
    $('.popup-box').css('display','none');
    
    return false;
};

var close_comment = function() {
    $('.comment-form.popup-box').css('display','none');
    
    return false;
};
