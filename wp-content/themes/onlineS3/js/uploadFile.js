
// sets file name in file input
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            jQuery('#upload_input').val(input.files[0].name);
        };
        reader.readAsDataURL(input.files[0]);
    }
}