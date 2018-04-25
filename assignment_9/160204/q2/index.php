
<!DOCTYPE HTML>  
<html>
<head>
<style>
.error {color: #FF0000;}
</style>
</head>
<body>  

<?php
// define variables and set to empty values
$nameErr = $addressErr = $emailErr = $mobileErr = $accErr = $passErr ="";
$name = $address = $email = $mobile = $acc = $pass ="";
$db = new SQLite3('mysqlitedb.db');
$db->query("create table data(name varchar(20),address varchar(100),email varchar(100),mobile varchar(10),acc varchar(5),password varchar(20))");
$details = new SQLite3('acc_det.db');

//table variables are acc,password,balance



if ($_SERVER["REQUEST_METHOD"] == "POST") {
$name = test_input($_POST["name"]);
$address = test_input($_POST["address"]);
$email = test_input($_POST["email"]);
$mobile = test_input($_POST["mobile"]);
$acc = test_input($_POST["acc"]);
$pass = test_input($_POST["pass"]);
	//echo "$name $email $address $mobile $acc $pass";
	$check="SELECT * FROM data WHERE email='$email'";
	$check2=$db->query($check);
	//echo "aaa";
	$final=$check2->fetchArray();
	//echo "$final";
	//echo "bbb";
	/*if($final)
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
	}*/
	include ('part.php');

}


function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
	
}

?>



 

<h2>Let's Build Stuff</h2>
<p><span class="error">* required field.</span></p>
<form method="post" onsubmit="return Validate()" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">  
  Name: <input id="name" type="text" maxlength="20" name="name" value="<?php echo $name;?>">
  <span id="name_s" class="error">* <?php echo $nameErr;?></span>
  <br><br>
	Address: <textarea id="add" name="address" maxlength="100" rows="4" cols="25" value="<?php echo $address;?>"><?php echo $address;?></textarea>
	<span id="add_s" class="error">* <?php echo $addressErr;?></span>
	<br><br>
  E-mail: <input id="mail" type="text" name="email" value="<?php echo $email;?>">
  <span id="mail_s" class="error">* <?php echo $emailErr;?></span>
  <br><br>
  Mobile: <input id="mob" type="text" name="mobile" value="<?php echo $mobile;?>">
  <span id="mob_s" class="error">* <?php echo $mobileErr;?></span>
  <br><br>
	Bank Account no: <input id="a" type="text"  name="acc" value="<?php echo $acc;?>">
  <span id="a_s" class="error">* <?php echo $accErr;?></span>
  <br><br> 
	Password: <input id="p" type="password" maxlength="20" name="pass" value="<?php echo $pass;?>">
  <span id="p_s" class="error">* <?php echo $passErr;?></span>
  <br><br> 
  
  
  <input type="submit" name="submit" value="Submit">  
</form>

<script src="validate.js"></script>
<br><br>
<a href="admin.php">Show all registrations</a>
<br><br>
<a href="index.php">Another registration</a>

<!--<?php
 include('admin.php');
?>-->


<?php
echo "<h2>Your Input:</h2>";
echo $name;
echo "<br>";
echo $address;
echo "<br>";
echo $email;
echo "<br>";
echo $mobile;
echo "<br>";
echo $acc;
?>

</body>
</html>

