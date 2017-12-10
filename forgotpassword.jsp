		<%@ page import="java.io.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.zip.*" %>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.activation.*"%>
<%
	if(request.getParameter("emp_id")!=null)
	{		
    
	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root","root");
    Statement st = con.createStatement();
	String msg="";
	String password="";
	String email="";
	String name="";
		PreparedStatement stml=con.prepareStatement("select password from login where emp_id=?");
		stml.setString(1,request.getParameter("emp_id"));
		ResultSet rs=stml.executeQuery();
		if(rs.next())
		{
			password=rs.getString(1);
			msg="check your email id for password";
			PreparedStatement stml1=con.prepareStatement("select email,name from employee where emp_id=?");
			stml1.setString(1,request.getParameter("emp_id"));
			ResultSet rs1=stml1.executeQuery();
			rs1.next();
			email=rs1.getString(1);
			name=rs1.getString(2);
		}
		else
		{
			msg="invalid id";
			response.sendRedirect("index.jsp?msg="+msg);
		}
		String result="default";

		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");  
		props.put("mail.smtp.socketFactory.port", "465");  
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");  
		props.put("mail.smtp.auth", "true");  
		props.put("mail.smtp.port", "465");
		
		Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("unifidcardsystem@gmail.com", "unifidcardsystem123");
			}
		});
		
		try {  
			MimeMessage message = new MimeMessage(mailSession);  
			message.setFrom(new InternetAddress("unifidcardsystem@gmail.com"));
			message.addRecipient(Message.RecipientType.TO,new InternetAddress(email));  
			message.setSubject("Login Credentials for UNIFID Card System");  
			message.setContent("<h4>Hello "+name+"!</font></h4><p>Greeting from UNIFID Card System.</p><p>Given below are the details of your account at UNIFID Card Portal -<br>Employee ID : <b>"+request.getParameter("emp_id")+"</b><br>Password : <b>"+password+"</b></p>","text/html");
		
			//send message  
			Transport.send(message);
			result="Success";
			response.sendRedirect("index.jsp?msg="+msg);
		
		} catch (MessagingException mex)
		{
			mex.printStackTrace();
			result="Failed";
			msg="mail can't be send";
			response.sendRedirect("index.jsp?msg="+msg);
		}
	}
		%>
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

            <form action="forgotpassword.jsp" method="post" id="admin-form">
              <div class="panel-body bg-light p25 pb15">

                <!-- Username Input -->
                <div class="section">

                  <label for="username" class="field prepend-icon">
                    <input type="text" name="emp_id" id="emp_id" class="gui-input" placeholder="Student ID" required="true">
                    <label for="username" class="field-icon">
                      <i class="fa fa-user"></i>
                    </label>
                  </label>
                </div>		
		
		  <div class="section">
                	<center><button type="submit" class="btn btn-primary btn-rounded ph40" onClick="submit()">SEND MAIL</button></center>
                </div>
                
               </div>

            </form>
          </div>

          <!-- Registration Links -->
          <div class="login-links">
           
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
