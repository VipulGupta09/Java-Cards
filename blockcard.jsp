<%@ page import ="java.sql.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root", "root");
	
	String b_user_id=request.getParameter("b_user_id");
	String action="blocked";
	
	PreparedStatement psmnt1 = con.prepareStatement("update employee set card_status=? where emp_id=?");
	psmnt1.setString(1, action);
	psmnt1.setString(2, b_user_id);
	int i = psmnt1.executeUpdate();
	
	PreparedStatement psmnt2 = con.prepareStatement("delete from userrequest where emp_id=?");
	psmnt2.setString(1, b_user_id);
	int j = psmnt2.executeUpdate();
	

		
		if (i > 0 && j > 0) {
		
		response.sendRedirect("admin.jsp?action=blocksuccess");
	} else {
		response.sendRedirect("admin.jsp?action=blockerror");
    }
	
	
%>