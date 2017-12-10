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
	if ((session.getAttribute("emp_id") == null) || (session.getAttribute("emp_id") == "")) 
	{
		response.sendRedirect("index.jsp");
	}
	else
	{
		if (session.getAttribute("role").equals("admin")) 
		{
			response.sendRedirect("admin.jsp");
		}
		else
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root","root");
			Statement st = con.createStatement();
			emp_id=session.getAttribute("emp_id").toString();
			ResultSet rs1;
			PreparedStatement ps1;
			ps1=con.prepareStatement("Select name,photo,card_status,designation,card_no,location,bloodgroup from employee where emp_id=?");
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
	if((request.getParameter("msg")==null) || (request.getParameter("msg")=="")) { %> 
    
			<h2 style="margin-top:40px; line-height:25px;"> Hello <b class="text-primary"><%=name%> !</b></h2>
			<p class="lead">Welcome to UNIFID Card System</p>
            
       <% } else {
		if(request.getParameter("msg").equals("accessdenied")) { 
		
			if((session.getAttribute("accessdenied")==null) || (session.getAttribute("accessdenied")=="")){
				response.sendRedirect("user.jsp");
			}else { %>
            	
                <br>
                <i class="fa fa-ban pr10" style="font-size:48px; color:#ff0000;"></i>
                <br>
                <font style="font-size:24px; color:#ff0000">Access Denied! Card Not Generated Yet.</font>
                <br><br>
                <a href="user.jsp" onmouseover='this.style.textDecoration="none"'><i class="fa fa-times pr5"></i>Close</a>
       
	   <% session.setAttribute("accessdenied","");}} else if(request.getParameter("msg").equals("blocksuccess") || request.getParameter("msg").equals("duplicatesuccess") || request.getParameter("msg").equals("temporarysuccess")) { 
		
			if((session.getAttribute("successvalid")==null) || (session.getAttribute("successvalid")=="")){
				response.sendRedirect("user.jsp");
			}else { %>
            
            	<br>
                <i class="fa fa-check pr10" style="font-size:48px; color:#70ca63;"></i>
                <br>
                <font style="font-size:24px; color:#70ca63;">Success! Your request has been successfully logged.</font>
                <br><br>
                <a href="user.jsp" onmouseover='this.style.textDecoration="none"'><i class="fa fa-times pr5"></i>Close</a>
            
        <% session.setAttribute("successvalid","");}} else if(request.getParameter("msg").equals("blockerror") || request.getParameter("msg").equals("duplicateerror") || request.getParameter("msg").equals("temporaryerror")) { 
		
			if((session.getAttribute("errorvalid")==null) || (session.getAttribute("errorvalid")=="")){
				response.sendRedirect("user.jsp");
			}else { %>
            
            	<br>
                <i class="fa fa-times pr10" style="font-size:48px; color:#ff0000;"></i>
                <br>
                <font style="font-size:24px; color:#ff0000;">Failed! Your request can't be logged now.</font>
                <br><br>
                <a href="user.jsp" onmouseover='this.style.textDecoration="none"'><i class="fa fa-repeat pr5"></i>Try Again</a>
            
        <% session.setAttribute("errorvalid","");}} else if(request.getParameter("msg").equals("alreadyblock") || request.getParameter("msg").equals("alreadyduplicate") || request.getParameter("msg").equals("alreadytemporary")) { 
		
			if((session.getAttribute("alreadyexist")==null) || (session.getAttribute("alreadyexist")=="")){
				response.sendRedirect("user.jsp");
			}else { %>
            
            	<br>
                <i class="fa fa-warning pr10" style="font-size:48px; color:#e19b0b;"></i>
                <br>
                <font style="font-size:24px; color:#e19b0b;">Wait! You already have a <span style="color:#000;"><%=session.getAttribute("requesttype")%></span> request pending.</font>
                <br><br>
                <a href="user.jsp" onmouseover='this.style.textDecoration="none"'><i class="fa fa-arrow-left pr5"></i>Back</a>
            
        <% session.setAttribute("alreadyexist","");}} else {
				response.sendRedirect("user.jsp");
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
                    <a class="holder-style p15 mb20" href="#library-form">
                      <span class="fa fa-print holder-icon"></span>
                      <br> Issue Book
                    </a>
                  </div>
                  
				  
                  
				  
                </div>
                <!--<button id="dock-push" type="button" class="btn btn-success fs14 fw600 pv15 btn-block">Send to Admin Dock</button>-->
              </div>

              <div class="col-xs-12 col-sm-8 br-a br-light bg-light dark va-t p10 va-m">

                <div id="dock-content" class="ph20">
                


<!--Canteen FORM END-->
				
<!--Library Form start-->
<div id="library-form" class="active-content">
    	<div class="dock-item" data-title="Admin Form">
        	<div class="admin-form">
            	<div class="panel">
				
				 <form method="post" action="libraryform.jsp" id="admin-form">

						<div class="panel-body bg-light" style="border-radius:0px;">
                        
                        	<b>ISSUE LIBRARY BOOK <i class="fa fa-caret-right pr5 pl5"></i> <font color="#1d97fe">Basic Details</font></b><br><br>
							
                            <div class="section-divider mt20 mb40">
                            	<span><strong> BASIC DETAILS </strong></span>
							</div>
                            <!-- .section-divider -->

							<div class="section row">
                            	<div class="col-md-4">
                                	<label for="name" class="field prepend-icon">
                                    	<input type="text" name="stu_id" id="name" class="gui-input" placeholder="Student ID" autocomplete="off" style="border-radius:0px !important">
                                        <label for="name" class="field-icon">
                                        	<i class="fa fa-user"></i>
                                        </label>
                                    </label>
								</div>
								<div class="col-md-4">
                                	<label for="name" class="field prepend-icon">
                                    	<input type="text" name="book_id" id="name" class="gui-input" placeholder="Book ID" autocomplete="off" style="border-radius:0px !important">
                                        <label for="name" class="field-icon">
                                        	<i class="fa fa-user"></i>
                                        </label>
                                    </label>
								</div>
								 <div class="col-md-4">
                                	<label for="doi" class="field prepend-icon">
                                    	<input type="text" name="doi" id="datepicker3" class="gui-input" placeholder="Date of issue" autocomplete="off" style="border-radius:0px !important">
                                        <label for="doi" class="field-icon">
                                        	<i class="fa fa-calendar"></i>
                                        </label>
                                    </label>
                                </div>
							</div>
							<div class="col-md-8 hidden-xs">
                                	<button type="submit" onClick="submit()" class="button btn-primary gui-input" style="border-radius:0px; margin-bottom:-20px;"> SUBMIT </button>
                                </div>
							<div class="col-md-4">
                                	<input type="text" value="<%=request.getParameter("bmsg")%>">
                                </div>	
								 
						</div>
					</form>
                	
                </div>
            </div>
        </div>
    </div>
<!--Library FORM END-->





                  
						</div>
					</div>
				</div>
			</div>
		</div>
        
            <div class="content-header">
                <center>
                    <font style="color:#555; font-weight:600;">&copy; UNIFID CARD SYSTEMS</font> | All Rights Reserved.
                </center>
            </div>

      </section>
      <!-- End: Content -->
      
  <!-- BEGIN: PAGE SCRIPTS -->
  
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
	$("#datepicker3").datepicker({
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

</html>s