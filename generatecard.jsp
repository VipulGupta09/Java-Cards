<%@ page import="java.io.*" %>
<%@ page import ="java.sql.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root", "root");
	
	String card_no="UNIFID_ID_";
	
	PreparedStatement ps = con.prepareStatement("select count(*) from employee");
	ResultSet rs = ps.executeQuery();
	rs.next();
	int card=0;
 	card=rs.getInt(1);
 	card=card+101;
	for(int k=0;k<4;k++)
		{
			int x=(int)(Math.random()*10);
			card_no=card_no+x;
		}
 	card_no=card_no+card;
	
	String user_id = request.getParameter("g_user_id");
	
	PreparedStatement psmnt = con.prepareStatement("update employee set card_no=?, card_status=? where emp_id=?");
	psmnt.setString(1, card_no);
	psmnt.setString(2, "active");
	psmnt.setString(3, user_id);
	int i = psmnt.executeUpdate();
	
	if (i > 0) {
		session.setAttribute("g_success", "true");
		//response.sendRedirect("admin.jsp?generate=success");
		response.sendRedirect("sendmail.jsp");
	} else {
		session.setAttribute("g_error", "true");
		response.sendRedirect("admin.jsp?generate=error");
    }
	
%>