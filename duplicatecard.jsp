<%@ page import ="java.sql.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root", "root");
	
	String d_user_id=request.getParameter("d_user_id");
	String action="duplicate";
	
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
	
	PreparedStatement psmnt1 = con.prepareStatement("update employee set card_no=?,card_status=? where emp_id=?");
	psmnt1.setString(1, card_no);
	psmnt1.setString(2, action);
	psmnt1.setString(3, d_user_id);
	int i = psmnt1.executeUpdate();
	
	PreparedStatement psmnt2 = con.prepareStatement("delete from userrequest where emp_id=?");
	psmnt2.setString(1, d_user_id);
	int j = psmnt2.executeUpdate();
	
	if (i > 0 && j > 0) {
		
		response.sendRedirect("admin.jsp?action=duplicatesuccess");
	} else {
		response.sendRedirect("admin.jsp?action=duplicateerror");
    }
	
%>