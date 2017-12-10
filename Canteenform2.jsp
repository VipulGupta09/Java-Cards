<%@ page import="java.io.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.zip.*" %>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.activation.*"%>

<%
    
	              String stu_id=request.getParameter("stu_id");
				  String food_item=request.getParameter("food_item");
                    int price=Integer.parseInt(request.getParameter("price"));
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root","root");
                   PreparedStatement stml = con.prepareStatement("select ammount from stu_account where stu_id=?");			
                    stml.setString(1,stu_id);
                    ResultSet rs=stml.executeQuery();
                    if(rs.next())
					{
						int ammount=rs.getInt(1);
						if(ammount>=price)
						{	
						ammount=ammount-price;
						stml=con.prepareStatement("update stu_account set ammount=? where stu_id=?");
						stml.setInt(1,ammount);
						stml.setString(2,stu_id);
						stml.executeUpdate();
						stml=con.prepareStatement("insert into canteen_perchase values(?,?,?)");
						stml.setString(1,stu_id);
					    stml.setString(2,food_item);
						stml.setInt(3,price);
						stml.executeUpdate();
                        response.sendRedirect("Canteen.jsp?cmsg="+"item perchased ammount left="+ammount+"");						
						}
						else
						{
						response.sendRedirect("Canteen.jsp?cmsg="+"not enough ammount");
						}
						
					}	
					else
					{
					response.sendRedirect("Canteen.jsp?cmsg="+"student not exist");	
					}
					
                    	
	
%>