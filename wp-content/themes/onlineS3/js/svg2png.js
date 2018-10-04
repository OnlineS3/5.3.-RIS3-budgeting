
/*
 * export svg element to png image
 * with downloading
 * @param {string} container 
 * @param {string} filename  
 */

var exportSvg2PNG = function(args) {

    var container = (args.container) ? '#' + args.container : '#export-svg';
    var filename = (args.filename) ? args.filename : 'online_graph.png';
    
    try {
        // svg object to string
        var svg = d3.select(container).node();
        
        clearBlack(svg);
        
        var serializer = new XMLSerializer();
        var svgData = serializer.serializeToString( svg );

        // add name spaces
        if(!svgData.match(/^<svg[^>]+xmlns="http\:\/\/www\.w3\.org\/2000\/svg"/)){
            svgData = svgData.replace(/^<svg/, '<svg xmlns="http://www.w3.org/2000/svg"');
        }
        if(!svgData.match(/^<svg[^>]+"http\:\/\/www\.w3\.org\/1999\/xlink"/)){
            svgData = svgData.replace(/^<svg/, '<svg xmlns:xlink="http://www.w3.org/1999/xlink"');
        }

        //add xml declaration
        svgData = '<?xml version="1.0" standalone="no"?>\r\n' + svgData;

        //convert svg source to URI data scheme.
        var dataUri = "data:image/svg+xml;charset=utf-8,"+encodeURIComponent(svgData);

        // new canvas to set the image
        var canvas = document.createElement("canvas");
        canvas.width = svg.getAttribute("width");   // set canvas dimensions
        canvas.height = svg.getAttribute("height");
        var ctx = canvas.getContext("2d");
        var img = document.createElement("img");

        img.onload = function() {
            // draws image inside canvas
            ctx.drawImage( img, 0, 0);
            
            if (canvas.msToBlob) { //for IE
                console.log(canvas.msToBlob);
                var png_data = canvas.msToBlob();
                
                window.navigator.msSaveBlob(png_data, filename);
            } else {
                // converts svg image to png
                var png_data = canvas.toDataURL("image/png");
                // creates ahref for download
                var a = document.createElement("a");
                a.download = filename;
                a.href = png_data;
                document.querySelector("body").appendChild(a);
                a.click();
                document.querySelector("body").removeChild(a);
            }
        };

        // sets svg image to image
        img.src = dataUri;
    }
    catch(err) {
        alert(err.message);
        document.getElementById("app-alert").innerHTML = err.message;
        return false;
    }
    return false; 
};

/*
 * converts svg element to png image
 * without downloading (for exporting reports)
 * @param {string} container 
 * @param {string} filename  
 */
function svg2img(args) {
    
    var container = (args.container) ? '#' + args.container : '#export-svg';
    try {
        // svg object to string
        var svg = d3.select(container).node();
        
        clearBlack(svg);
        
        var serializer = new XMLSerializer();
        var svgData = serializer.serializeToString( svg );

        // add name spaces
        if(!svgData.match(/^<svg[^>]+xmlns="http\:\/\/www\.w3\.org\/2000\/svg"/)){
            svgData = svgData.replace(/^<svg/, '<svg xmlns="http://www.w3.org/2000/svg"');
        }
        if(!svgData.match(/^<svg[^>]+"http\:\/\/www\.w3\.org\/1999\/xlink"/)){
            svgData = svgData.replace(/^<svg/, '<svg xmlns:xlink="http://www.w3.org/1999/xlink"');
        }

        //add xml declaration
        svgData = '<?xml version="1.0" standalone="no"?>\r\n' + svgData;

        //convert svg source to URI data scheme.
        var dataUri = "data:image/svg+xml;charset=utf-8,"+encodeURIComponent(svgData);

        // new canvas to set the image
        var canvas = document.createElement("canvas");
        canvas.width = svg.getAttribute("width");   // set canvas dimensions
        canvas.height = svg.getAttribute("height");
        var ctx = canvas.getContext("2d");
        var img = document.createElement("img");

        img.onload = function() {
            // draws image inside canvas
            ctx.drawImage( img, 0, 0);
            
            if (canvas.msToBlob) { //for IE
                console.log(canvas.msToBlob);
                var png_data = canvas.msToBlob();
                
                $('#wd_chart').val(png_data);
            } else {
                // converts svg image to png
                var png_data = canvas.toDataURL("image/png");
                $('#wd_chart').val(png_data);
            }
        };
        // sets svg image to image
        img.src = dataUri;
    }
    catch(err) {
        alert(err.message);
        document.getElementById("app-alert").innerHTML = err.message;
        return false;
    }
    
    return false;
    
}

/*
 * clears black holes from svg image
 * @param {string} container 
 */
function clearBlack(container) {
    var nodeList = container.querySelectorAll('path');
    var nodeList2 = container.querySelectorAll('path');
    var nodeList3 = container.querySelectorAll('line');
    var line_graph = Array.from(nodeList);
    var x_and_y = Array.from(nodeList2).concat(Array.from(nodeList3));
    line_graph.forEach(function(element){
        element.style.fill = "none";
    })
    x_and_y.forEach(function(element){
        element.style.fill = "none";
    })
}
    