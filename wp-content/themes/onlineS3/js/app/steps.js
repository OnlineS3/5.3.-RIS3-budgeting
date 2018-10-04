
function setStep(new_step,current_step,type) {
    
    $('.content').addClass('hide');
    $('.btn-section').addClass('hide');
    $('.choice').removeClass('active');
    $('.choice.'+current_step).addClass('done').removeClass('init');
    
    if (new_step=='step-3') {
        $('.choice:not(.step-3)').addClass('done').removeClass('init');
    }
    
    $('.choice').find('p').addClass('hide');
    $('.choice').next('.tooltiptext').removeClass('hide');
    
    $('.content.'+new_step).removeClass('hide');
    $('.choice.'+new_step).removeClass('init').addClass('active');
    $('.choice.'+new_step).find('p').removeClass('hide');
    $('.choice.'+new_step).next('.tooltiptext').addClass('hide');
    $('.budget-menu').addClass('hide');
    $('.btn-section.'+new_step).removeClass('hide');
    
    if (new_step=='step-2') {
        if (type=='proceed') {
            $('#show-0').prop('checked',true);
        }
        $('.budget-menu.step-2').removeClass('hide');
    }
    
    if (new_step=='step-2' && sessionStorage.getItem('filtered') == 1) {
        $('.step-2.btn-section').removeClass('hide');
    }
    
    if (new_step=='step-1') {
        $('.btn-section.'+new_step).removeClass('hide');
        $('.budget-menu.step-1').removeClass('hide');
    }
    
    sessionStorage.setItem('step_no', new_step);
    
        
    //if (sessionStorage.getItem('filtered') == "0") {
       // fill_options();
    //}
    
    window.scrollTo(0, 0);
    
    return false;
}