<%@ page import ="java.sql.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root", "root");
	
	String emp_id=request.getParameter("emp_id");
	String card_status=request.getParameter("card_status");
	String action=null;
	
	if(card_status.equals("Not Available") || card_status.equals("NOT AVAILABLE")){
		session.setAttribute("accessdenied","yes");
		response.sendRedirect("user.jsp?msg=accessdenied");
	} else {
		ResultSet rs1;
		PreparedStatement ps1;
		ps1=con.prepareStatement("Select action from userrequest where emp_id=?");
		ps1.setString(1,emp_id);
		rs1=ps1.executeQuery();
		while(rs1.next()){
			action=rs1.getString("action");
		}
		if(action=="" || action==null){
			action="block";
			
			PreparedStatement psmnt = con.prepareStatement("insert into userrequest(emp_id,action) values(?,?)");
			psmnt.setString(1, emp_id);
			psmnt.setString(2, action);
			int i = psmnt.executeUpdate();
			
			if (i > 0) {
				session.setAttribute("successvalid", "yes");
				response.sendRedirect("user.jsp?msg=blocksuccess");
			} else {
				session.setAttribute("errorvalid", "yes");
				response.sendRedirect("user.jsp?msg=blockerror");
			}
		} else {
			session.setAttribute("alreadyexist","yes");
			session.setAttribute("requesttype",action);
			response.sendRedirect("user.jsp?msg=already"+action);			
		}
	}
%>