
/*
 * exports xlsx file
 * @param {json} data 
 * @param {string} filename  
 */

/*
 * exports xlsx file
 * @param {json} data 
 * @param {string} filename  
 */
var export2xls = function(args) {
    
    var arr_data = args.data;
    var filename = (args.filename) ? args.filename : 'online_xls.xlsx';
    
    if (arr_data === null) {
        document.getElementById("app-alert").innerHTML = 'The table provided is empty !';
        return false;
    }
    
    try {
        // saves data to xls format
        alasql("SELECT * INTO XLSX('" + filename + "',{headers:false}) FROM ? ",[arr_data]);
    }
    catch(err) {
        document.getElementById("app-alert").innerHTML = err.message;
        return false;
    }
    return false;
};


function Option() {
    
}

var export2xlsMultiple = function(args) {
    var key_name, xls_data=[], src_data=[], options=[], max_cols=0;
    src_data = args.data;
    var filename = (args.filename) ? args.filename : 'online_xls.xlsx';
    
    try {
        var data_keys = Object.keys(src_data);

        for(var i=0;i<data_keys.length;i++) {
            key_name = data_keys[i];
            xls_data[i] = src_data[key_name];
            options[i] = new Option();
            options[i]['sheetid'] = key_name;
            options[i]['headers'] = false;
            
        }
    
        var res = alasql('SELECT INTO XLSX("'+filename+'",?) FROM ?',[options,xls_data],
          function(){
            return false;
            
          });
    
    }
    catch(err) {
        alert(err.message);
        document.getElementById("app-alert").innerHTML = err.message;
        return true;
    }
    return false;
};

