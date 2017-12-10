<%@ page import="java.sql.*,javax.servlet.*,java.util.*" %>
 <%  
 Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root","root");
 PreparedStatement stml;
 ResultSet rs;
 out.write("hello your deletion in process");
 stml=con.prepareStatement("select * from tempcard ");
 rs=stml.executeQuery();
 rs.next();
 String dd=rs.getString(3);	
 String[] d=dd.split("-");
 int day=Integer.parseInt(d[0]);
 int month=Integer.parseInt(d[1]);
 int year=Integer.parseInt(d[2]); 
 while(true)
{
	java.util.Date date=new java.util.Date();
	int tmonth=date.getMonth()+1;
	int tyear=date.getYear()+1900;
	int tday=date.getDate();
	 	if(tyear>year)
	 	{
	 		PreparedStatement stml2=con.prepareStatement("select emp_id,card_no from tempcard");
	 		ResultSet rs1=stml2.executeQuery();
	 		while(rs1.next())
	 		{
	 			PreparedStatement stml3=con.prepareStatement("update employee set card_no=? where emp_id=? ");
	 			stml3.setString(1,rs1.getString(2));
	 			stml3.setString(2,rs1.getString(1));
	 			stml3.executeUpdate();
	 		}
	 		PreparedStatement stml4=con.prepareStatement("update p set ps=0");
	 		stml4.executeUpdate();
	 		PreparedStatement stml5=con.prepareStatement("TRUNCATE tempcard");
	 	}
	 	else
	 	{
	 		if(tmonth>month)
	 		{

	 			PreparedStatement stml2=con.prepareStatement("select emp_id,card_no from tempcard");
		 		ResultSet rs1=stml2.executeQuery();
		 		while(rs1.next())
		 		{
		 			PreparedStatement stml3=con.prepareStatement("update employee set card_no=? where emp_id=? ");
		 			stml3.setString(1,rs1.getString(2));
		 			stml3.setString(2,rs1.getString(1));
		 			stml3.executeUpdate();
		 		}
		 		PreparedStatement stml4=con.prepareStatement("update p set ps=0");
		 		stml4.executeUpdate();
		 		PreparedStatement stml5=con.prepareStatement("TRUNCATE tempcard");
		 		stml5.executeUpdate();
		 		
	 		}	
	 		else
	 		{
	 			if(tday>day)
	 			{
	 				PreparedStatement stml2=con.prepareStatement("select emp_id,card_no from tempcard");
	 		 		ResultSet rs1=stml2.executeQuery();
	 		 		while(rs1.next())
	 		 		{
	 		 			PreparedStatement stml3=con.prepareStatement("update employee set card_no=? where emp_id=? ");
	 		 			stml3.setString(1,rs1.getString(2));
	 		 			stml3.setString(2,rs1.getString(1));
	 		 			stml3.executeUpdate();
	 		 		}
	 		 		PreparedStatement stml4=con.prepareStatement("update p set ps=?");
					stml4.setInt(1,0);
	 		 		stml4.executeUpdate();
	 		 		PreparedStatement stml5=con.prepareStatement("TRUNCATE tempcard");
	 		 		stml5.executeUpdate();	
					out.write("tabledeleted");
			 		break; 
	 			}	
	 		}	
	 	}
	 }

%>