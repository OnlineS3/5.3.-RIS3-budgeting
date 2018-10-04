
/*
 * exports html to pdf file
 * @param {string} tbl_id 
 * @param {string} filename  
 */

var exportReport2Pdf = function(args) {
    var img_elem = $('#'+args.report_id);  // gets table div
    var filename = (args.filename) ? args.filename : 'OnlineReport.pdf';
    
    // uses html2canvas to capture the div as image
    html2canvas(img_elem, {
        onrendered: function (canvas) {
            var img = canvas.toDataURL("image/jpeg");
            var doc = new jsPDF();  // uses jsPDF to export image as pdf
            doc.addImage(img,'jpeg',20,20);
            doc.save(filename);
        }
    }); 
};