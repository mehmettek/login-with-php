<?php

include 'conn.php';

$username=$_POST['username'];
$password=$_POST['password'];

 

$queryResult=$connect->query("SELECT * FROM veri WHERE kullanici_adi ='".$username."' and sifre='".$password."'");

 
$result=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;
	
}
echo json_encode($result,JSON_UNESCAPED_UNICODE);
?>