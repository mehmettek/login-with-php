<?php
	
	$connect=new mysqli("localhost","root","","login_php");
	$connect->set_charset("utf8");
	if($connect)
	{
		//echo "Connectin Succces";
}
else
{
	//echo "Connection Failed";
	
	exit();
	
}
?>