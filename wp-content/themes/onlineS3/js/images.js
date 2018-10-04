

$(document).ready(function(){
    $('.close').click(function(evt) {
        var modal_id = $(this).parent().attr('id');
        var modal = document.getElementById(modal_id);
        modal.style.display = "none";
    });
    
    $('.modal-img').each(function () {  
        // Get the image and insert it inside the modal - use its "alt" text as a caption
        var img_id = $(this).attr('id');
        var modal_id = $(this).next().attr('id');
        var content_id = $(this).next().find('.modal-content').attr('id');
        var caption_id = $(this).next().find('.modal-caption').attr('id');
        var close_id = $(this).next().find('.close').attr('id');
        
        var img = document.getElementById(img_id);
        var modal = document.getElementById(modal_id);
        var modalImg = document.getElementById(content_id);
        var captionText = document.getElementById(caption_id);
        var close = document.getElementById(close_id);
        
        img.onclick = function(){
            modal.style.display = "block";
            modalImg.src = this.src;
            captionText.innerHTML = this.alt;
        }
        
        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks on <span> (x), close the modal
        span.onclick = function() { 
            modal.style.display = "none";
        }
        
    });
    
});