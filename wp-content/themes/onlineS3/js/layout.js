/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
    $('.site-header-main').append($('#site-header'));
    
    $('footer').append($('#site-footer'));
            
    $("#site-header .menu ul li a, .access-tool").click(function() {
        var page_id = ($(this).attr('id')=='tool-btn') ? 'tool' : $(this).attr('id');
        setPage(page_id);
    });

    $('#site-header .menu ul li a, .access-tool').mousedown(function(event) {
        if (event.which == 3) {
            document.cookie = 'menu_budget='+(($(this).attr('id')=='tool-btn') ? 'tool' : $(this).attr('id'));
        }
    });
    
    $("a#tool, a#tool-btn").click(function() {
        showTutorial();
    });
});

function setPage(page_id) {
    $('a#' + page_id).parents().find('#site-header ul li a').removeClass('active');
    $('a#' + page_id).addClass('active');
    document.cookie = 'menu_budget='+page_id;
    
    if (page_id=='tool') {
        $('.tool-sidebar').removeClass('hide');
        $('.base-sidebar').addClass('hide');
    } else {
        $('.tool-sidebar').addClass('hide');
        $('.base-sidebar').removeClass('hide');
    }
    $('.section-page').addClass('hide');
    $('.section-page#' + page_id).removeClass('hide');
    
    return false;
}