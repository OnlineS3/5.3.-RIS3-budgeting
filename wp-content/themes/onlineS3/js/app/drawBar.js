
function showAjaxBar(args) {
    
    var xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            renderStackedBar({container: args.container, data: args.data, vars: args.vars, title: args.title, sub_title: args.sub_title, width: args.width});
        }
    };
    xmlhttp.open("POST", window.location.href, true);
    xmlhttp.send();
}

/*
 * renders bar chart
 * @param {json} data 
 * @param {string} container  
 * @param {number} width
 * @param {number} height
 * @param {string} title
 * @param {string} group_type
 */

function renderBarChart(args) {
    try {
        var input_data = args.data;
        var container = (args.container) ? '#' + args.container : 'bar';
        var width = (args.width) ? args.width : 760;
        var height = (args.height) ? args.height : 410;
        var title = args.title;
        var sub_title = args.sub_title;
        
        $(container).empty();  // clear container div
        
        var variables = args.vars;
//        var variables = getRowHeaders(input_data);
        
        if (variables.length > 30) {
            variables = variables.slice(0, 29);
            input_data = input_data.slice(0,29);
        }
        
        var x_labels = input_data[0].slice(1);
        var data = getRowData(input_data);
        
        // set dimensions
        var margin = {top: 20, right: 20, bottom: 20, left: 20},
        width = width - margin.left - margin.right,
        height = height - margin.top - margin.bottom;
        
        var content_height = height-90;
        
        var n = x_labels.length, // number of x samples
        m = variables.length; // number of x series
        
        // calculate the max value on input data
        var max_vals=[];
        for(var i=0;i<data.length;i++) {
            max_vals[i] = Math.max.apply(null, data[i]);
        }
        var max_value = Math.max.apply(null, max_vals);
        
        max_value = 1.3 * max_value;
        
        // creates x domain
        var x0 = d3.scale.ordinal()
            .domain(x_labels)
            .rangeBands([20, width], .2);
        
        var x1 = d3.scale.ordinal()
            .domain(d3.range(n))
            .rangeBands([20, width], .2);
    
        var x2 = d3.scale.ordinal()
            .domain(d3.range(m))
            .rangeBands([0, x1.rangeBand()]);
        
        // creates y domain
        // var tick_count_y = (max_value>0) ? 5 : 1;
        var y_domain=[], y_tick=0, tick_count=5;
        for(var i=0; i<tick_count; i++) {
            y_domain[i] = (max_value > 100) ? formatNumber(y_tick,0,'','.') : formatNumber(y_tick,2,'','.');
            y_tick += max_value/5;
        }
        
        var y0 = d3.scale.ordinal()
            .domain(y_domain)
            .rangeBands([height-90, 0]);
        
        var y = d3.scale.linear()
            .domain([0,max_value])
            .range([height-90, 0]);
  
        // create x Axis
        var xAxis = d3.svg.axis()
            .scale(x0)
            .orient("bottom");

        // create y Axis
        var yAxis = d3.svg.axis()
            .scale(y0)
            .orient("left");
    
        // color vals
        var colors = ['#2685cb','#4ad95a' ,'#fc3026','#fec81b','#4b4ad3','#fee45f',
            '#3366cc','#66aa00', '#dddd22','#7db8ff', '#999999','#dc3912', '#994C00', '#2d687e',
            '#2685cb','#fec81b' ,'#fc3026','#4ad95a','#4b4ad3','#fee45f','#3366cc',
            '#66aa00', '#dddd22','#7db8ff', '#999999','#dc3912', '#994C00', '#2d687e', '#dddd22','#7db8ff'];
        
        // creates svg container
        var svg = d3.selectAll(container).append("svg")
            .attr("id", "export-svg")
            .attr("style", "background-color:white")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("svg:g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
        
        // appends x Axis
        svg.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0," + (height - 50) + ")")
            .call(customXAxis);
    
        // appends y Axis
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
                return variables[j] + ', ' + x_labels[i] + ', ' + d;
            });

        svg.call(tip);
    
        // draws the bars
        svg.append("g").selectAll("g")
            .data(data)
            .enter().append("g")
            .style("fill", function(d, i) { return colors[i]; })
            .attr("transform", function(d, i) { return "translate(" + x2(i) + ",40)"; })
            .selectAll("rect")
            .data(function(d) { return d; })
            .enter().append("rect")
            .attr("class", function(d, i, j) { return variables[j]; })
            .attr("stroke","#333333")
            .attr("width", x2.rangeBand())
            .attr("height", function(d) { return content_height - y(d); })
            .attr("x", function(d, i) { return x1(i); })
            .attr("y", function(d) { return y(d); })
            .attr("opacity", "1")
            .on('mouseover', // show tooltips
                function(d, i, j) { 
                    tip.show(d, i, j);
                    var opacity = d3.select(this).attr("opacity");
                    if (opacity==1) {
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
        svg = renderLegend(svg, height, variables, colors, args.group_type);
        
        // display graph
        $(container).parent().removeClass('hide');
        
        // creates png data for the report
        svg2img(args.container);
        
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
            g.selectAll(".minor").fill('stroke-opacity',.5);
        }
        
    } catch (err) {
        // displays exception error
        alert(err.message);
        return false;
    }
    return false;	
}

