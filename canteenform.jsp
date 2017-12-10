<%@ page import="java.io.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.zip.*" %>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.activation.*"%>

<%
    
	              String stu_id=request.getParameter("stu_id");
                    int ammount=Integer.parseInt(request.getParameter("ammount"));
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root","root");
                   PreparedStatement stml = con.prepareStatement("select * from login where emp_id=?");			
                    stml.setString(1,stu_id);
                    ResultSet rs=stml.executeQuery();
                    if(rs.next())
					{
						PreparedStatement st=con.prepareStatement("select * from employee where emp_id=? and card_status=?");
						st.setString(1,stu_id);
						st.setString(2,"active");
						ResultSet re=st.executeQuery();
						if(re.next())
						{
						stml = con.prepareStatement("select * from stu_account where stu_id=?");
						stml.setString(1,stu_id);
						ResultSet rs1=stml.executeQuery();
						
						if(rs1.next())
						{
						int ac=rs1.getInt("ammount");
                        ac=ac+ammount;
						stml=con.prepareStatement("update stu_account set ammount=? where stu_id=?");
						stml.setString(2,stu_id);
						stml.setInt(1,ac);
						stml.executeUpdate();
						response.sendRedirect("Canteen.jsp?cmsg="+"ammount added");
						}	
						else
						{	
						stml=con.prepareStatement("insert into stu_account values(?,?)");
						stml.setString(1,stu_id);
						stml.setInt(2,ammount);
						stml.executeUpdate();
						response.sendRedirect("Canteen.jsp?cmsg="+"account created and ammount added");
					    }
						}
						else
						{
						response.sendRedirect("Canteen.jsp?cmsg="+"card not activate");
						}
					}	
					
                    	
	
%>