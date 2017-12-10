<%@ page import ="java.sql.*" %>
<%
    String emp_id = request.getParameter("emp_id");    
    String password = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root","root");
    PreparedStatement stml = con.prepareStatement("select * from login where emp_id=? and password=?");
     stml.setString(1,emp_id);
	 stml.setString(2,password);
	 ResultSet rs=stml.executeQuery();
	if (rs.next()) 
	{
        session.setAttribute("emp_id", emp_id);
		String role = rs.getString("role");
		if (role.equals("admin")) 
		{
			session.setAttribute("role", role);
			response.sendRedirect("admin.jsp");
		} 
		else 
		{
			if (role.equals("user")) 
		    {
			session.setAttribute("role", role);
			response.sendRedirect("user.jsp");
		    } 
			else
		    {
			 if (role.equals("library")) 
		      {
			   session.setAttribute("role", role);
			   response.sendRedirect("library.jsp");
		      }
             else
			 {
				 if (role.equals("canteen")) 
		      {
			   session.setAttribute("role", role);
			   response.sendRedirect("Canteen.jsp");
		      } 
			 }				 
			}
		}
    } 
	else 
	{
        response.sendRedirect("index.jsp");
    }
%>