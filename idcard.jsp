<%@ page import ="java.sql.*" %>

<%
	String emp_id="";
	String name="";
	String photo="";
	String designation="";
	String location="";
	String card_no="";
	String bloodgroup="";
	String path="";
	String card_status="";
	String doj = "";
	if ((session.getAttribute("emp_id") == null) || (session.getAttribute("emp_id") == "")) 
	{
		response.sendRedirect("index.jsp");
	}
	else
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root","root");
			Statement st = con.createStatement();
			emp_id=session.getAttribute("emp_id").toString();
			ResultSet rs1;
			PreparedStatement ps1;
			ps1=con.prepareStatement("Select name,photo,card_status,designation,card_no,location,bloodgroup,doj from employee where emp_id=?");
			ps1.setString(1,emp_id);
			rs1=ps1.executeQuery();
			if(rs1.next())
			{
		    	name=rs1.getString("name");
				photo=rs1.getString("photo");
				card_status=rs1.getString("card_status").toUpperCase();
				designation=rs1.getString("designation");
				card_no=rs1.getString("card_no");
				location=rs1.getString("location");
				bloodgroup=rs1.getString("bloodgroup");
				doj=rs1.getString("doj");
				int index=photo.lastIndexOf("\\");
		        path=photo.substring(index+1,photo.length());
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
                  <img src="assets/img/logos/cardlogo.png" title="ATAT Consultancy Services" class="center-block img-responsive" draggable="false">
                </a>
              </div>

            <form action="authenticate.jsp" method="post" id="admin-form">
              <div class="panel-body bg-light p25 pb15">

                <!-- Username Input -->
                <div class="section">
					<center>
						<p>Employee ID : <%=emp_id%><br><br>
						<img src="image/<%=path%>" width="150px" height="175px" style="border-bottom-left-radius:30px;border-bottom-right-radius:30px;"draggable="false"></img><br><br>
						<font style="font-size:24px !important;"><%=name%></font><br>
						<font style="line-height:25px !important;"><%=designation%> Passing Out Year : <%=doj%><br>
						Location : <%=location%><br>
						Blood Group : <%=bloodgroup%></font><br>
						</p>
						
						<div class="alert alert-micro alert-border-left alert-border-right alert-warning pastel alert-dismissable mn">
								<strong>Card No.: <%=card_no%></strong>
						</div>
						
                </div>
                
               </div>

            </form>
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
