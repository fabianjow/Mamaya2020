﻿<?php 
// Detect the current session
session_start();
// Create a container, 60% width of viewport
$MainContent = "<div style='width:60%; margin:auto;'>";
// Display Page Header - 
// Category's name is read from query string passed from previous page.
$MainContent .= "<div class='row' style='padding:5px'>";
$MainContent .= "<div class='col-12'>";
$MainContent .= "<span class='page-title'>$_GET[catName]</span>";
$MainContent .= "</div>";
$MainContent .= "</div>";

// Include the PHP file that establishes database connection handle: $conn
include_once("mysql_conn.php"); 

// To Do:  Starting ....
$cid=$_GET["cid"]; // Read Category ID from query string
// Form SQL to retrieve list of products associated to the Category ID
$qry = "SELECT p.ProductID, p.ProductTitle, p.ProductImage, p.Price, p.Quantity
        FROM CatProduct cp INNER JOIN product p ON cp.ProductID=p.ProductID
        WHERE cp.CategoryID=?";
$stmt = $conn->prepare($qry);
$stmt->bind_param("i", $cid); // "i" - integer
$stmt->execute();
$result = $stmt->get_result();
$stmt->close();

// Display each product in a row
while ($row = $result->fetch_array()){
    
    //start a new row
    $MainContent .= "<div class='row' style='padding:5px'>";

    //Left column - display a text link showing the product's name,
    //              diaply the selling price in red in a new paragraph 
    $product =  "productDetails.php?pid=$row[ProductID]";
    $formattedPrice = number_format($row["Price"], 2);
    $MainContent .= "<div class='col-8'>"; //67% of row width
    $MainContent .= "<p><a href=$product>$row[ProductTitle]</a></p>";
    $MainContent .= "Price:<span style='font-weight: bold; color: red;'>
                     S$ $formattedPrice</span>";
    $MainContent .= "</div>";

    // Right column - display the product's image
    $img = "./Images/products/$row[ProductImage]";
    $MainContent .= "<div class='col-4'>"; //33% of row width 
    $MainContent .= "<img src=$img />";
    $MainContent .= "</div>";

    // End of a row
    $MainContent .= "</div>";
}

// To Do:  Ending ....

$conn->close(); // Close database connnection
$MainContent .= "</div>"; // End of container
include("MasterTemplate.php");  
?>
