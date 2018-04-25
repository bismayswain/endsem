<!DOCTYPE HTML>  
<html>
<head>
<style>
.error {color: #FF0000;}
</style>
</head>
<body>  

	<h2>Show all registrations(Only for admin) </h2>
	<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">  
  username: <input type="text"  name="name" value="<?php echo $user;?>">
  <span class="error"> <?php echo $nameErr;?></span>
  <br><br> 
	Password: <input id="p" type="password" maxlength="20" name="pass" autocomplete="off" value="<?php echo $pass;?>">
  <span id="p_s" class="error"> <?php echo $passErr;?></span>
  <br><br> 
  
  
  <input type="submit" name="submit" value="Submit">  
</form>
<?php
	$db = new SQLite3('mysqlitedb.db');
	$username="admin";
	$password="admin";
	
	$user=test_input($_POST[name]);
	$pass=test_input($_POST[pass]);
	//echo "$user $pass";
	if($username==$user AND $password==$pass)
	{
		
		$results = $db->query("SELECT * FROM data");
		echo "<table >";
  	echo "<tr> <th>Name</th><th>Address</th> <th>email</th><th>Mobile no</th> <th>Acc no</th> </tr>";
 		
	
		while ($row = $results->fetchArray()) 
		{
			//echo "here";
	    echo "<tr><th> $row[0]</th><th>$row[1]</th><th>$row[2]</th><th>$row[3]</th><th>$row[4]</th></tr>";
		}
		echo"</table>";	
	}
	else
	{
		echo "INVALID CREDENTIALS";
	}
	function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
	
}

?>
</body>
</html>
