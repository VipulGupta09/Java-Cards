<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root", "root");
	
	String t_user_id=request.getParameter("t_user_id");
	String action="temporary";
	
	String t_card_no="UNIFID_ID_";
	
	PreparedStatement ps = con.prepareStatement("select count(*) from employee");
	ResultSet rs = ps.executeQuery();
	rs.next();
	int card=0;
 	card=rs.getInt(1);
 	card=card+101;
	for(int k=0;k<4;k++)
		{
			int x=(int)(Math.random()*10);
			t_card_no=t_card_no+x;
		}
 	t_card_no=t_card_no+card;
	
	PreparedStatement stml=con.prepareStatement("select card_no from employee where emp_id=?");
	stml.setString(1,t_user_id);
	ResultSet rs2=stml.executeQuery();
	rs2.next();
	String card_no=rs2.getString(1);
	
	PreparedStatement psmnt1 = con.prepareStatement("update employee set card_no=?,card_status=? where emp_id=?");
	psmnt1.setString(1, t_card_no);
	psmnt1.setString(2, action);
	psmnt1.setString(3, t_user_id);
	int i = psmnt1.executeUpdate();
	
	PreparedStatement psmnt2 = con.prepareStatement("delete from userrequest where emp_id=?");
	psmnt2.setString(1, t_user_id);
	int j = psmnt2.executeUpdate();
	
	
	java.util.Date dd=new java.util.Date();
	int tmonth=dd.getMonth()+1;
	int tyear=dd.getYear()+1900;
	int tday=dd.getDate();
	String date=tday+"-"+tmonth+"-"+tyear;
	PreparedStatement psmnt3 = con.prepareStatement("insert into tempcard values(?,?,?)");
	psmnt3.setString(1, t_user_id);
	psmnt3.setString(2, card_no);
	psmnt3.setString(3, date);
	int k = psmnt3.executeUpdate();
	
	if (i > 0 && j > 0) {
		
		response.sendRedirect("admin.jsp?action=temporarysuccess");
	} else {
		response.sendRedirect("admin.jsp?action=temporaryerror");
    }
	
%>