<%
	session.setAttribute("emp_id", null);
	session.setAttribute("role", null);
	session.invalidate();
	response.sendRedirect("index.jsp");
%>