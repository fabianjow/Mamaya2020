<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Mamaya e-Bookstore</title>

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/site.css">
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <a href="index.php">
                    <img src = "Images/mamayaebooks.jpg" alt="Logo" 
                    class="img-fluid" style="width: 100%"/></a>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <?php include("navbar.php"); ?>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12" style="padding:15px;">
                    <?php echo $MainContent; ?>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12" style="tesxt-align: right; ">
                    <hr />
                    Do you need help? Please email to:
                    <a href="mailto:mamaya@np.edu.sg">mamaya@np.edu.sg</a>
                    <p style="font-size:12px">&copy;Copyright by Mamaya Group</p>
            </div>
        </div>
    </body>
    
</html>