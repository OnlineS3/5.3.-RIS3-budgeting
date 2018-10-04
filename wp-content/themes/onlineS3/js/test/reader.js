/**
 * Change window url without reloading the window
 */
function changeWindowUrl (href) {
    'use strict';

    //get the link location that was clicked
    var pageUrl = href;
    if (pageUrl.length > 0) {
        pageUrl = pageUrl.toLowerCase();
    }

    //to change the browser URL to the given link location
    if (pageUrl !== window.location) {
        if (history.pushState) {
            if (pageUrl.length > 0) {
                if (pageUrl.indexOf('#') === -1) {
                    pageUrl = '#' + pageUrl;
                }

                window.history.pushState({path: pageUrl}, '', pageUrl);
            } else {
                window.history.pushState('', document.title, window.location.pathname);
            }
        } else {
            window.location.hash = pageUrl;
        }
    }
}

/**
 * Move reader content
 */

function moveReaderContent (id) {

    'use strict';

    var headingText = '', found = false, returnVal, ie_version = ( !!window.ActiveXObject && +( /msie\s(\d+)/i.exec(navigator.userAgent)[1] ) ) || NaN, $readerContent = jQuery('.reader-content');

    if ($readerContent.find('h2').length > 0) {
        $readerContent.find('h2').each(function () {
            headingText = jQuery(this).text().toLowerCase();

            headingText = headingText.replace(/[^A-Za-z0-9 \-]/g, '').replace(/ /g, '-');

            if (id === headingText) {

                if (jQuery('.sticky-menu').length) {
                    jQuery("body, html").animate({
                        scrollTop: jQuery(this).offset().top - jQuery('.sticky-menu > header').outerHeight(true) - 10
                    }, 1000);
                } else {
                    jQuery("body, html").animate({
                        scrollTop: jQuery(this).offset().top - 10
                    }, 1000);
                }

                /* if (!isNaN(ie_version) && parseInt(ie_version) <= 9) {
                 changeWindowUrl(headingText);
                 }*/
                found = true;
                returnVal = false;

                if (found) {
                    return false;
                }
            }

        });
        if (found) {
            returnVal = false;
            return false;

        } else {
            jQuery("body, html").animate({
                scrollTop: 0
            }, 1000);
        }
    }

}

/**
 * Apply height to all array values
 * @param a - array
 * @param v - height value
 */
function setAllHeight (a, v) {

    'use strict';

    var i, n = a.length;
    for (i = 0; i < n; ++i) {
        jQuery(a[i]).css('height', v + 'px');
    }
}


/**
 * Accordion jQuery Plugin
 */

jQuery(function ($) {
    'use strict';

    $.fn.accordion = function (options) {
        var $accordion;

        if (this.length > 0) {
            $accordion = $(this);

            $accordion.addClass('accordion-init');

            $accordion.find('.accordion-text:visible').filter(function () {
                return ($(this).siblings('.open-on-load').length < 1);
            }).hide();

            $accordion.on('click', 'span', function () {
                var $accordionTitle;

                $accordionTitle = $(this);
                $accordionTitle.text();

                $(this).toggleClass('closed-arrow');

                $accordionTitle.accordion.accordion_move(options, $accordionTitle);
            });
        }

        return this;
    };

    $.fn.accordion.accordion_move = function (options, $accordionTitle) {

        var $settings = $.extend({
            parent    : '.accordion-parent',
            allParents: true,
            speed     : 500
        }, options), $accordionSiblings, alreadyOpen = false;

        if ($settings.allParents) {
            $accordionSiblings = $accordionTitle.closest($settings.parent).parent().find('.accordion-text:visible');
        } else {
            $accordionSiblings = $accordionTitle.closest($settings.parent).find('.accordion-text:visible');
        }

        alreadyOpen = ($accordionTitle.nextAll('.accordion-text:visible').length > 0);

        if ($accordionSiblings.length > 0) {
            $accordionSiblings.slideUp($settings.speed, function () {
                $accordionTitle.parent().removeClass('expanded');
                $accordionSiblings.parent().removeClass('expanded');

                if (!alreadyOpen) {
                    $accordionTitle.parent().addClass('expanded').find('.accordion-text').slideDown($settings.speed);
                }
            });
        } else {
            if (!alreadyOpen) {
                $accordionTitle.parent().addClass('expanded').find('.accordion-text').slideDown($settings.speed);
            } else {
                $accordionTitle.parent().removeClass('expanded').find('.accordion-text').slideUp($settings.speed);
            }
        }

    };

    $.fn.accordion.removeAccordion = function () {
        var $accordion = $('.accordion-init');

        $accordion.removeClass('accordion-init');
        $accordion.off('click', 'h1');
        $accordion.find('.accordion-text:hidden').filter(function () {
            return ($(this).siblings('.expand').length < 1);
        }).show();
        $accordion.find('.expanded').removeClass('expanded');
    };
});

jQuery(function ($) {

    'use strict';

    var chapters, $readerContentH2, i = 0, h2Text = '', $readerContent = $('.publications-reader-content'), relatedFootnote = '', $part = $('.part'), heading = window.location.hash.substring(1), $body = $('body'), ie_version = ( !!window.ActiveXObject && +( /msie\s(\d+)/i.exec(navigator.userAgent)[1] ) ) || NaN, currentPos, stickyMenuHeight = $('.sticky-menu > header').outerHeight(true), fixedReaderTop, readerLinksTop, arrowPos, responsiveAdjustHeight = 0, adjustHeight = -10, $stickyMenu = $(".sticky-menu > header"), $featuredSliderHeight = $('.featured-slider').outerHeight(true), $header = $('#header'), lastScrollTop = 0, windowHash, heightSet = false, timeOut = 0, foundH2s = [], window_inner_width = (window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth), $currentHeading = {
        h2      : '',
        position: 0
    };

    fixedReaderTop = $header.outerHeight(true) + $('#main-nav').outerHeight(true) + ($('.sticky-menu').length ? $('.sticky-menu').next('.reader-header').outerHeight(true) : ($('.reader-header').length ? $('.reader-header').outerHeight(true) : 0));

    if ($('.featured-slider').length) {
        if ($('.featured-slider').hasClass('slider')) {
            $featuredSliderHeight = 435; // chrome height fix
        }

        fixedReaderTop += $featuredSliderHeight;
    }

    /**
     * remove admin bar height if visible
     */
    if ($('#wpadminbar').length) {
        adjustHeight += $('#wpadminbar').outerHeight(true);
    }
    /**
     * Load content when hash url is passed
     */
    if($readerContent.length) {
        if (window.location.hash) {

            window.scrollTo(0, 0);
            if (heading.length > 0) {
                if ($('.reader-content').length) {
                    $('.reader-sub-headings').find('#' + heading).addClass('selected');

                    moveReaderContent(heading);

                }
            }
        }
        /**
         * Show green header only for the root publication load otherwise skip the header and got to the main content straight away
         */ else if ($('main').length && $('.reader-header').length) {
            if ($('main').hasClass('sub-item')) {
                if (window_inner_width <= 640) {
                    responsiveAdjustHeight = 5;
                } else {
                    responsiveAdjustHeight = 140;
                }
                setTimeout(function () {
                    window.scrollTo(0, ($readerContent.offset().top - responsiveAdjustHeight));
                }, 150);
            } else {
                if (window_inner_width <= 640) {
                    responsiveAdjustHeight = 0;
                } else {
                    responsiveAdjustHeight = 35;
                }
                setTimeout(function () {
                    if ($('.sticky-menu').length) {
                        window.scrollTo(0, ($('.sticky-menu').next('.reader-header').offset().top - responsiveAdjustHeight ));
                    } else {
                        window.scrollTo(0, ($('.reader-header').offset().top - responsiveAdjustHeight ));
                    }
                }, 150);
            }
        }
    }

    $('.reader-navigation').accordion();

    /**
     * Reader footnotes
     */


    $body.on('click', 'sup.footnote > a', function (e) {
        e.preventDefault();

        $('#reader-footnotes').find('.active').removeClass('active');

        relatedFootnote = $(this).attr('id');
        relatedFootnote = relatedFootnote.replace('fnref', 'fn');
        relatedFootnote = '#' + relatedFootnote;

        $("body, html").animate({
            scrollTop: $(relatedFootnote).offset().top - stickyMenuHeight - $(relatedFootnote).outerHeight(true) - 5
        }, 500);

        $(relatedFootnote).addClass('active');

        clearTimeout(timeOut);
        timeOut = setTimeout(function () {
            $('#reader-footnotes').find('.active').removeClass('active');
        }, 3000);

    });

    $body.on('click', '.footnotereverse > a', function (e) {
        var href = $(this).attr('href');

        e.preventDefault();

        $("body, html").animate({
            scrollTop: $(href).parent('.footnote').offset().top - stickyMenuHeight - $(href).parent('.footnote').outerHeight(true) - 5
        }, 500);

        $('#reader-footnotes').find('.active').removeClass('active');
        $(this).closest('li').addClass('active');

        clearTimeout(timeOut);
        timeOut = setTimeout(function () {
            $('#reader-footnotes').find('.active').removeClass('active');
        }, 3000);

    });

    /**
     * Reader heading click ....
     */
    if ($('.reader-child').length) {

        if ($part.length) {
            $part.find('a').removeAttr('href');
            $part.find('a').css('cursor', 'default');
        }
        if ($('.subheading.selected').length) {
            $('.part').removeClass('selected');

        }
        $('.chapter.selected').prevAll('.part').first().addClass('selected');

        $('.reader-child ').find('a').on('click', function (e) {
            if ($(this).parent('li').hasClass('part')) {
                e.preventDefault();
            }

            if ($(this).parent('li').parent('ul').hasClass('reader-sub-headings') && $(this).parent('li').parent('ul.reader-sub-headings').parent('li').hasClass('selected')) {
                e.preventDefault();
                $(this).parent('li').siblings('li').removeClass('selected');
                $(this).parent('li').addClass('selected');

                moveReaderContent($(this).parent('li').attr('id'));

                changeWindowUrl($(this).attr('href'));

                return false;
            }

        });
    }

    /**
     * Update current sub heading link and window hash - on window scroll
     */
    chapters = [];

    i = 0;

    $readerContentH2 = $readerContent.find('h2');
    if ($readerContentH2.length > 0) {
        $readerContentH2.each(function () {
            if ($(this).text().length && $.inArray($(this).text().toLowerCase().replace(/[^A-Za-z0-9 \-]/g, '').replace(/ /g, '-'), foundH2s) === -1) {

                chapters[i] = {
                    'h2'      : $(this).text().toLowerCase().replace(/[^A-Za-z0-9 \-]/g, '').replace(/ /g, '-'),
                    'top'     : $(this).offset().top - stickyMenuHeight - $(this).outerHeight(true) - 35,
                    'position': i
                };
                if (window.location.hash.length && ('#' + chapters[i].h2) === window.location.hash) {
                    $currentHeading = {
                        h2      : chapters[i].h2,
                        position: i

                    };
                }
                foundH2s[i] = chapters[i].h2;
                i++;
            }

        });
    }

    if (chapters.length > 0) {

        for (i = 0; i < chapters.length; i++) {
            h2Text = chapters[i].h2;
            if (h2Text.length > 0) {

                chapters[i].bottom = (i + 1) < chapters.length ? chapters[i + 1].top : $(document).height();
                chapters[chapters[i].h2] = chapters[i];

            }

        }

    }

    /**
     *  set current heading object
     */

    if ($readerContent.length && $readerContentH2.length && $currentHeading.h2.length <= 0) {
        $currentHeading = {
            h2      : chapters[0].h2,
            position: 0

        };
    }
    $('.reader-children').css({
        'position': 'relative'

    });

    //add mobile select chapter menu
    if (window_inner_width <= 640) {

        $('.mobile-select-chapter').show();

    } else {

        $('.mobile-select-chapter').hide();

    }

    $(window).on("scroll", function () {

        if ($stickyMenu.length) {

            moveFixedMenu();

        }
        window_inner_width = (window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth);

        if (($('.reader-children').length || $('#reader-footnotes li').length) && (isNaN(ie_version) || parseInt(ie_version) > 9)) {

            //positioning sidebar links here
            currentPos = $(window).scrollTop();

            if (window_inner_width >= 1023) {
                if (currentPos > ( $('.featured-slider').length ? fixedReaderTop - stickyMenuHeight : fixedReaderTop  ) && !heightSet) {
                    // if (($('.reader-children').offset().top + $('.reader-children').height()) <= $('.reader-content').outerHeight(true)) {
                    $('.reader-children').parent('.reader-navigation').css({
                        'position': 'relative',
                        'top'     : currentPos - fixedReaderTop - adjustHeight + stickyMenuHeight + 'px'
                    }, 100);

                    if ($('.reader-children').find('li:last').offset().top > (currentPos + fixedReaderTop - adjustHeight - stickyMenuHeight)) {
                        if ($('#scroll-down').length) {
                            $('#scroll-down').remove();
                        }
                        arrowPos = $(window).height() - 20;

                        // $('body').append('<span id="scroll-down" style="position:fixed; top:' + arrowPos + 'px;z-index:1000; background-color:#fff;">Down</span>');
                    }

                    //positioning footnotes if available
                    if ($('#reader-footnotes li').length) {
                        $('#reader-footnotes ul').css({
                            'position': 'relative',
                            'top'     : currentPos - fixedReaderTop - adjustHeight + stickyMenuHeight + 'px'
                        }, 100);
                    }

                    if (!heightSet && (currentPos - fixedReaderTop + stickyMenuHeight - adjustHeight + $('.reader-children').parent('.reader-navigation').height()) > $('.single-content').height()) {
                        $('.single-content').height((currentPos - fixedReaderTop - adjustHeight + stickyMenuHeight + $('.reader-children').parent('.reader-navigation').height()));
                        if ($('#scroll-down').length) {
                            $('#scroll-down').remove();

                        }
                        heightSet = true;
                    }
                    if (!heightSet && $('#reader-footnotes li').length && (currentPos - fixedReaderTop + stickyMenuHeight + $('#reader-footnotes ul').height()) > $('.single-content').height()) {
                        $('.single-content').height((currentPos - fixedReaderTop - adjustHeight + stickyMenuHeight + $('#reader-footnotes ul').height()));
                        heightSet = true;
                    }

                } else {
                    readerLinksTop = $('.reader-children').parent('.reader-navigation').css('top');
                    readerLinksTop = readerLinksTop.split('px');
                    readerLinksTop = parseFloat(readerLinksTop[0]);
                    if ((currentPos - fixedReaderTop + stickyMenuHeight - adjustHeight ) < readerLinksTop) {
                        heightSet = false;
                    }
                    if ($('#reader-footnotes li').length) {
                        readerLinksTop = $('#reader-footnotes ul').css('top');
                        readerLinksTop = readerLinksTop.split('px');
                        readerLinksTop = parseFloat(readerLinksTop[0]);
                        if ((currentPos - fixedReaderTop + stickyMenuHeight - adjustHeight ) < readerLinksTop) {
                            heightSet = false;
                        }
                    }

                    if (currentPos <= fixedReaderTop) {
                        $('.reader-children').parent('.reader-navigation').removeAttr('style');
                        if ($('#scroll-down').length) {
                            $('#scroll-down').remove();
                        }
                        heightSet = false;
                        $('#reader-footnotes ul').removeAttr('style');

                    }
                }
            }

            //changing window hash on scroll
            if (chapters.length > 0) {

                windowHash = window.location.hash;

                //check for current heading hash and position

                if (windowHash !== ('#' + $currentHeading.h2 ) && currentPos >= chapters[$currentHeading.h2].top && currentPos < chapters[$currentHeading.h2].bottom) {

                    $('.reader-sub-headings').find('li').removeClass('selected');
                    $('#' + $currentHeading.h2).addClass('selected');
                    //   changeWindowUrl('#' + $currentHeading.h2);
                }

                if (currentPos > chapters[$currentHeading.h2].bottom && ( $currentHeading.position + 1) < chapters.length) {

                    $currentHeading = {
                        h2      : chapters[$currentHeading.position + 1].h2,
                        position: $currentHeading.position + 1

                    };
                    $('.reader-sub-headings').find('li').removeClass('selected');
                    $('#' + $currentHeading.h2).addClass('selected');
                    if (windowHash !== ('#' + $currentHeading.h2 )) {
                        // changeWindowUrl('#' + $currentHeading.h2);
                    }

                }
                if (currentPos < chapters[$currentHeading.h2].top) {

                    if ($currentHeading.position > 0) {

                        $currentHeading = {
                            h2      : chapters[$currentHeading.position - 1].h2,
                            position: $currentHeading.position - 1

                        };
                        $('.reader-sub-headings').find('li').removeClass('selected');
                        $('#' + $currentHeading.h2).addClass('selected');

                        if (windowHash !== ('#' + $currentHeading.h2 )) {
                            // changeWindowUrl('#' + $currentHeading.h2);
                        }
                    } else if (currentPos < (chapters[$currentHeading.h2].top - 50) && currentPos < lastScrollTop) {

                        changeWindowUrl('');
                        $('.reader-sub-headings').find('li').removeClass('selected');
                    }
                }
            }
            lastScrollTop = currentPos;

        }

    });
    $('.mobile-select-chapter').on('click', function () {

        $('.reader-navigation').slideToggle();

    });
    $(window).on("resize", function () {
        window_inner_width = (window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth);

        if (window_inner_width <= 640) {
            $('.mobile-select-chapter').show();
        } else {
            $('.mobile-select-chapter').hide();
        }

    });

    /* Bypassing the website header to go straight to the reader header */
    /*var $readerHeader = $('body > .reader-header');

     setTimeout(function () {
     $('html, body').animate({
     scrollTop: $readerHeader.offset().top
     }, 0);
     }, 700);*/

});
