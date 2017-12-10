<%@ page import="java.io.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.zip.*" %>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.activation.*"%>

<%
    
	              String stu_id=request.getParameter("stu_id");
				  String book_id=request.getParameter("book_id");
				  String doi=request.getParameter("doi");
                    
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root","root");
                   PreparedStatement stml = con.prepareStatement("select * from login where emp_id=?");			
                    stml.setString(1,stu_id);
                    ResultSet rs=stml.executeQuery();
                    if(rs.next())
					{
						PreparedStatement stml1=con.prepareStatement("select count(*) from libraryform where stu_id=?");
						stml1.setString(1,request.getParameter("stu_id"));
						ResultSet rs1=stml1.executeQuery();
						rs1.next();
						int count=rs1.getInt(1);
						     if(count>2)
							 {
							 response.sendRedirect("library.jsp?bmsg="+"maximum limit avail");
							 }
							 else
							 {
						    stml = con.prepareStatement("insert into libraryform values(?,?,?)");
						    stml.setString(1,stu_id);
							stml.setString(2,book_id);
							stml.setString(3,doi);
							stml.executeUpdate();
							response.sendRedirect("library.jsp");
							 }
							
					}	
					
					
                    	
	
%>