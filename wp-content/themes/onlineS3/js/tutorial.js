
jQuery(document).ready(function(){
   
});

function showTutorial() {
        //localStorage.clear();	//NA SVISTEI AUTI I GRAMMI GIA NA STAMATISEI NA VGAINEI KATHE FORA
        var isshow = localStorage.getItem('budgeting_shown');
        
        if (isshow==null) {
            
            swal.setDefaults({
                confirmButtonText: 'Next &rarr;',
                showCancelButton: true,
                animation: false,
                progressSteps: ['1','2', '3', '4', '5', '6', '7', '8']
            });

            var steps = [
                {
                    title: 'Definition of the region',
                    text: 'In this section, you have to select the region that RIS financial plan refers to. Initially you have to select the NUTS level (0/1/2) which you want to use for your selection (e.g. NUTS 0 refers to country level).',
                    onOpen: function (){
                        $('.section.fill-region').addClass('highlight');
                    },
                    onClose: function (){
                        $('.section.fill-region').removeClass('highlight');
                    }
                },
                {
                    title: 'Years for budgeting',
                    text: 'In this section, you have to choose the years for which you want to elaborate the RIS3 financial plan. All the selected years will appear in the budgeting tables.',
                    onOpen: function (){
                        $('.section.fill-years').addClass('highlight');
                    },
                    onClose: function (){
                        $('.section.fill-years').removeClass('highlight');
                    }
                },
                {
                    title: 'Definition of priorities',
                    text: 'In the Priorities section, you should define the priorities of your RIS3 strategy. You can enter a short description for each new priority and generate a nested table built up by measures to add your financial data, displayed in the next section.',
                    onOpen: function (){
                        $('.section.fill-prios').addClass('highlight');
                    },
                    onClose: function (){
                        $('.section.fill-prios').removeClass('highlight');
                    }
                },
                {
                    title: 'Measures per Priority',
                    text: 'In the Measures section, you can describe the measures under each priority and add budget information. You can provide information regarding the programme, the thematic objective, the intervention field, the form of finance and the funding source. The budget values should be provided in terms of the planned, committed and spent amount of money.',
                    onOpen: function (){
                        $('.section.fill-measures').addClass('highlight');
                        $('html, body').scrollTop($('.section.fill-measures').offset().top);
                    },
                    onClose: function (){
                        $('.section.fill-measures').removeClass('highlight');
                    }
                },
                {
                    title: 'Data toolbox',
                    text: 'You can save, clear, download or publish the data. Data is downloaded in xls format, while published data will be available in all registered users of this application.',
                    onOpen: function (){
                        $('.budget-menu.tools').addClass('highlight');
                        $('html, body').scrollTop($('.budget-menu.tools').offset().top);
                    },
                    onClose: function (){
                        $('.budget-menu.tools').removeClass('highlight');
                    }
                },
                {
                    title: 'Additional info',
                    text: 'You can see only budget data or show additional info regarding (i) the thematic objective, (ii) the intervention field, (iii) the form of finance and (iv) the funding source, and the comments for priorities and measures.',
                    onOpen: function (){
                        $('.budget-menu.show-all').addClass('highlight');
                    },
                    onClose: function (){
                        $('.budget-menu.show-all').removeClass('highlight');
                    }
                },
                {
                    title: 'Data Analysis',
                    text: 'In data analysis step, you can group and filter budget data by the categories provided and an overall overview of budgetary planning will be generated. The results can be downloaded in xls or word format.',
                    onOpen: function (){
                        $('.step-2.choice').addClass('highlight');
                    },
                    onClose: function (){
                        $('.step-2.choice').removeClass('highlight');
                    }
                },
                {
                    title: 'Budget Benchmarking',
                    text: 'In this step, you can have access to all the published data by other regions and perform a comparative analysis between different regions.',
                    onOpen: function (){
                        $('.step-3.choice').addClass('highlight');
                    },
                    onClose: function (){
                        $('.step-3.choice').removeClass('highlight');
                    }
                }
            ];

            swal.queue(steps).then(function (result) {
            swal.resetDefaults();
            swal({
                title: 'Ready now!',
                confirmButtonText: 'Start',
                showCancelButton: false,
                onOpen: function (){
                    $('.swal2-confirm').after("<div class='chk-primary hide-tutorial'><input id='hide-check' class='test' type='checkbox'><label for='hide-check'>Do not show tutorial again</label></div>");
                    hideTutorial();
                }
            });
            }, function () {
                swal.resetDefaults();
            });
        }
    }

function hideTutorial() {
    $('#hide-check').change(function() {
        if ($(this).is(':checked')) {
            localStorage.setItem('budgeting_shown', 1);
        } else {
            localStorage.setItem('budgeting_shown', null);
        }
    });
}