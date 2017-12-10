<%
    if ((session.getAttribute("emp_id") == null) || (session.getAttribute("emp_id") == "")) {
		response.sendRedirect("index.jsp");
	} else {
		if (session.getAttribute("role").equals("user")) {
			response.sendRedirect("user.jsp");
		} else {
%>
Welcome <%=session.getAttribute("emp_id")%>, You're a/an <%=session.getAttribute("role")%>
<a href="logout.jsp">Logout</a>
<%
    	}
	}
%>