<%@ page import ="java.sql.*" %>
<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root","root");
	
	int count=1;
%>
	
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>UNIFID CARD SYSTEMS - ID Card Portal</title>
	<link href="assets/images/atat-logo.ico" rel="shortcut icon">

	<!-- Global stylesheets -->
	<link href="fonts/fonts.css" rel="stylesheet" type="text/css">
    <link href="assets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link href="css/animate.min.css" rel="stylesheet" type="text/css">
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="css/main.css" rel="stylesheet" type="text/css">
	<link href="css/bootstrap-extended.css" rel="stylesheet" type="text/css">
	<link href="css/plugins.css" rel="stylesheet" type="text/css">
	<link href="css/color-system.css" rel="stylesheet" type="text/css">
	<link href="css/media.css" rel="stylesheet" type="text/css">
	<link type="text/css" rel="stylesheet" href="datatable_extension_export_options.html" id="style">
	<link type="text/css" rel="stylesheet" href="datatable_extension_export_options.html" id="theme">
	<!-- /global stylesheets -->

	<!-- Core JS files -->	
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>	
	<script src="js/fancybox.min.js"></script>	
	<script src="js/app.js"></script>
	<script src="js/datatables/datatables.min.js"></script>
	<script src="js/datatables/extensions/buttons.min.js"></script>
	<script src="js/forms/select2.min.js"></script>
	<script src="js/sweet_alert.min.js"></script>
    
	<script src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
	<script src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
	<script src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
	<script src="//cdn.datatables.net/buttons/1.2.1/js/buttons.html5.min.js"></script>
	<script src="//cdn.datatables.net/buttons/1.2.1/js/buttons.print.min.js"></script>

</head>

<body>

<!-- Page container -->
<div class="page-container" style="min-height:700px">

	<!-- Page content -->
	<div class="page-content">
<!-- Main content -->
<div class="content-wrapper">

	<!-- Page header -->


			<div class="page-title">
            	<center><img src="../assets/img/logos/logotemp.png" draggable="false" style="margin-top:10px;" draggable="false"></center>
			</div>															


	<!-- /page header -->

	<!-- Content area -->
	<div class="content">
		<div class="panel panel-flat">
			<div class="panel-heading">
								
			</div>

			
			
			<div class="table-responsive">
				<table class="table datatable-button-init-basic">
					<thead>
						<tr>
							<th>#</th>
							<th>Student ID</th>
							<th>Name</th>
							<th>Course/Branch</th>
							<th>Location</th>
							<th>Card No</th>
                            <th>Card Status</th>
						</tr>
					</thead>
					
					<tbody>
						
<%
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select emp_id,name,designation,location,card_no,card_status from employee");
%>

						<% while(rs.next()) { %>
                                            
							<tr>
                            	<td><%=count++%></td>
                                <td><%= rs.getString(1)%></td>
                                <td><%= rs.getString(2)%></td>
                                <td><%= rs.getString(3)%></td>
                                <td><%= rs.getString(4)%></td>
                                <td><%= rs.getString(5)%></td>
                                <td><%= rs.getString(6)%></td>
							</tr>
                            
						<% } %>
                       
					</tbody>
				</table>
			</div>
		</div>
        
        
        
<script type='text/javascript'>
	$(document).ready(function() {		
		$(function() {
			$.extend( $.fn.dataTable.defaults, {
				autoWidth: false,
				dom: '<"datatable-header"fBl><"datatable-scroll-wrap"t><"datatable-footer"ip>',
				language: {
					search: '<span>Filter:</span> _INPUT_',
					lengthMenu: '<span>Show:</span> _MENU_',
					paginate: { 'first': 'First', 'last': 'Last', 'next': '&rarr;', 'previous': '&larr;' }
				}
			});

			// Basic initialization
			$('.datatable-button-init-basic').DataTable({
				buttons: {
					dom: {
						button: {
							className: 'btn btn-primary'
						}
					},
					buttons: [
						{extend: 'copy', className: 'copyButton' },
						{extend: 'csv', className: 'csvButton' },
						{extend: 'excel', className: 'excelButton' },
						{extend: 'pdf', className: 'pdfButton' },
						{extend: 'print', className: 'printButton' }
					]
				}
			});

			// Add placeholder to the datatable filter option
			$('.dataTables_filter input[type=search]').attr('placeholder','Type to search...');

			// Enable Select2 select for the length option
			$('.dataTables_length select').select2({
				minimumResultsForSearch: Infinity,
				width: 'auto'
			});
		});
	});
</script>
					<!-- Footer -->
					
					<!-- /footer -->

				</div>
				<!-- /content area -->

			</div>
			<!-- /main content -->
		
		</div>
		<!-- /page content -->

	</div>
	<!-- /page container -->
</body>

</html>