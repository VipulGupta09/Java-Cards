<%
	if ((session.getAttribute("role") == null) || (session.getAttribute("role") == "")) {
		out.println("");
	} else {
		if(session.getAttribute("role").equals("admin"))
		{
			response.sendRedirect("admin.jsp");
		} 
		else 
		{
			if(session.getAttribute("role").equals("library"))
			{
			response.sendRedirect("library.jsp");
			}
			else
			{
				response.sendRedirect("user.jsp");
			}
		}
	}
%>

<!DOCTYPE html>
<html>

<head>
  <!-- Meta, title, CSS, favicons, etc. -->
  <meta charset="utf-8">
  <title>UNIFID CARD SYSTEMS - ID Card Portal</title>
  <meta name="keywords" content="" />
  <meta name="description" content="">
  <meta name="author" content="Shubham Gupta">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Font CSS (Via CDN) -->
  <link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700'>

  <!-- Theme CSS -->
  <link rel="stylesheet" type="text/css" href="assets/skin/default_skin/css/theme.css">
  <link rel="stylesheet" type="text/css" href="assets/skin/default_skin/css/theme2.css">
  <link rel="stylesheet" type="text/css" href="assets/skin/default_skin/css/theme3.css">

  <!-- Admin Forms CSS -->
  <link rel="stylesheet" type="text/css" href="assets/admin-tools/admin-forms/css/admin-forms.css">

  <!-- Favicon -->
  <link rel="shortcut icon" href="assets/img/atat-logo.ico">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
   <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
   <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
   <![endif]-->
</head>

<body class="external-page external-alt sb-l-c sb-r-c">

  <!-- Start: Main -->
  <div id="main" class="animated fadeIn">

    <!-- Start: Content-Wrapper -->
    <section id="content_wrapper">

      <!-- Begin: Content -->
      <section id="content">

        <div class="admin-form theme-info mw320" id="login">

          <!-- Login Panel/Form -->
          <div class="panel mt30 mb25">

              <!-- Login Logo -->
              <div class="row table-layout">
                <a title="ATAT Consultancy Services">
                  <img src="assets/img/logos/cardlogo.png" title="UNIFID CARD SYSTEMS" class="center-block img-responsive" draggable="false">
                </a>
              </div>

            <form action="authenticate.jsp" method="post" id="admin-form">
              <div class="panel-body bg-light p25 pb15">

                <!-- Username Input -->
                <div class="section">

                  <label for="username" class="field prepend-icon">
                    <input type="text" name="emp_id" id="emp_id" class="gui-input" placeholder="Employee ID" required="true">
                    <label for="username" class="field-icon">
                      <i class="fa fa-user"></i>
                    </label>
                  </label>
                </div>

                <!-- Password Input -->
                <div class="section">

                  <label for="password" class="field prepend-icon">
                    <input type="password" name="password" id="password" class="gui-input" placeholder="Password" required="true">
                    <label for="password" class="field-icon">
                      <i class="fa fa-lock"></i>
                    </label>
                  </label>
                </div>
	
<%
	if((request.getParameter("err")==null) || (request.getParameter("err")=="")) {
		out.println("");
	} else {
		if(request.getParameter("err").equals("empid")) { %>
        	<div class="section">
                <div class="alert alert-micro alert-border-left alert-danger pastel alert-dismissable mn">
                	<button type="button" class="close" data-dismiss="alert" aria-hidden="true"><i class="fa fa-times"></i></button>
                	<i class="fa fa-thumbs-down pr10"></i>Invalid Employee ID !
                </div>
            </div>
        <% } else if(request.getParameter("err").equals("pwd")) { %>
        	<div class="section">
                <div class="alert alert-micro alert-border-left alert-warning pastel alert-dismissable mn">
                	<button type="button" class="close" data-dismiss="alert" aria-hidden="true"><i class="fa fa-times"></i></button>
                  	<i class="fa fa-warning pr10"></i>Incorrect Password !
                </div>
            </div>
        <% } else {
				response.sendRedirect("index.jsp");
		}
	}
%>
    
                <div class="section">
                	<center><button type="submit" class="btn btn-primary btn-rounded ph40" onClick="submit()">LOGIN</button></center>
                </div>
                
               </div>

            </form>
          </div>

          <!-- Registration Links -->
          <div class="login-links">
            <p>
              <a href="forgotpassword.jsp?empid=<%=request.getParameter("emp_id")%>" class="active"><i class="fa fa-key"></i> Forgot Password?</a
			</p>
            <p><a>&copy; UNIFID CARD SYSTEMS</a>
            	| All Rights Reserved.
            </p>
          </div>

        </div>

      </section>
      <!-- End: Content -->

    </section>
    <!-- End: Content-Wrapper -->

  </div>
  <!-- End: Main -->


  <!-- BEGIN: PAGE SCRIPTS -->

  <!-- jQuery -->
  <script src="vendor/jquery/jquery-1.11.1.min.js"></script>
  <script src="vendor/jquery/jquery_ui/jquery-ui.min.js"></script>

  <!-- Theme Javascript -->
  <script src="assets/js/utility/utility.js"></script>
  <script src="assets/js/demo/demo.js"></script>
  <script src="assets/js/main.js"></script>

  <!-- Page Javascript -->
  <script type="text/javascript">
  jQuery(document).ready(function() {

    "use strict";

    // Init Theme Core      
    Core.init();

    // Init Demo JS
    Demo.init();

  });
  </script>

  <!-- END: PAGE SCRIPTS -->

</body>

</html>
