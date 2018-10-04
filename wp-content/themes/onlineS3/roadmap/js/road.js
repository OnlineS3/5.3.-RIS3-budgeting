

$(document).ready(function(){

    $('.enabled .large-circle').on('click', function() {
        var circle_id = $(this).attr('id');
        setStep(circle_id);
        
        return false;
    });
    
    $('.enabled .small-circle, .enabled .tool-label').on('click', function() {
        var classes = $(this).attr('class');
        var tool = classes.replaceAll("tool-label", "").replaceAll("small-circle", "").replaceAll("hovered", "").replaceAll(" ", "");
        
        setApp(tool);
        
        return false;
    });
    
    $('.enabled .small-circle').hover(function() {
        var classes = $(this).attr('class');
        var tool = classes.replaceAll("tool-label", "").replaceAll("small-circle", "").replaceAll(" ", ""); 
        $('.tool-label').removeClass('hovered');
        $('.tool-label.'+tool).addClass('hovered');
    });
});

function setStep(circle_id,tool='',app_title='',app_text='',app_url='',is_demo=false) {
        if ($('#current_step').val()==circle_id) {
            return false;
        }
    
        var step_title = steps_details[circle_id]['title'];
        var step_text = steps_details[circle_id]['text'];
        var step_image = steps_details[circle_id]['image'];
        var image_width = steps_details[circle_id]['image_width'];
        var image_left = steps_details[circle_id]['image_left'];
        var image_top = steps_details[circle_id]['image_top'];
        
        $(".step-info").animate({'opacity': 0}, 250,function() {
            $('.step-title').text(step_title);
            $('.step-text').text(step_text);
            $('.step-image').attr('src',step_image);
            $('.step-image').attr('width',image_width);
            $('.step-image').css('margin-left',image_left);
            $('.step-image').css('margin-top',image_top);
            
            if (tool!='') {
                $("hr").removeClass('hide');
            } else {
                $("hr").addClass('hide');
            }
            
            app_title = (app_title) ? app_title : '';
            app_text = (app_text) ? app_text : '';
            app_url = (app_url) ? app_url : '';
            
            $('.app-label').text(app_title);
            $('.app-text').text(app_text);
            $('.app-url').text('');
            if (tool) {
                $(".app-url").html('Visit the app');
            }
        }).animate({'opacity': 1}, 250);
        
        $('#current_step').val(circle_id);
       
        if (!is_demo) {
            if (tool) {
                $('.large-circle, .small-circle:not(.'+tool+'), .tool-label:not(.'+tool+')').removeClass('active');
            } else {
                $('.large-circle, .small-circle, .tool-label').removeClass('active');
            }
            
            $('.tool-label').removeClass('hovered');
            $('.large-circle:not(#'+ circle_id +' .tool-label), .large-circle:not(#'+ circle_id +' .small-circle)').removeClass('active').removeClass('hovered');
            $('#'+circle_id).addClass('active');
        }
        
        return false;
    }
    
    function setApp(tool,is_demo=false) {
        var app_title = tools_details[tool]['title'];
        var app_text = tools_details[tool]['text'];
        var app_url = tools_details[tool]['url'];
        
        if (!$('#change-view').hasClass('road-on')) {
            if (selected_apps.indexOf(tool)) {
                $('.example-text a').removeClass('link-active');
                $('.example-text .' + tool).addClass('link-active');
            } else {
                return false;
            }
        }
        
        $("hr").removeClass('hide');
        
        var parent_id = $('.small-circle.'+tool).parent().attr('id');
        
        if ($('#current_step').val()!=parent_id && !is_demo) {
            setStep(parent_id, tool, app_title, app_text, app_url);
        } else {
            $(".app-info").animate({'opacity': 0}, 250,function() {
                
                $(".app-label").html(app_title);
                $(".app-text").html(app_text);
                $(".app-url").html('Visit the app');
                $('.tool-label, .small-circle').removeClass('active').removeClass('hovered');
        
                $('.tool-label.'+tool).addClass('active');
                $('.small-circle.'+tool).addClass('active');
            }).animate({'opacity': 1}, 250);
        }
        $('#current_step').val(parent_id);
        
        $('.app-url').attr('href',app_url);
        
        $('.tool-label, .small-circle').removeClass('active').removeClass('hovered');

        $('.tool-label.'+tool).addClass('active');
        $('.small-circle.'+tool).addClass('active');
        
    }