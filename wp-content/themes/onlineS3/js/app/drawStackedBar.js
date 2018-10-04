function showAjaxStackedBar(args) {
    
    var xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            
            renderStackedBar({container: args.container, data: args.data, vars: args.vars, states: args.states, title: args.title, sub_title: args.sub_title, width: args.width});
        }
    };
    xmlhttp.open("POST", window.location.href, true);
    xmlhttp.send();
}

function renderStackedBar(args) {
    
    try {
        var container = (args.container) ? '#' + args.container : 'bar';
        var width = (args.width) ? args.width : 760;
        var height = (args.height) ? args.height : 410; // 410
        var variables = args.vars;
        var states = args.states;
        var title = args.title;
        var sub_title = args.sub_title;
        var data = args.data;

        $(container).empty();  // clear container div

        var var_no = variables.length;

        var colors = ['#a6cde2', '#1f78b4' ,'#fc0'];

        var margin = {top: 20, right: 20, bottom: 20, left: 20},
            width = width - margin.left - margin.right,
            height = height - margin.top - margin.bottom; // 370

        var content_height = height-70; // 280 (for legends)

        var x = d3.scale.ordinal()
            .domain(variables)
            .rangeRoundBands([20, width], .2);

        //var max_value = 45;

        var max_value=0;
        for(var i=0;i<data.length;i++) {
            if(data[i]['planned']>max_value) {
                max_value = Number(data[i]['planned']);
            }
            if(data[i]['commit']>max_value) {
                max_value = Number(data[i]['commit']);
            }
            if(data[i]['spent']>max_value) {
                max_value = Number(data[i]['spent']);
            }
        }

        max_value = 1.3 * max_value;
        var max_chart = 1.3 * max_value;
        //var max_chart = max_value;

        var y_domain=[], y_tick=0, tick_count=5;
        for(var i=0; i<tick_count; i++) {
            y_domain[i] = (max_chart > 100) ? formatNumber(y_tick,0,'','.') : formatNumber(y_tick,2,'','.');
            y_tick += max_chart/tick_count;
        }

        var y0 = d3.scale.ordinal()
            .domain(y_domain)
            .rangeBands([content_height, 0]);

        var y = d3.scale.linear()
            .domain([0,max_chart])
            .range([content_height, 0]);

        var xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom");

        var yAxis = d3.svg.axis()
            .scale(y0)
            .orient("left");

        var svg = d3.selectAll(container).append("svg")
            .style("background-color", "white")
            .attr("id", "export-svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        svg.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0,342)")
            .call(customXAxis);

        svg.append("g")
            .attr("class", "y axis")
            .attr("transform", "translate(30,66)")
            .call(customYAxis);

        // draws the border of the chart
        svg.append("rect")
            .attr('x',30)
            .attr('y',40)
            .attr('width',width-40)
            .attr('height', content_height)
            .attr("fill", "none")
            .style('stroke-opacity','#8D8D8D')
            .style('stroke-opacity',1)
            .style('stroke-linejoin','miter')
            .style('fill','none')
            .style('background-color','white')
            .style('stroke','#9da2aa');

        // draws inner background boxes
        svg = renderBackBoxes(svg, width, content_height, tick_count);

        // creates tooltips
        var tip = d3.tip()
            .attr('class', 'd3-tip')
            .offset([-10, 0])
            .html(function(d, i, j) {
                var type=states[j];
                switch(type) {
                    case 'planned':
                        return 'Planned €'+ d.planned;
                    case 'commit':
                        return 'Committed €'+ d.commit;
                    case 'spent':
                        return 'Spent €'+ d.spent;
                    default:
                        return '';
                }
            });

        svg.call(tip);

        var g = svg.selectAll(".bars")
            .data(data)
            .enter()
            .append("g")
            .attr("transform", function(d, i) { return "translate(0,40)"; });

        g.append("rect")
            .attr("class", "planned")
            .style("fill", "#a6cde2")
            .attr("x", function(d) {
              return x(d.region) + (290/(var_no*1.17)); // center it
            })
            .attr("width", 50 ) // make it slimmer
            .attr("y", function(d) {
              return y(d.planned);
            })
            .attr("height", function(d) {
                return content_height - y(d.planned);
            })
            .attr("opacity", "1")
            .on('mouseover', // show tooltips
                function(d, i, j) { 
                    var opacity = d3.select(this).attr("opacity");
                    //alert(opacity);
                    if (opacity==1) {
                        tip.show(d, i, 0);
                        d3.select(this).attr({
                            opacity: ".7"
                        });
                    }
                }
            )
            .on('mouseout', // hide tooltips
                function(d, i, j) { 
                    tip.hide(d, i, j); 
                    var opacity = d3.select(this).attr("opacity");
                    if (opacity!=0) {
                        d3.select(this).attr({
                            opacity: "1",
                        });
                    }
                }
            );

          g.append("rect")
            .attr("class", "commit")
            .style("fill", "#1f78b4")
            .attr("x", function(d) {
                return x(d.region) + (290/(var_no*1.17)) + 7;
            })
            .attr("width", 36 )
            .attr("y", function(d) {
              return y(d.commit);
            })
            .attr("height", function(d) {
              return content_height - y(d.commit);
            })
            .attr("opacity", "1")
            .on('mouseover', // show tooltips
                function(d, i, j) { 
                    var opacity = d3.select(this).attr("opacity");
                    if (opacity==1) {
                        tip.show(d, i, 1);
                        d3.select(this).attr({
                            opacity: ".7"
                        });
                    }
                }
            )
            .on('mouseout', // hide tooltips
                function(d, i, j) { 
                    tip.hide(d, i, j); 
                    var opacity = d3.select(this).attr("opacity");
                    if (opacity!=0) {
                        d3.select(this).attr({
                            opacity: "1",
                        });
                    }
                }
            );

            g.append("rect")
            .attr("class", "spent")
            .style("fill", "#ffcc00")
            .attr("x", function(d) {
              return x(d.region) + (290/(var_no*1.17)) + 14;
            })
            .attr("width", 22)
            .attr("y", function(d) {
              return y(d.spent);
            })
            .attr("height", function(d) {
              return content_height - y(d.spent);
            })
            .attr("opacity", "1")
            .on('mouseover', // show tooltips
                function(d, i, j) { 
                    var opacity = d3.select(this).attr("opacity");
                    if (opacity==1) {
                        tip.show(d, i, 2);
                        d3.select(this).attr({
                            opacity: ".7"
                        });
                    }
                }
            )
            .on('mouseout', // hide tooltips
                function(d, i, j) { 
                    tip.hide(d, i, j); 
                    var opacity = d3.select(this).attr("opacity");
                    if (opacity!=0) {
                        d3.select(this).attr({
                            opacity: "1",
                        });
                    }
                }
            );

        // appends title for the graph
        svg.append("text")
            .attr("x", 4)             
            .attr("y", 0)
            .attr("text-anchor", "start")  
            .style("font-size", "13px") 
            .style("fill","#5C5A5A")
            .style("font-weight","bold")
            .style("font-family", "verdana")
            .text(title);

        svg.append("text")
            .attr("x", 4)             
            .attr("y", 20)
            .attr("text-anchor", "start")  
            .style("font-size", "12px") 
            .style("fill","#565656")
            .style("font-style","italic")
            .style("font-family", "verdana")
            .text(sub_title);


        // render the legends
        svg = renderLegend(svg, height, states, colors, args.group_type);

        function type(d) {
          d.planned = +d.planned;
          d.spent = +d.spent;
          d.commit = +d.commit;
          return d;
        }

        function customYAxis(g) {
            g.call(yAxis);
            g.selectAll("line").style('fill','none').style('stroke','none');
            g.selectAll("text").style('font-size','11px').style('text-anchor','end').style('font-family','tahoma');
            g.selectAll("text").style('fill','#5C5A5A');
            g.selectAll(".tick line").style('display', 'none');
            g.selectAll("path").style('display', 'none');
        }

        function customXAxis(g) {
            g.call(xAxis);
            g.selectAll("path").style('fill','#fff');
            g.selectAll("line").style('stroke','none');
            g.selectAll("text").style('font-size','11px').style('text-anchor','middle').style('font-family','tahoma');
            g.selectAll("text").style('fill','#5C5A5A');
//            g.selectAll(".minor").fill('stroke-opacity',.5);
        }

        // display graph
        $(container).parent().removeClass('hide');

        $('#reset_chart').removeClass('hide');
        
    } catch (err) {
        // displays exception error
        alert(err.message);
        return false;
    }
        
    // creates png data for the report
    //svg2img(args.container);
    return false;	
}

