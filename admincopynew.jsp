<%@ page import ="java.sql.*" %>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root","root");
	Statement st = con.createStatement();
%>

<%
	String emp_id="";
	String name="";
	String photo="";
	String path="";
	if ((session.getAttribute("emp_id") == null) || (session.getAttribute("emp_id") == "")) 
	{
		response.sendRedirect("index.jsp");
	}
	else
	{
		if (session.getAttribute("role").equals("user")) 
		{
			response.sendRedirect("user.jsp");
		}
		else
		{
			emp_id=session.getAttribute("emp_id").toString();
			ResultSet rs1;
			PreparedStatement ps1;
			ps1=con.prepareStatement("Select name,photo from employee where emp_id=?");
			ps1.setString(1,emp_id);
			rs1=ps1.executeQuery();
			if(rs1.next())
			{
		    	name=rs1.getString("name");
				photo=rs1.getString("photo");
				int index=photo.lastIndexOf("\\");
		        path=photo.substring(index+1,photo.length());
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

<body class="admin-dock-page">

<%
PreparedStatement stml=con.prepareStatement("select ps from p");
ResultSet rs=stml.executeQuery();
rs.next();
PreparedStatement stml2=con.prepareStatement("select * from tempcard");
ResultSet rs2=stml2.executeQuery();

if(rs.getInt(1)==0&&rs2.next())
{
PreparedStatement stml1=con.prepareStatement("update p set ps=?");	
stml1.setInt(1,1);
stml1.executeUpdate();
%>
<script type="text/javascript">
window.open("temp_check.jsp");
</script>
<%}%>
		<!-- Start: Header -->
        <header class="navbar">
        <a href="admin.jsp"><img src="assets/img/logos/logotemp.png" height="25%" style="border-radius:0px !important; margin-top:22px; margin-left:22px;" draggable="false"></img></a>
            
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                	<a href="#" class="dropdown-toggle fw600 p15" data-toggle="dropdown"> <img src="image/<%=path%>" alt="avatar" class="mw30 br64 mr15"> <%=name%>
                    	<span class="caret caret-tp hidden-xs"></span>
                    </a>
                    <ul class="dropdown-menu list-group dropdown-persist w250" role="menu">
                    	<!--<li class="list-group-item">
                        	<a href="changepassword.jsp" class="animated animated-short fadeIn">
	                            <span class="fa fa-unlock-alt"></span> Change Password
                            </a>
                        </li>-->
                        <li class="list-group-item">
                        	<a href="logout.jsp" class="animated animated-short fadeIn">
	                            <span class="fa fa-power-off"></span> Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
            
        </header>
        <!-- End: Header -->

	<!-- Begin: Content -->
	<section id="content" class="animated fadeIn">

		<!-- Begin: Content Header -->
		<div class="content-header">
        
<%
	if((request.getParameter("generate")==null) || (request.getParameter("generate")=="")) { %> 
    
			<h2 style="margin-top:40px; line-height:25px;"> Hello <b class="text-primary">Admin !</b></h2>
			<p class="lead">Welcome to UNIFID Card System</p>
            
       <% } else {
		if(request.getParameter("generate").equals("success")) { 
		
			if((session.getAttribute("g_success")==null) || (session.getAttribute("g_success")=="")){
				response.sendRedirect("admin.jsp");
			}else { %>
            	
                <br>
                <i class="fa fa-check pr10" style="font-size:48px; color:#70ca63;"></i>
                <br>
                <font style="font-size:24px; color:#70ca63;">Card Successfully Generated</font>
                <br><br>
                <a href="admin.jsp" onmouseover='this.style.textDecoration="none"'><i class="fa fa-times pr5"></i>Close</a>
       
	   <% session.setAttribute("g_success","");}} else if(request.getParameter("generate").equals("error")) { 
		
			if((session.getAttribute("g_error")==null) || (session.getAttribute("g_error")=="")){
				response.sendRedirect("admin.jsp");
			}else { %>
            
            	<br>
                <i class="fa fa-warning pr10" style="font-size:48px; color:#e19b0b;"></i>
                <br>
                <font style="font-size:24px; color:#e19b0b;">Card Generation Failed</font>
                <br><br>
                <a href="admin.jsp" onmouseover='this.style.textDecoration="none"'><i class="fa fa-times pr5"></i>Close</a>
            
        <% session.setAttribute("g_error","");}} else {
				response.sendRedirect("admin.jsp");
		}
	}
%>
	
	
    	</div>

        <div class="row animated-delay" data-animate='["500","fadeIn"]'>

          <div class="col-md-10 center-block text-center">

            <div class="row table-layout table-clear-xs">

              <div class="col-xs-12 col-sm-4 br-a br-light bg-light pv20 ph30 va-t">

                <h4 class="micro-header"></h4>
                <div class="row" id="content-type">
           
                  <div class="col-xs-4 col-sm-6">
                    <a class="holder-style p15 mb20 holder-active" href="#registration-form">
                      <span class="fa fa-edit holder-icon"></span>
                      <br> Register Student
                    </a>
                  </div>
                  <div class="col-xs-4 col-sm-6">
                    <a class="holder-style p15 mb20" href="#duplicate-form">
                      <span class="fa fa-exchange holder-icon"></span>
                      <br> Duplicate Card
                    </a>
                  </div>
                  <div class="col-xs-4 col-sm-6">
                    <a class="holder-style p15 mb20" href="#generate-form">
                      <span class="fa fa-check-square-o holder-icon"></span>
                      <br> Generate Card
                    </a>
                  </div>
                  <div class="col-xs-4 col-sm-6">
                    <a class="holder-style p15 mb20" href="#temporary-form">
                      <span class="fa fa-rocket holder-icon"></span>
                      <br> Temporary Card
                    </a>
                  </div>
                  <div class="col-xs-4 col-sm-6">
                    <a class="holder-style p15 mb20" href="#block-form">
                      <span class="fa fa-ban holder-icon"></span>
                      <br> Block Card
                    </a>
                  </div>
                  <div class="col-xs-4 col-sm-6">
                    <a class="holder-style p15 mb20" href="#check-status">
                      <span class="fa fa-print holder-icon"></span>
                      <br> Check Status
                    </a>
                  </div>
				<div class="col-xs-4 col-sm-6">
                    <a class="holder-style p15 mb20" href="#library-form">
                      <span class="fa fa-edit holder-icon"></span>
                      <br> Library Form
                    </a>
                  </div>
                </div>
                <!--<button id="dock-push" type="button" class="btn btn-success fs14 fw600 pv15 btn-block">Send to Admin Dock</button>-->
              </div>

              <div class="col-xs-12 col-sm-8 br-a br-light bg-light dark va-t p10 va-m">

                <div id="dock-content" class="ph20">
                

<!--REGISTRATION FORM-->
	<div id="registration-form" class="active-content">
		<div class="dock-item" data-title="Admin Form">
			<div class="admin-form">
				<div class="panel">
                
<%
	if((request.getParameter("msg")==null) || (request.getParameter("msg")=="")) { %>
					
                    <form method="post" action="registration.jsp" id="admin-form">

						<div class="panel-body bg-light" style="border-radius:0px;">
                        
                        	<b>Register New Student <i class="fa fa-caret-right pr5 pl5"></i> <font color="#1d97fe">Basic Details</font></b><br><br>
							
                            <div class="section-divider mt20 mb40">
                            	<span><strong> BASIC DETAILS </strong></span>
							</div>
                            <!-- .section-divider -->

							<div class="section row">
                            	<div class="col-md-4">
                                	<label for="name" class="field prepend-icon">
                                    	<input type="text" name="name" id="name" class="gui-input" placeholder="Student Name" autocomplete="off" style="border-radius:0px !important">
                                        <label for="name" class="field-icon">
                                        	<i class="fa fa-user"></i>
                                        </label>
                                    </label>
								</div>
                                <div class="col-md-4">
                                	<label for="dob" class="field prepend-icon">
                                    	<input type="text" name="dob" id="datepicker1" class="gui-input" placeholder="DOB (mm-dd-yyyy)" autocomplete="off" style="border-radius:0px !important">
                                        <label for="dob" class="field-icon">
                                        	<i class="fa fa-calendar"></i>
                                        </label>
                                    </label>
								</div>
                                <div class="col-md-4">
                                	<div class="option-group field">
                                    	<label for="male" class="option option-primary block mt10 mb15 ml10" style="float:left;">
                                        	<input type="radio" name="gender" id="male" value="male">
                                            <span class="radio"></span> Male
                                        </label>
                                        <label for="female" class="option block option-primary mt10 mb15" style="float:right;">
                                        	<input type="radio" name="gender" id="female" value="female">
                                            <span class="radio"></span> Female
                                        </label>
                                    </div>
                                </div>
							</div>
                            <!-- end section row section -->
                            
                            <div class="section row">
                            	<div class="col-md-6">
                                	<label for="email" class="field prepend-icon">
                                    	<input type="email" name="email" id="email" class="gui-input" placeholder="Email" autocomplete="off" style="border-radius:0px !important">
                                        <label for="email" class="field-icon">
                                        	<i class="fa fa-envelope"></i>
                                        </label>
                                    </label>
                                </div>
                                <div class="col-md-6">
                                	<label for="mobile" class="field prepend-icon">
                                    	<input type="tel" name="mobile" id="mobile" class="gui-input" placeholder="Mobile Number (10-digit)" autocomplete="off" style="border-radius:0px !important">
                                        <label for="mobile" class="field-icon">
                                        	<i class="fa fa-phone"></i>
                                        </label>
                                    </label>
                                </div>
							</div>
                            <!-- end section row section -->
                            
                            <div class="section row">
                            	<div class="col-md-12">
                                	<label for="address" class="field prepend-icon">
                                    	<input type="text" name="address" id="address" class="gui-input" placeholder="Address" autocomplete="off" style="border-radius:0px !important">
                                        <label for="address" class="field-icon">
                                        	<i class="fa fa-map-marker"></i>
                                        </label>
                                    </label>
                                </div>
                            </div>
                            <!-- end section row section-->
                            
                            <div class="section row">
                            	<div class="col-md-4">
                                	<label for="bloodgroup" class="field prepend-icon">
                                    	<input type="text" name="bloodgroup" id="bloodgroup" class="gui-input" placeholder="Blood Group" autocomplete="off" style="border-radius:0px !important">
                                        <label for="bloodgroup" class="field-icon">
                                        	<i class="fa fa-stethoscope"></i>
                                        </label>
                                    </label>
                                </div>
                                <div class="col-md-4">
                                	<label for="designation" class="field prepend-icon">
                                    	<input type="text" name="designation" id="designation" class="gui-input" placeholder="Course/Branch" autocomplete="off" style="border-radius:0px !important">
                                        <label for="designation" class="field-icon">
                                        	<i class="fa fa-group"></i>
                                        </label>
                                    </label>
                                </div>
                                <div class="col-md-4">
                                	<label for="doj" class="field prepend-icon">
                                    	<input type="text" name="doj" id="datepicker2" class="gui-input" placeholder="Passing Out Year" autocomplete="off" style="border-radius:0px !important">
                                        <label for="doj" class="field-icon">
                                        	<i class="fa fa-calendar-o"></i>
                                        </label>
                                    </label>
                                </div>
							</div>
                            <!-- end section row section-->
                            
                            <div class="section row">
                            	<div class="col-md-4">
                                	<label for="location" class="field select">
                                    	<select id="location" name="location" style="border-radius:0px; color:#626262">
                                        	<option value="" disabled selected>Select Location...</option>
                                            <option value="Ahmedabad">Ahmedabad</option>
                                            <option value="Bangalore">Bangalore</option>
                                            <option value="Baroda">Baroda</option>
                                            <option value="Bhubaneswar">Bhubaneswar</option>
                                            <option value="Chennai">Chennai</option>
                                            <option value="Coimbatore">Coimbatore</option>
                                            <option value="Delhi">Delhi</option>
                                            <option value="Gandhinagar">Gandhinagar</option>
                                            <option value="Goa">Goa</option>
                                            <option value="Gurgaon">Gurgaon</option>
                                            <option value="Hyderabad">Hyderabad</option>
                                            <option value="Jamshedpur">Jamshedpur</option>
                                            <option value="Kochi (Cochin)">Kochi (Cochin)</option>
                                            <option value="Kolkata">Kolkata</option>
                                            <option value="Lucknow">Lucknow</option>
                                            <option value="Mumbai">Mumbai</option>
                                            <option value="Nagpur">Nagpur</option>
                                            <option value="Noida">Noida</option>
                                            <option value="Pune">Pune</option>
                                            <option value="Thiruvananthapuram">Thiruvananthapuram</option>
                                        </select>
                                        <i class="arrow down"></i>
                                    </label>
                                </div>
                                <div class="col-md-8 hidden-xs">
                                	<button type="submit" onClick="submit()" class="button btn-primary gui-input" style="border-radius:0px; margin-bottom:-20px;"> SUBMIT </button>
                                </div>
							</div>
                            <!-- end section row section-->
                        
                        </div>
                        <!-- end .form-body section -->
                        
                    </form>
  <% } else {
		if(request.getParameter("msg").equals("success1")) { 
		
			if((session.getAttribute("user_id")==null) || (session.getAttribute("user_id")=="")){
				response.sendRedirect("admin.jsp");
			}else { %>

			
					<form method="post" enctype="multipart/form-data" action="uploadphoto.jsp" id="admin-form">
                    	
                        <div class="panel-body bg-light" style="border-radius:0px;">
                        	
                            <b>Register New Employee <i class="fa fa-caret-right pr5 pl5"></i> <font color="#70ca63">Basic Details</font> <i class="fa fa-caret-right pr5 pl5"></i> <font color="#1d97fe">Upload Photo</font></b><br><br>
                            
                            <div class="section-divider mt20 mb40">
                            	<span><strong> UPLOAD PHOTO </strong></span>
                            </div>
                            <!-- .section-divider -->
                            
                            <div class="fileupload fileupload-new" data-provides="fileupload">
                            	<div class="fileupload-preview thumbnail mb20">
                                	<!-- <img data-src="holder.js/150x200" alt="holder"> -->
                                	No File Selected
                                </div>
                                <div class="section row">
                                	<div class="col-md-8">
                                    	<span class="btn btn-system btn-file btn-block" style="margin-top:2.5px; background-color:#F90; border:none;">
                                            <span class="fileupload-new">Select File</span>
                                            <span class="fileupload-exists">Change</span>
                                            <input type="file" name="photo" id="photo">
                                        </span>
                                    </div>
                                    <div class="col-md-4">
                                    	<button type="submit" onClick="submit()" class="button btn-primary gui-input" style="border-radius:0px; margin-bottom:-20px;"> REGISTER </button>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                        <!-- end .form-body section -->
                        
                    </form>
                    
        <% }} else if(request.getParameter("msg").equals("error1")) { 
		
			if((session.getAttribute("error")==null) || (session.getAttribute("error")=="")){
				response.sendRedirect("admin.jsp");
			}else { %>
        
			 <div class="panel-body bg-light" style="border-radius:0px; background-color:#F2F2F2;">
            	
                <i class="fa fa-times pr10" style="font-size:48px; color:#c52f17;"></i>
                <br>
                <font style="font-size:24px; color:#c52f17;">Details Submission Failed</font>
                <br><br>
                <a href="admin.jsp" onmouseover='this.style.textDecoration="none"'><i class="fa fa-repeat pr5"></i>Try Again</a>
                
             </div>
            
        <% session.setAttribute("error1","");}} else if(request.getParameter("msg").equals("success2")) { 
		
			if((session.getAttribute("success")==null) || (session.getAttribute("success")=="")){
				response.sendRedirect("admin.jsp");
			}else { %>
        
			 <div class="panel-body bg-light" style="border-radius:0px; background-color:#F2F2F2;">
            	
                <i class="fa fa-check pr10" style="font-size:48px; color:#70ca63;"></i>
                <br>
                <font style="font-size:24px; color:#70ca63;">Employee Successfully Registered</font>
                <br><br>
                <a href="admin.jsp" onmouseover='this.style.textDecoration="none"'><i class="fa fa-home pr5"></i>Home</a>
                
            </div>
        <% session.setAttribute("success","");}} else if(request.getParameter("msg").equals("error2")) { 
		
			if((session.getAttribute("error2")==null) || (session.getAttribute("error2")=="")){
				response.sendRedirect("admin.jsp");
			}else { %>
        
			 <div class="panel-body bg-light" style="border-radius:0px; background-color:#F2F2F2;">
            	
                <i class="fa fa-warning pr10" style="font-size:48px; color:#e19b0b;"></i>
                <br>
                <font style="font-size:24px; color:#e19b0b;">Photo Uploading Failed</font>
                <br><br>
                <a href="admin.jsp?msg=success1" onmouseover='this.style.textDecoration="none"'><i class="fa fa-repeat pr5"></i>Try Again</a>
                
            </div>
        <% session.setAttribute("error2","");}} else {
				response.sendRedirect("admin.jsp");
		}
	}
%>               
                    				
                </div>
			</div>
		</div>
	</div>
<!--REGISTRATION FORM END-->

<!--GENERATE FORM-->
	<div id="generate-form">
		<div class="dock-item" data-title="Admin Form">
			<div class="admin-form">
				<div class="panel">
                
               		<form method="post" action="generatecard.jsp" id="admin-form">

						<div class="panel-body bg-light" style="border-radius:0px;">
							
                            <div class="section-divider mt20 mb40">
                            	<span><strong> GENERATE EMPLOYEE CARD </strong></span>
							</div>
                            <!-- .section-divider -->

							<center>
                            <div class="section row">
                            	<div class="col-md-3">
                                </div>
                            	<div class="col-md-6">

<%
	Statement g_st = con.createStatement();
	ResultSet g_rs = g_st.executeQuery("select emp_id from employee where card_no='Not Available'");
%>
									
                                    <label for="g_user_id" class="field select">
                                    	<select id="g_user_id" name="g_user_id" style="border-radius:0px; color:#626262">
                                        	<option value="" disabled selected>Select Employee ID...</option>
                                            <% while(g_rs.next()) { %>
                                            <option value="<%= g_rs.getString(1)%>"><%= g_rs.getString(1)%></option>
                                            <% } %>
                                        </select>
                                        <i class="arrow down"></i>
                                    </label>
                                </div>
                                <div class="col-md-3">
                                </div>
							</div>
                            <!-- end section row section -->
                            </center>
                            
                            <div class="section row">
                            	<div class="col-md-3">
                                </div>
                            	<div class="col-md-6">
                                	<button type="submit" onClick="submit()" class="button btn-primary gui-input" style="border-radius:0px; margin-bottom:-20px;"> GENERATE </button>
                                </div>
                                <div class="col-md-3">
                                </div>
							</div>
                            <!-- end section row section-->
                            
                        </div>
                        <!-- end .form-body section -->
                        
                    </form>
			
                </div>
			</div>
		</div>
	</div>
<!--GENERATE FORM END-->



<!--CHECK STATUS-->
	<div id="check-status">
    	<div class="dock-item" data-title="Admin Form">
        	<div class="admin-form">
            	<div class="panel">
                	<div class="panel-body bg-light" style="border-radius:0px;">
                    	
                        <a href="report/checkstatus.jsp" target="_blank" onmouseover='this.style.textDecoration="none"'>Click Here</a>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
<!--CHECK STATUS END-->



<!--BLOCK FORM-->
	<div id="block-form">
		<div class="dock-item" data-title="Admin Form">
			<div class="admin-form">
				<div class="panel">
                
               		<form method="post" action="blockcard.jsp" id="admin-form">

						<div class="panel-body bg-light" style="border-radius:0px;">
							
                            <div class="section-divider mt20 mb40">
                            	<span><strong> BLOCK EMPLOYEE CARD </strong></span>
							</div>
                            <!-- .section-divider -->

							<center>
                            <div class="section row">
                            	<div class="col-md-3">
                                </div>
                            	<div class="col-md-6">

<%
	Statement b_st = con.createStatement();
	ResultSet b_rs = b_st.executeQuery("select emp_id from userrequest where action='block'");
%>
									
                                    <label for="b_user_id" class="field select">
                                    	<select id="b_user_id" name="b_user_id" style="border-radius:0px; color:#626262">
                                        	<option value="" disabled selected>Select Employee ID...</option>
                                            <% while(b_rs.next()) { %>
                                            <option value="<%= b_rs.getString(1)%>"><%= b_rs.getString(1)%></option>
                                            <% } %>
                                        </select>
                                        <i class="arrow down"></i>
                                    </label>
                                </div>
                                <div class="col-md-3">
                                </div>
							</div>
                            <!-- end section row section -->
                            </center>
                            
                            <div class="section row">
                            	<div class="col-md-3">
                                </div>
                            	<div class="col-md-6">
                                	<button type="submit" onClick="submit()" class="button btn-primary gui-input" style="border-radius:0px; margin-bottom:-20px;"> BLOCK </button>
                                </div>
                                <div class="col-md-3">
                                </div>
							</div>
                            <!-- end section row section-->
                            
                        </div>
                        <!-- end .form-body section -->
                        
                    </form>
			
                </div>
			</div>
		</div>
	</div>
<!--BLOCK FORM END-->

<!--DUPLICATE FORM-->
	<div id="duplicate-form">
		<div class="dock-item" data-title="Admin Form">
			<div class="admin-form">
				<div class="panel">
                
               		<form method="post" action="duplicatecard.jsp" id="admin-form">

						<div class="panel-body bg-light" style="border-radius:0px;">
							
                            <div class="section-divider mt20 mb40">
                            	<span><strong> ISSUE DUPLICATE CARD </strong></span>
							</div>
                            <!-- .section-divider -->

							<center>
                            <div class="section row">
                            	<div class="col-md-3">
                                </div>
                            	<div class="col-md-6">

<%
	Statement d_st = con.createStatement();
	ResultSet d_rs = d_st.executeQuery("select emp_id from userrequest where action='duplicate'");
%>
									
                                    <label for="d_user_id" class="field select">
                                    	<select id="d_user_id" name="d_user_id" style="border-radius:0px; color:#626262">
                                        	<option value="" disabled selected>Select Employee ID...</option>
                                            <% while(d_rs.next()) { %>
                                            <option value="<%= d_rs.getString(1)%>"><%= d_rs.getString(1)%></option>
                                            <% } %>
                                        </select>
                                        <i class="arrow down"></i>
                                    </label>
                                </div>
                                <div class="col-md-3">
                                </div>
							</div>
                            <!-- end section row section -->
                            </center>
                            
                            <div class="section row">
                            	<div class="col-md-3">
                                </div>
                            	<div class="col-md-6">
                                	<button type="submit" onClick="submit()" class="button btn-primary gui-input" style="border-radius:0px; margin-bottom:-20px;"> ISSUE </button>
                                </div>
                                <div class="col-md-3">
                                </div>
							</div>
                            <!-- end section row section-->
                            
                        </div>
                        <!-- end .form-body section -->
                        
                    </form>
			
                </div>
			</div>
		</div>
	</div>
<!--DUPLICATE FORM END-->

<!--TEMPORARY FORM-->
	<div id="temporary-form">
		<div class="dock-item" data-title="Admin Form">
			<div class="admin-form">
				<div class="panel">
                
               		<form method="post" action="temporarycard.jsp" id="admin-form">

						<div class="panel-body bg-light" style="border-radius:0px;">
							
                            <div class="section-divider mt20 mb40">
                            	<span><strong> ISSUE TEMPORARY CARD </strong></span>
							</div>
                            <!-- .section-divider -->

							<center>
                            <div class="section row">
                            	<div class="col-md-3">
                                </div>
                            	<div class="col-md-6">

<%
	Statement t_st = con.createStatement();
	ResultSet t_rs = t_st.executeQuery("select emp_id from userrequest where action='temporary'");
%>
									
                                    <label for="t_user_id" class="field select">
                                    	<select id="t_user_id" name="t_user_id" style="border-radius:0px; color:#626262">
                                        	<option value="" disabled selected>Select Employee ID...</option>
                                            <% while(t_rs.next()) { %>
                                            <option value="<%= t_rs.getString(1)%>"><%= t_rs.getString(1)%></option>
                                            <% } %>
                                        </select>
                                        <i class="arrow down"></i>
                                    </label>
                                </div>
                                <div class="col-md-3">
                                </div>
							</div>
                            <!-- end section row section -->
                            </center>
                            
                            <div class="section row">
                            	<div class="col-md-3">
                                </div>
                            	<div class="col-md-6">
                                	<button type="submit" onClick="submit()" class="button btn-primary gui-input" style="border-radius:0px; margin-bottom:-20px;"> ISSUE </button>
                                </div>
                                <div class="col-md-3">
                                </div>
							</div>
                            <!-- end section row section-->
                            
                        </div>
                        <!-- end .form-body section -->
                        
                    </form>
			
                </div>
			</div>
		</div>
	</div>
<!--TEMPORARY FORM END-->

<!--Library form-->
		<div id="library-form" class="active-content">
		<div class="dock-item" data-title="Library Form">
			<div class="library-form">
				<div class="panel">
                
					
                    <form method="post" action="registration.jsp" id="library-form">

						<div class="panel-body bg-light" style="border-radius:0px;">
                        
                        	<b>Library Entry Form <i class="fa fa-caret-right pr5 pl5"></i> <font color="#1d97fe">Basic Details</font></b><br><br>
							
                            <div class="section-divider mt20 mb40">
                            	<span><strong> BASIC DETAILS </strong></span>
							</div>
                            <!-- .section-divider -->

							<div class="section row">
                            	<div class="col-md-4">
                                	<label for="book_id" class="field prepend-icon">
                                    	<input type="text" name="book_id" id="book_id" class="gui-input" placeholder="Book ID" autocomplete="off" style="border-radius:0px !important">
                                        <label for="name" class="field-icon">
                                        	<i class="fa fa-user"></i>
                                        </label>
                                    </label>
								</div>
                                <div class="col-md-4">
                                	<label for="emp_id" class="field prepend-icon">
                                    	<input type="text" name="emp_id" id="emp_id" class="gui-input" placeholder="Student ID" autocomplete="off" style="border-radius:0px !important">
                                        <label for="dob" class="field-icon">
                                        	<i class="fa fa-user"></i>
                                        </label>
                                    </label>
								</div>
                               
							</div>
                            <!-- end section row section -->
                            
                           
                            
                            <div class="section row">
                            	<div class="col-md-12">
                                	<label for="book_name" class="field prepend-icon">
                                    	<input type="text" name="book_name" id="book_name" class="gui-input" placeholder="Book Name" autocomplete="off" style="border-radius:0px !important">
                                        <label for="book_name" class="field-icon">
                                        	<i class="fa fa-map-marker"></i>
                                        </label>
                                    </label>
                                </div>
                            </div>
                            <!-- end section row section-->
                            
                        </div>
                        <!-- end .form-body section -->
                        
                    </form>

                  
						</div>
					</div>
				</div>
			</div>
		</div>
        
      </section>
      <!-- End: Content -->
      
  <!-- BEGIN: PAGE SCRIPTS -->
  <div class="content-header">
                <center>
                    <font style="color:#555; font-weight:600;">&copy; UNIFID CARD SYSTEMS</font> | All Rights Reserved.
                </center>
            </div>
  <style> 
  /* demo styles */
  .content-header b,
  .admin-form .panel.heading-border:before,
  .admin-form .panel .heading-border:before {
    transition: all 0.7s ease;
  }
  /* responsive demo styles */
  @media (max-width: 800px) {
    .admin-form .panel-body { padding: 18px 12px; }
  }
  </style>
  
  <!-- jQuery -->
  <script src="vendor/jquery/jquery-1.11.1.min.js"></script>
  <script src="vendor/jquery/jquery_ui/jquery-ui.min.js"></script>
    
  <!-- jQuery Validate Plugin-->
  <script src="assets/admin-tools/admin-forms/js/jquery.validate.min.js"></script>

  <!-- jQuery Validate Addon -->
  <script src="assets/admin-tools/admin-forms/js/additional-methods.min.js"></script>
  
  <!-- AdminForms JS -->
  <script src="assets/admin-tools/admin-forms/js/jquery-ui-monthpicker.min.js"></script>
  <script src="assets/admin-tools/admin-forms/js/jquery-ui-datepicker.min.js"></script>
  <script src="assets/admin-tools/admin-forms/js/jquery.spectrum.min.js"></script>
  <script src="assets/admin-tools/admin-forms/js/jquery.stepper.min.js"></script>
  
  <!-- FileUpload Plugin -->
  <script src="vendor/plugins/fileupload/fileupload.js"></script>
  <script src="vendor/plugins/holder/holder.min.js"></script>

  <!-- Theme Javascript -->
  <script src="assets/js/utility/utility.js"></script>
  <script src="assets/js/demo/demo.js"></script>
  <script src="assets/js/main.js"></script>
  <script type="text/javascript">
  jQuery(document).ready(function() {

	"use strict";
	
	// Init Theme Core    
    Core.init();

    // Init Demo JS     
    Demo.init();
	
	// Demo only javascript. no real use
    var contentType = $('#content-type');
    var Content = $('#dock-content');

    contentType.on('click', '.holder-style', function(e) {
      e.preventDefault();

      var This = $(this);
      var activeContent = This.attr('href');

      // Content button active
      contentType.find('.holder-style').removeClass('holder-active');
      This.addClass('holder-active');

      Content.children('div').removeClass('active-content');
      $(activeContent).addClass('active-content');
    });

    $('#dock-push').on('click', function() {

      var findPush = Content.children('.active-content').find('.dock-item');

      // Admin Dock Plugin
      findPush.dockmodal({
        minimizedWidth: 220,
        height: 430,
        title: function() {
          // note this is a panel specific callback
          // will return undefined if nonexistant
          return this.data('title');
        },
        initialState: "minimized"
      });

    });
	
	$("#datepicker1").datepicker({
      prevText: '<i class="fa fa-chevron-left"></i>',
      nextText: '<i class="fa fa-chevron-right"></i>',
      showButtonPanel: false,
      beforeShow: function(input, inst) {
        var newclass = 'admin-form';
        var themeClass = $(this).parents('.admin-form').attr('class');
        var smartpikr = inst.dpDiv.parent();
        if (!smartpikr.hasClass(themeClass)) {
          inst.dpDiv.wrap('<div class="' + themeClass + '"></div>');
        }
      }
    });
	
	$("#datepicker2").datepicker({
      prevText: '<i class="fa fa-chevron-left"></i>',
      nextText: '<i class="fa fa-chevron-right"></i>',
      showButtonPanel: false,
      beforeShow: function(input, inst) {
        var newclass = 'admin-form';
        var themeClass = $(this).parents('.admin-form').attr('class');
        var smartpikr = inst.dpDiv.parent();
        if (!smartpikr.hasClass(themeClass)) {
          inst.dpDiv.wrap('<div class="' + themeClass + '"></div>');
        }
      }
    });
	
	$("#admin-form").validate({

      /* @validation states + elements 
      ------------------------------------------- */

      errorClass: "state-error",
      validClass: "state-success",
      errorElement: "em",

      /* @validation rules 
      ------------------------------------------ */

      rules: {
        name: {
          required: true
        },
		dob: {
          required: true
        },
		gender: {
          required: true
        },
        email: {
          required: true
        },
		mobile: {
          required: true,
		  minlength: 10,
          maxlength: 10
        },
		address: {
          required: true
        },
		designation: {
          required: true
        },
		doj: {
          required: true
        },
		location: {
          required: true
        },
		bloodgroup: {
          required: true
        },
		photo: {
          required: true,
          extension: "jpg|png|gif|jpeg"
        }

      },

      /* @validation error messages 
      ---------------------------------------------- */

      messages: {
        name: {
          required: 'Enter employee name'
        },
		dob: {
          required: 'Enter date of birth'
        },
		gender: {
          required: 'Choose gender'
        },
        email: {
          required: 'Enter email'
        },
		mobile: {
          required: 'Enter mobile number',
		  minlength: 'Mobile number can not have less than 10 digits',
		  maxlength: 'Mobile number can not have more than 10 digits'
        },
		address: {
          required: 'Enter address'
        },
		designation: {
          required: 'Enter designation'
        },
		doj: {
          required: 'Enter date of joining'
        },
		location: {
          required: 'Enter location'
        },
		bloodgroup: {
          required: 'Enter blood group'
        },
		photo: {
          required: 'Upload employee photo',
          extension: 'File format not supported'
        }

      },

      /* @validation highlighting + error placement  
      ---------------------------------------------------- */

      highlight: function(element, errorClass, validClass) {
        $(element).closest('.field').addClass(errorClass).removeClass(validClass);
      },
      unhighlight: function(element, errorClass, validClass) {
        $(element).closest('.field').removeClass(errorClass).addClass(validClass);
      },
      errorPlacement: function(error, element) {
        if (element.is(":radio") || element.is(":checkbox")) {
          element.closest('.option-group').after(error);
        } else {
          error.insertAfter(element.parent());
        }
      }

    });

  });
  </script>
  <!-- END: PAGE SCRIPTS -->

</body>

</html>
