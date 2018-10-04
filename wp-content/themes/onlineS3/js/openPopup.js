

/*
 * Opens report to new window
 * @param {string} url 
 * @param {string} name
 * @param {number} rows 
 * @param {number} cols 
 * @param {json} group 
 */
var openPopup = function(args) {
    
    var win_width, win_height;
    var width=(args.width) ? args.width : '';
    var height=(args.height) ? args.height : '';
    
    if (screen.width > 1300 ) {
        switch(width) {
            case 'large':
                win_width = screen.width - (.4 * screen.width);
                break;
            case 'medium':
                win_width = screen.width - (.52 * screen.width);
                break;
            case 'small':
                win_width = screen.width - (.6 * screen.width);
                break;
            default:
                win_width = screen.width - (.55 * screen.width);
        }
    } else {
        switch(width) {
            case 'large':
                win_width = screen.width - (.25 * screen.width);
                break;
            case 'medium':
                win_width = screen.width - (.3 * screen.width);
                break;
            case 'small':
                win_width = screen.width - (.3 * screen.width);
                break;
            default:
                win_width = screen.width - (.3 * screen.width);
        }
    }
    
    if (screen.width > 1300 ) {
        switch(height) {
            case 'large':
                win_height = screen.height - (.2 * screen.height);
                break;
            case 'medium':
                win_height = screen.height - (.25 * screen.height);
                break;
            case 'small':
                win_height = screen.height - (.6 * screen.height);
                break;
            default:
                win_height = screen.height - (.25 * screen.height);
        }
    }
    else {
        switch(height) {
            case 'large':
                win_height = screen.height - (.15 * screen.height);
                break;
            case 'medium':
                win_height = screen.height - (.2 * screen.height);
                break;
            case 'small':
                win_height = screen.height - (.4 * screen.height);
                break;
            default:
                win_height = screen.height - (.2 * screen.height);
        }
    }
    
    var win_left = ((1-(win_width/screen.width))/ 2)*screen.width;
    var win_top = ((1-(win_height/screen.height))/ 2)*screen.height;

    var url = args.url;
    var name = args.name;
    
    // opens the window
    var myWindow = window.open(url, name,
        "scrollbars=yes, height=" + win_height + ", width = " + win_width + ", left = " + win_left + ", top = " + win_top);
    myWindow.focus();
    
    return false;
};

/*  to popup window
 * @param {string} url 
 * @param {string} name 
 * @param {json} data  
 */
function sendData(url, name, report_data) {
    // hidden Form
    var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", url);
    form.setAttribute("target", name);

    // converts json to string and appends to form
    form = createJsonElem(form,'report_data',JSON.stringify(report_data));
    
    try {
        // to send json data via ajax
        var data = {};
        for (var i = 0, ii = form.length; i < ii; ++i) {
            var input = form[i];
            if (input.name) {
                data[input.name] = input.value;
            }
        }

        var xhr = new XMLHttpRequest();
        xhr.open(form.method, form.action, true);
        xhr.setRequestHeader("Content-type", "application/json");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                document.getElementById("app-alert").innerHTML = xhr.responseText;
                return false;
            }
        };
        xhr.send(data);
    } catch (err) {
        document.getElementById("app-alert").innerHTML = err.message;
        return false;
    }

    document.body.appendChild(form);

    // submits the form
    form.submit();
    
    return false;
}

/*
 * creates json element and append to form
 * @param {dom} form 
 * @param {string} col 
 * @param {string} val  
 */
function createJsonElem(form,col,val) {
    // hidden Field
    var hiddenField = document.createElement("input");
    
    // col
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("id", col);
    hiddenField.setAttribute("name", col);
    hiddenField.setAttribute("value", val);
    
    // append to form
    form.appendChild(hiddenField);
    
    return form;
}

/*
 * retrieve table values by id
 * @param {number} form 
 * @param {string} rows 
 * @param {string} cols  
 * @return {array} cols  
 */
function getValById(rows, cols) {
    var result=[], checked=[], sections=[];
    var des, quart, kernel, kernel_prop;
    for (var i = 0; i < rows; i++){
        var columns = [], checked_cols = [];
        for (var j = 0; j < cols; j++){
            var indx = i + ':' + j;
            var pop_cell = document.getElementById(indx);
            var pop_cell_val = 0;
            if (pop_cell) {
                pop_cell_val = pop_cell.value;
                if (j===0) {
                    checked_cols[0] = pop_cell.value;
                    checked_cols[1] = pop_cell.checked;
                }
            }
            columns[j] = pop_cell_val;
        }
        result[i] = columns;
        checked[i] = checked_cols;
    }
    
    des = document.getElementById('sec-descr');
    quart = document.getElementById('sec-quart');
    kernel = document.getElementById('sec-kernel');
    
    sections = [[des.value,des.checked],[quart.value,quart.checked],[kernel.value,kernel.checked]];
    
    kernel_prop = document.getElementById('kernel_prop');
    if(kernel_prop) {
        kernel_prop_val = document.getElementById('kernel_prop').value;
    }
    
    return [result,checked,sections,kernel_prop_val];
}

/*
 * set popup's values to parent's
 * @param {numeric} rows 
 * @param {numeric} cols 
 */
function savePopupTbl(args) {
    var rows = args.rows;
    var cols = args.cols;

    // get table values by id
    for (var j=0;j<rows+1;j++) {
        for(var y=0;y<cols+1;y++) {
            var indx = j + ':' + y;
            var pop_cell = document.getElementById(indx);
            if (pop_cell) {
                var pop_cell_val = pop_cell.value;
                var par_cell = window.opener.document.getElementById(indx);
                par_cell.value = pop_cell_val;  // set value to parent
                if (y===0) {
                    par_cell.checked = pop_cell.checked;
                }
            }
        }
    }

    window.close();
}
