function Validate(){

	var name= document.getElementById('name').value;
	var address= document.getElementById('add').value;
	var email= document.getElementById('mail').value;
	var mobile= document.getElementById('mob').value;
	var acc= document.getElementById('a').value;
	var pass= document.getElementById('p').value;
	
	if (name=="")
	{
		document.getElementById('name_s').innerHTML="*Name is required";
		return false;
	}
	else
	{
		document.getElementById('name_s').innerHTML="";
	}
	if (address=="")
	{
		document.getElementById('add_s').innerHTML="*Address is required";
		return false;
	}
else
	{
		document.getElementById('add_s').innerHTML="";
	}
	if (email=="")
	{
		document.getElementById('mail_s').innerHTML="*E-mail is required";
		return false;
	}
	else
	{
		document.getElementById('mail_s').innerHTML="";
	}
	if (mobile=="")
	{
		document.getElementById('mob_s').innerHTML="*Mobile is required";
		return false;
	}
	else
	{
		document.getElementById('mob_s').innerHTML="";
	}
	if (acc=="")
	{
		document.getElementById('a_s').innerHTML="*Account number is required";
		return false;
	}
	else
	{
		document.getElementById('a_s').innerHTML="";
	}
	if (pass=="")
	{
		document.getElementById('p_s').innerHTML="*Password is required";
		return false;
	}
	else
	{
		document.getElementById('p_s').innerHTML="";
	}
	if (!(/^[a-zA-Z ]*$/.test(name)))
	{
		document.getElementById('name_s').innerHTML="*Only Alphabets and spaces are allowed";
		return false;
	}
	else
	{
		document.getElementById('name_s').innerHTML="";
	} 
	if (!(/^[1-9][0-9]*$/.test(mobile)) )
	{
		document.getElementById('mob_s').innerHTML="Invalid mobile number";
		return false;
	}
	
	if (mobile.length!=10)
	{
		document.getElementById('mob_s').innerHTML="Invalid mobile number";
		return false;
	}
	
	if (!(/^[0-9]*$/.test(acc)) || acc.length!=5 )
	{
		document.getElementById('a_s').innerHTML="Invalid account number";
		return false;
	}
	else
	{
		document.getElementById('a_s').innerHTML="";	
	}
	if (!(/^[0-9a-zA-Z]*$/.test(pass)) )
	{
		document.getElementById('p_s').innerHTML="Password can have only alphanumeric characters";
		return false;
	}
	else
	{
		document.getElementById('p_s').innerHTML="";
	}
	if(!(/^[A-Za-z]{1,}[@]{1,1}[A-Za-z]{1,}[.]{1,1}[c]{1,1}[o]{1,1}[m]{1,1}/.test(email)))
	{
		document.getElementById('mail_s').innerHTML="*E-mail is invalid";
		return false;
	}
	else
	{
		document.getElementById('mail_s').innerHTML="";
	}
	
}

