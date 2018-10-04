
<?php
    
    include 'php-src/onlineS3/classes/PHPExcel/Classes/PHPExcel.php'; // ston isidwro
    
    function deleteDir($dirPath) {
        if (! is_dir($dirPath)) {
            throw new InvalidArgumentException("$dirPath must be a directory");
        }
        if (substr($dirPath, strlen($dirPath) - 1, 1) != '/') {
            $dirPath .= '/';
        }
        $files = glob($dirPath . '*', GLOB_MARK);
        foreach ($files as $file) {
            if (is_dir($file)) {
                deleteDir($file);
            } else {
                unlink($file);
            }
        }
        rmdir($dirPath);
    }
    
    function get_files_by_dir($dir) {
        $content = scandir($dir);
        $filenames = array();
        $z=$y=0;
        
        for ($i=0; $i<count($content); $i++) {
            if ($content[$i] != '.' and $content[$i] != '..') {
                $current = $dir . '/' . $content[$i];
                
                if (is_dir($current)) {
                    
                    $files = scandir($current);

                    if(count($files) > 0) {
                        for($j=1; $j<count($files); $j++) {
                            
                            $file = $files[$j];
                            if ($file != '..') {
                                $filenames[$z]['name'] = $file;
                                $filenames[$z]['path'] = $current . '/' . $file; // ston isidwro
                                $filenames[$z++]['var'] = $file;
                            }
                        }
                    } 
                } else {
                    if ($current != '..') {
                        $filenames[$z]['name'] = $content[$i];
                        $filenames[$z]['path'] = $current;
                        $filenames[$z++]['var'] = $content[$i];
                    }
                }
            }
        }
        return $filenames;
    }

    function unzip_file($zip_name, $unzip_dir) {
        $zip = new ZipArchive;
        
        if ($zip->open($zip_name) === true) {
            for($i = 0; $i < $zip->numFiles; $i++) {
                $filename = $zip->getNameIndex($i);
                if(strpos($filename, 'Data')>0) {
                    $new_name = pathinfo($zip_name, PATHINFO_FILENAME) . '.csv';
                    if(!$zip->renameName($filename,$new_name)) {
                        echo '<br>' . $filename . ' not renamed.';
                    }
                } 
            }                   
            $zip->extractTo($unzip_dir);
            $zip->close();               
        } else {
            return false;
        }
        
        return true;
    }
    
    function checkCopy($zip_name, $unzip_dir){
        if(!@copy($zip_name,$unzip_dir))
        {
            $errors= error_get_last();
            echo "COPY ERROR: ".$errors['type'];
            echo "<br />\n".$errors['message'];
                return false;
        } else {
            return true;
        }
    }
    
    // converts csv file to array
    function csv2array($file) {
        $rows = 0;
        $csv_array = array();

        // gets the file pointer
        if (($handle = fopen($file, "r")) !== FALSE) {
            // reads each line of csv
            while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
                // number of cols
                $cols = count($data);

                // fills array
                for ($c=0; $c < $cols; $c++) {
                    $csv_array[$rows][$c] = $data[$c];
                }
                $rows++;
            }
            fclose($handle);
        }

        $csv = array('csv_array'=>$csv_array, 'rows'=>$rows-1, 'cols'=>$cols);
        return $csv;
    }
    
    // converts xls to csv file 
    // ston isidwro
    function xls2csv($xls_file, $excel_dir) {
        
        try {
            $ext = pathinfo($xls_file, PATHINFO_EXTENSION);
            $file_name = pathinfo($xls_file, PATHINFO_FILENAME);
            $file_type = ($ext=='xls') ? 'Excel5' : 'Excel2007';

            // Open Excel file using PHPExcel IOFactory
            $objReader = PHPExcel_IOFactory::createReader($file_type);
            $objReader->setReadDataOnly(true);   
            $objPHPExcel = $objReader->load($xls_file);

            // create a CSV File Writer
            $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'CSV');

            // Save xls as csv
            $out_file = $excel_dir . '/' . $file_name . '.csv';
            $objWriter->save($out_file);
        } catch (Exception $ex) {
             return $ex->getMessage();  
        }
        
        return $csv_file;
    }
    
    
   

?>