<%@ page import="java.io.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.zip.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root", "root");
	
	String photo=null;
	String saveFile="";
	String contentType = request.getContentType();
	if((contentType != null)&&(contentType.indexOf("multipart/form-data") >= 0)){
		DataInputStream in = new DataInputStream(request.getInputStream());
		int formDataLength = request.getContentLength();
		byte dataBytes[] = new byte[formDataLength];
		int byteRead = 0;
		int totalBytesRead = 0;
		while(totalBytesRead < formDataLength){
			byteRead = in.read(dataBytes, totalBytesRead,formDataLength);
			totalBytesRead += byteRead;
		}
		String file = new String(dataBytes);
		saveFile = file.substring(file.indexOf("filename=\"") + 10);
		saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));
		int lastIndex = contentType.lastIndexOf("=");
		String boundary = contentType.substring(lastIndex + 1,contentType.length());
		int pos;
		pos = file.indexOf("filename=\"");
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes()).length;
		int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
		File ff = new File("C:/Program Files/Apache Software Foundation/Tomcat 8.5/webapps/Unifid/image/"+saveFile);
		FileOutputStream fileOut = new FileOutputStream(ff);
		fileOut.write(dataBytes, startPos, (endPos - startPos));
		fileOut.flush();
		fileOut.close();
		photo = ff.getPath();
	}
	
	String user_id=(String)session.getAttribute("user_id");
	
	PreparedStatement psmnt = con.prepareStatement("update employee set photo=? where emp_id=?");
	psmnt.setString(1, photo);
	psmnt.setString(2, user_id);
	int i = psmnt.executeUpdate();

	if (i > 0) {
		
		session.setAttribute("user_id", null);
		session.setAttribute("success", "success2");
		response.sendRedirect("admin.jsp?msg=success2");
		
    } else {
		session.setAttribute("error2", "error2");
        response.sendRedirect("admin.jsp?msg=error2");
    }
	
%>