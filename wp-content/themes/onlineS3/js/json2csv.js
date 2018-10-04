
/*
 * exports csv file
 * @param {json} data 
 * @param {string} filename  
 */

var export2csv = function(args) {
    
    var arr_data = args.data;
    var filename = (args.filename) ? args.filename : 'online_csv.csv';
    
    if (arr_data === null) {
        document.getElementById("app-alert").innerHTML = 'The table provided is empty !';
        return false;
    }

    try {
        // convert json to csv
        var csv = convertJsonToCSV({
            data: arr_data
        });
        
        if (navigator.msSaveBlob) { //for IE
            var blob = new Blob([csv],{ 
                type: "text/csv;charset=utf-8;"
            });

            navigator.msSaveBlob(blob, filename);
        } else {
            if (!csv.match(/^data:text\/csv/i)) {
                csv = 'data:text/csv;charset=utf-8,' + csv;
            }
            data = encodeURI(csv);  // encode uri

            var link_t=document.createElement('a'); // create tmp link
            link_t.href=data;
            link_t.download=filename;
            document.querySelector("body").appendChild(link_t);
            link_t.click();
            document.querySelector("body").removeChild(link_t);
        }
    }
    catch(err) {
        document.getElementById("app-alert").innerHTML = err.message;
        return false;
    }

    return false;
};

/*
 * converts json to csv
 * @param {json} data 
 */
function convertJsonToCSV(args) {
    var csv, ctr, keys, columnDelimiter, lineDelimiter, data;

    data = args.data || null;
    if (data === null || !data.length) {
        return null;
    }

    columnDelimiter = args.columnDelimiter || ';';
    lineDelimiter = args.lineDelimiter || '\n';

    keys = Object.keys(data[0]);
    
    csv = '';

    data.forEach(function(item) {
        ctr = 0;
        keys.forEach(function(key) {
            if (ctr > 0) csv += columnDelimiter;

            csv += item[key];
            ctr++;
        });
        csv += lineDelimiter;
    });

    return csv;
}