


var examples = {
    'example_1': {
        'title': 'Roadmap example 1',
        'text': 'Roadmap example 1',
        'steps': ['mapping','identify_actors'],
        'apps': ['related_analysis', 'special_indexes', 'scientific_profile', 'clusters']
    },
    'example_2': {
        'title': 'How can I identify my region in the global value chain?',
        'text': 'First it is important to sketch the <a class="scientific_profile" href="#">regional scientific profile</a>,\n\
                the existing <a class="clusters" href="#">clusters</a> and the <a class="special_indexes" href="#">specialization of the region</a> and \n\
                also to perform a <a class="related_analysis" href="#">related variety analysis</a>…',
        'steps': ['mapping','identify_actors'],
        'apps': ['related_analysis', 'special_indexes', 'scientific_profile', 'clusters']
    },
    'example_3': {
        'title': 'Roadmap example 3',
        'text': '',
        'steps': ['mapping','identify_actors'],
        'apps': ['related_analysis', 'special_indexes', 'scientific_profile', 'clusters']
    },
    'example_4': {
        'title': 'Roadmap...',
        'text': '',
        'steps': ['identify_actors','engage','monitor_assess'],
        'apps': ['infra_mapping', 'stakeholder', 'collabo_vision', 'balanced_score']
    }
};

function setExample(example) {
    selected_steps = [];
    selected_apps = [];
    
    var example_title = examples[example]['title'];
    var example_text = examples[example]['text'];
    selected_steps = examples[example]['steps'];
    selected_apps = examples[example]['apps'];
    
    
    $('html, body').animate({
        scrollTop: $('.graph').offset().top
    }, 1000);
    
    $('.examples-list ul li').removeClass('active');
    $('#'+example).parent().addClass('active');
    
    $('.example-title').text(example_title);
    $('.example-text').html(example_text);
    
    $('.graph').find('*').css('opacity','.4').css('cursor','default');
    
    for(var i=0;i<selected_steps.length;i++) {
        $('#'+selected_steps[i]).css('opacity','1');
        $('.'+selected_steps[i]).css('opacity','1');
    }
    
    for(var i=0;i<selected_apps.length;i++) {
        $('.'+selected_apps[i]).css('opacity','1');
        $('.'+selected_apps[i]).css('cursor','pointer');
    }
    
    
}