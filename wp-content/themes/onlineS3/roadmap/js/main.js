
var selected_apps=[];

var steps = ['mapping','identify_actors','engage','co_design','monitor_assess'];

var tools = ['related_analysis','scientific_profile','focus_group','special_indexes',
            'vision_sharing','infra_mapping','clusters','stakeholder','collabo_vision',
            'debate_glance','action_plan','open_repo','balanced_score','satisfy_survey'];

var steps_details = {
        'mapping': {title:"Mapping", 
                    text:"The mapping exercise aims at the identification of the region’s position within the Global value chain…", 
                    image:"img/mapping.png", image_width:'60', image_left:'37%', image_top:'15%'},
        'identify_actors': {title:"Identification of actors", text:"The identification of actors…", 
                    image:"img/identify_actors.jpg", image_width:'60', image_left:'37%', image_top:'22%'},
        'engage': {title:"Actors engagement", text:"The mapping exercise aims at the identification of the region’s position within the Global value chain…", 
                    image:"img/engage.png", image_width:'60', image_left:'38%', image_top:'18%'},
        'co_design': {title:"Project co-desing", text:"The mapping exercise aims at the identification of the region’s position within the Global value chain…", 
                    image:"img/co_design.jpg", image_width:'114', image_left:'26%', image_top:'18%'},
        'monitor_assess': {title:"Implementation monitoring assessment", text:"The mapping exercise aims at the identification of the region’s position within the Global value chain…", 
                    image:"img/assess.png", image_width:'90', image_left:'28%', image_top:'12%'}
    };
    
var tools_details = {
    'scientific_profile': { parent:"mapping",
                            title:"Regional Scientific Profile", 
                            text:"The EDP focus groups application provides a content management system that facilitates the organisation of EDP group meetings.", 
                            url:"http://scientificprofile.s3platform.eu/"},
    'focus_group': { parent:"mapping",
                            title:"EDP Focus groups", 
                            text:"EDP Focus groups", 
                            url:"http://edp.s3platform.eu/"},
    'special_indexes': { parent:"mapping",
                            title:"Specialization indexes", 
                            text:"Specialization indexes", 
                            url:"http://specialisation.s3platform.eu/"},
    'related_analysis': { parent:"mapping",
                            title:"Related varieted analysis", 
                            text:"Related varieted analysis", 
                            url:"http://relatedvariety.s3platform.eu/"},
                        
    'vision_sharing': { parent:"identify_actors",
                            title:"Vision sharing", 
                            text:"Vision sharing", 
                            url:"http://visiongraphics.s3platform.eu/"},
                        
    'infra_mapping': { parent:"identify_actors",
                            title:"Research infrastructure mapping", 
                            text:"Research infrastructure mapping", 
                            url:"http://rimapping.s3platform.eu/"},
                        
    'clusters': { parent:"identify_actors",
                            title:"Clusters and innovation ecosystems", 
                            text:"Clusters and innovation ecosystems", 
                            url:"http://ecosystemsmapping.s3platform.eu/"},
                        
    'stakeholder': { parent:"engage",
                            title:"Stakeholder engagement", 
                            text:"Stakeholder engagement", 
                            url:"http://engagement.s3platform.eu/"},
                        
    'collabo_vision': { parent:"engage",
                            title:"Collaborative vision building", 
                            text:"Collaborative vision building", 
                            url:"http://scenarios.s3platform.eu/"},
                        
    'debate_glance': { parent:"engage",
                            title:"Debate at a glance", 
                            text:"Debate at a glance", 
                            url:"http://debateoverview.s3platform.eu/"},
                        
    'action_plan': { parent:"co_design",
                            title:"Action plan co-design", 
                            text:"Action plan co-design", 
                            url:"http://actionplan.s3platform.eu/"},
                        
    'open_repo': { parent:"co_design",
                            title:"Open data repository", 
                            text:"Open data repository", 
                            url:"http://li1088-54.members.linode.com:8082/opendata/"},
                        
    'balanced_score': { parent:"monitor_assess",
                            title:"Balanced scorecards", 
                            text:"Balanced scorecards", 
                            url:"http://li1088-54.members.linode.com:8082/bscapp/"},
                        
    'satisfy_survey': { parent:"monitor_assess",
                        title:"Stakeholder satisfaction survey", 
                            text:"Stakeholder satisfaction survey", 
                            url:"http://satisfactionsurvey.s3platform.eu/"}
};
            
String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.split(search).join(replacement);
};

$(document).ready(function(){
    
    $('.road-on').on('click', function() {
        $('.road-on').removeClass('active');
        $(this).addClass('active');
    });
    
    $('#run-road').on('click', function() {
        $('.large-circle').addClass('active');
        $('.info-container.road').removeClass('hide');
        $('.info-container.examples').addClass('hide');
        $('.graph').find('*').css('opacity','1').css('cursor','pointer');
        $('html, body').animate({
            scrollTop: $('.graph').offset().top
        }, 1000);
        $('#use-roadmap').attr('disabled','disabled');
        $('#see-example').attr('disabled','disabled');
        $(this).attr('disabled','disabled');

    });
    
    $('#use-roadmap').on('click', function() {
        $('.graph').find('.large-circle').removeClass('active');
        $('.info-container.road').removeClass('hide');
        $('.info-container.examples').addClass('hide');
        $('.graph').find('*').css('opacity','1').css('cursor','pointer');
        
        $('html, body').animate({
            scrollTop: $('.graph').offset().top
        }, 1000);
    });
    
    $('#see-example, .road-example').on('click', function() {
        $('.graph').find('.large-circle').removeClass('active');
        if($(this).attr('id')=='see-example') {
            setExample('example_1');
        } else {
            setExample($(this).attr('id'));
        }
        
        $('.info-container.road').addClass('hide');
        $('.info-container.examples').removeClass('hide');
        
        $('html, body').animate({
            scrollTop: $('.graph').offset().top
        }, 1000);
        
    });
});

function runRoad() {
    
    $('.graph').find('.large-circle, .label-container, .arrow, .step-info, .app-info').fadeOut(1);
    $('.step-info, .app-info').animate({'opacity': 0}, 1);
    
    var delay=0, step_delay=1500, tools_delay=2000, app_delay=2500, arrow_delay=1500;

    delay += delay;
    
    
    $('.small-circle, .tool-label').removeClass('active');
    
    $('#'+steps[0]).delay(delay).fadeIn(250);
    $('.label-container.'+steps[0]).delay(delay).fadeIn(250);
    $('#'+steps[0]).delay(0).queue(function(){setStep(steps[0],'','','','',true);});
    
    delay += tools_delay;
    
    setTimeout(function() {
        setApp(tools[0],true);
    }, delay);
    
    delay += app_delay;
    
    setTimeout(function() {
        setApp(tools[1],true);
    }, delay);
    
    delay += app_delay;
    
    setTimeout(function() {
        setApp(tools[2],true);
    }, delay);
    
    delay += app_delay;
    
    setTimeout(function() {
        setApp(tools[3],true);
    }, delay);
    
    delay += arrow_delay;
    
    $('.arrow.'+steps[0]).delay(delay).fadeIn();
    
    delay += step_delay;
    
    $('.large-circle').removeClass('active');
    $('#'+steps[1]).addClass('active');
    $('.large-circle#'+steps[1]).delay(delay).fadeIn(250);
    $('.label-container.'+steps[1]).delay(delay).fadeIn(250);
    $('#'+steps[1]).delay(0).queue(function(){
        setStep(steps[1],'','','','',true);
    });
    
    tools_delay = 1.6 * tools_delay;
    
    delay += app_delay;
    setTimeout(function() {
        setApp(tools[4],true);
    }, delay);
    
    delay += app_delay;
    setTimeout(function() {
        setApp(tools[5],true);
    }, delay);
    
    delay += app_delay;
    setTimeout(function() {
        setApp(tools[6],true);
    }, delay);
    
    delay += arrow_delay;
    
    $('.arrow.'+steps[1]).delay(delay).fadeIn();
    
    delay += step_delay;
    
    $('.large-circle').removeClass('active');
    $('#'+steps[2]).addClass('active');
    $('.large-circle#'+steps[2]).delay(delay).fadeIn(250);
    $('.label-container.'+steps[2]).delay(delay).fadeIn(250);
    $('#'+steps[2]).delay(0).queue(function(){
        setStep(steps[2],'','','','',true);
    });
    
    tools_delay = 2.4 * tools_delay;
    
    delay += app_delay;
    setTimeout(function() {
        setApp(tools[7],true);
    }, delay);
    
    delay += app_delay;
    setTimeout(function() {
        setApp(tools[8],true);
    }, delay);
    
    delay += app_delay;
    setTimeout(function() {
        setApp(tools[9],true);
    }, delay);
    
    delay += arrow_delay;
    
    $('.arrow.'+steps[2]).delay(delay).fadeIn();
    
    delay += step_delay;
    
    
    $('#'+steps[3]).addClass('active');
    $('.large-circle#'+steps[3]).delay(delay).fadeIn(250);
    $('.label-container.'+steps[3]).delay(delay).fadeIn(250);
    $('#'+steps[3]).delay(0).queue(function(){
        setStep(steps[3],'','','','',true);
    });
    
    delay += app_delay;
    setTimeout(function() {
        setApp(tools[10],true);
    }, delay);
    
    delay += app_delay;
    setTimeout(function() {
        setApp(tools[11],true);
    }, delay);
    
    delay += arrow_delay;
    
    $('.arrow.'+steps[3]).delay(delay).fadeIn();
    
    delay += step_delay;
    
    $('#'+steps[4]).addClass('active');
    $('.large-circle#'+steps[4]).delay(delay).fadeIn(250);
    $('.label-container.'+steps[4]).delay(delay).fadeIn(250);
    $('#'+steps[4]).delay(0).queue(function(){
        setStep(steps[4],'','','','',true);}
    );
    
    tools_delay = 4 * tools_delay;
    
    delay += app_delay;
    setTimeout(function() {
        setApp(tools[12],true);
    }, delay);
    
    delay += app_delay;
    setTimeout(function() {
        setApp(tools[13],true);
    }, delay);
    
    $('#use-roadmap').delay(delay).queue(function(){
        $('#use-roadmap').attr('disabled',false);
        $('#see-example').attr('disabled',false);
        $('#run-road').attr('disabled',false);
    });
    
    return false;
}

function getAppsByStep(step_id) {
    var app,step,appsByStep=[],i=0;
    
    Object.keys(tools).forEach(function (key) {
        app = tools[key];
        step = app['parent'];
        if(step==step_id) {
            appsByStep[i++]=key;
        }
    });
    
    return appsByStep;
}

$.fn.scrollView = function () {
  return this.each(function () { 
    $('html, body').animate({
      scrollTop: $(this).offset().top
    }, 1000);
  });
}
