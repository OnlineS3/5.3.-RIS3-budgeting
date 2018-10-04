

<aside id='sidebar' class='base-sidebar <?php echo $about_hide ?>'>

<button class="guide" onclick='return openPopup({ url: "pdf/5.3_Budgeting_users_guide.pdf" });'> Download Guide <i class="fa fa-file-pdf-o" aria-hidden="true"></i></button>
		
<div></div>

<?php if (is_user_logged_in()) :
    echo "<a id='tool-btn' class='a-button access-tool' href='#' onclick='setStep('step-1','step-1','auto');'>Access to application <img src='images/access-icon.png' width='20'></a>"; ?>
<?php else : ?>
    <a id='tool-btn' class='a-button access-tool login' href="<?php echo wp_login_url(get_permalink()); ?>">Access to application <img src="images/access-icon.png" width="20"></a>
<?php endif;?>

</aside>