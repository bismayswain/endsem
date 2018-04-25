<?php

   $details = new SQLite3('acc_det.db');
	$db = new SQLite3('mysqlitedb.db');
	//echo "$name $email $address $mobile $acc $pass";
	$check="SELECT * FROM data WHERE email='$email'";
	$check2=$db->query($check);
	//echo "aaa";
	$final=$check2->fetchArray();
	//echo "$final";
	//echo "bbb";
	if($final)
	{
		
		echo "Already Registered";
	}
	else
	{
		//echo "noth";
		$check_acc="SELECT * FROM info WHERE acc='$acc' AND password='$pass'";
		//echo "$check_acc";			
		$check_acc2=$details->query($check_acc);
	
		//echo "dbee";
		$final_acc= $check_acc2->fetchArray();
		//echo "jfkbvkjr";
		//echo "$final_acc";
		if(!$final_acc)
		{
			
			echo"Either username or password is incorrect";
		}
		else
		{
			if($final_acc[2]>1000)
			{
				$val=$final_acc[2]-1000;
				//echo "$val";
				$x=gettype ( $val );
				//echo "$x";
				$details->query("UPDATE info SET balance = $val WHERE acc='$acc' AND password='$pass'");
				$qstr = "insert into data values ('$name', '$address', '$email', '$mobile','$acc','$pass')";
	  		$insres = $db->query($qstr);
				echo "Registration Successful";
			}
			else
			{
				echo "Insufficient Balance";
			}
		}
	}
?>

