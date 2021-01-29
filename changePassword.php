<script type="text/javascript">
function validateForm()
{
    // Check if password matched
	if (document.changePwd.pwd1.value != document.changePwd.pwd2.value) {
 	    alert("Passwords not matched!");
        return false;   // cancel submission
    }
    return true;  // No error found
}
</script>

<?php
// Detect the current session
session_start();
// To Do 1: Check if user logged in 
if (!isset($_SESSION["ShopperID"])) {
	// redirect to login page if the session variable shopperid is not set
	header ("Location: login.php");
	exit;
}
// End of To Do 1

$MainContent = "<div style='width:80%; margin:auto;'>";
$MainContent .= "<form name='changePwd' method='post' 
                       onsubmit='return validateForm()'>";
$MainContent .= "<div class='form-group row'>";
$MainContent .= "<div class='col-sm-9 offset-sm-3'>";
$MainContent .= "<span class='page-title'>Change Password</span>";
$MainContent .= "</div>";
$MainContent .= "</div>";
$MainContent .= "<div class='form-group row'>";
$MainContent .= "<label class='col-sm-3 col-form-label' for='pwd1'>
                 New Password:</label>";
$MainContent .= "<div class='col-sm-9'>";
$MainContent .= "<input class='form-control' name='pwd1' id='pwd1' 
                        type='password' required />";
$MainContent .= "</div>";
$MainContent .= "</div>";
$MainContent .= "<div class='form-group row'>";
$MainContent .= "<label class='col-sm-3 col-form-label' for='pwd2'>
                 Retype Password:</label>";
$MainContent .= "<div class='col-sm-9'>";
$MainContent .= "<input class='form-control' name='pwd2' id='pwd2'
                        type='password' required />";
$MainContent .= "</div>";
$MainContent .= "</div>";
$MainContent .= "<div class='form-group row'>";       
$MainContent .= "<div class='col-sm-9 offset-sm-3'>";
$MainContent .= "<button type='submit'>Update</button>";
$MainContent .= "</div>";
$MainContent .= "</div>";
$MainContent .= "</form>";

// Process after user click the submit button
if (isset($_POST['pwd1'])) {
	// To Do 2: Read new password entered by user
	$new_pwd = $_POST["pwd1"];
	
	// To Do 3: Hash the default password
	$hashed_pwd = password_hash($new_pwd, PASSWORD_DEFAULT);
	
	// To Do 4: Update the new password hash
    include_once("mysql_conn.php");
    $qry = "UPDATE Shopper 
            SET Password = ?
            WHERE ShopperID = ?";

    $stmt = $conn->prepare($qry);
    $userID = $_SESSION["ShopperID"];
    $stmt->bind_param("si", $hashed_pwd, $userID);
    if($stmt->execute()) {
        $MainContent .= "<p class='text-success'>Password successfully updated!</p>";
    }

    else {
        $MainContent .= "<p class='text-danger'>Error! Something went wrong, please try again!</p>";
    }

    $stmt->close();
    $conn->close();
}

$MainContent .= "</div>";
include("MasterTemplate.php"); 
?>