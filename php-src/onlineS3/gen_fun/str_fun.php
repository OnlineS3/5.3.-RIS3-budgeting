
<?php
    function contains($string, $substring) {
        $pos = strpos($string, $substring);

        if($pos === false) {
            return false;
        }
        else {
            return true;
        }
    }

    function str2array($str) {
        $arr = array();
        $i=$j=$ip=0;
        while(strpos($str,',',$i+1)>0) {
            $i = strpos($str,',',$i+1);
            $arr[$j++] = substr($str,$ip,$i-$ip);
            $ip = $i+1;
        }
        $arr[$j] = substr($str,$ip,$i-$ip);

        return $arr;
    }
?>