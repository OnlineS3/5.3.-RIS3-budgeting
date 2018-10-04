
<?php 

include 'php-src/forms/table_form.php';
include 'php-src/onlineS3/db_connector/connection.php';
$conn = conn_db();
include 'php-src/onlineS3/db_connector/exec_sql.php';
include 'php-src/onlineS3/gen_fun/form_fun.php';
include 'php-src/handler/post_events.php';
include 'php-src/db_func/load_dt.php';

include 'php-src/onlineS3/gen_fun/array_fun.php';
include 'php-src/onlineS3/gen_fun/str_fun.php';

echo "<h2>RIS Budgeting</h2>";

include 'steps.php';



//$user_id=1;

include 'input.php';

include 'summary.php';

include 'charts.php';