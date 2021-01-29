<?php
// Detect the current session
session_start();
$MainContent = "";


// Reading inputs entered in previous page
$email = $_POST["email"];
$pwd = $_POST["password"];
$checkLogin = FALSE;
// To Do 1 (Practical 2): Validate login credentials with database
//Include the PHP file that establishes database connection handle: $conn
include_once("mysql_conn.php");

$qry = "SELECT * FROM Shopper WHERE Email=? ";
$stmt = $conn->prepare($qry);
$stmt -> bind_param("s", $email); // "s" - string
$stmt->execute();
$result = $stmt->get_result();
$stmt->close();

if ($result->num_rows > 0){
	$row = $result->fetch_array();
	$hashed_pwd = $row["Password"];
	if (password_verify($pwd, $hashed_pwd)) {
		$checkLogin = TRUE;
		// Save user's info in session variables
		$_SESSION["ShopperName"] = $row["Name"];
		$_SESSION["ShopperID"] = $row["ShopperID"];
	
	
		// To Do 2 (Practical 4): Get active shopping cart
		//$shopperid = $_SESSION["ShopperID"];
		//$shopCartid = $_SESSION["Cart"];
		$qry = "SELECT sc.ShopCartID FROM ShopCart sc 
				INNER JOIN ShopCartItem sci ON sc.ShopCartID=sci.ShopCartID 
				WHERE sc.ShopperID=? AND sc.OrderPlaced=0";
		$stmt = $conn->prepare($qry);
		$stmt -> bind_param("i",$_SESSION["ShopperID"]);
		$stmt->execute();
		$result1 = $stmt->get_result();
		$stmt->close();
		
		if($result1->num_rows >= 1){
			
			$row1 = $result1->fetch_array();
			$_SESSION["Cart"] = $row1["ShopCartID"];
			$_SESSION["NumCartItem"] = $result1->num_rows;		
			
		}
		
		
	}
	else {
		$MainContent = "<h3 style='color:red'>Invalid Login Credentials - <br /> 
						password is not correct!</h3>";
		}
}
else 	{
	$MainContent = "<h3 style='color:red'>Invalid Login Credentials - <br />
					email address not found!</h3>";
}



//if (($email == "ecader@np.edu.sg") && ($pwd == "password")) {
	// Save user's info in session variables
//	$_SESSION["ShopperName"] = "Ecader";
//	$_SESSION["ShopperID"] = 1;
//	echo "You are a valid user.";
	
	// To Do 2 (Practical 4): Get active shopping cart
	
	// Redirect to home page
//	header("Location: index.php");
//	exit;
//}
//else {
	//$MainContent = "<h3 style='color:red'>Invalid Login Credentials</h3>";
//}
	
//close database connection
$conn->close();

if ($checkLogin == TRUE){
	header("Location: index.php");
	exit;
}
//Include the master template file for this page
include("MasterTemplate.php");
?>