
<%@page import="java.sql.*,java.util.*,javax.mail.*,javax.mail.internet.*" contentType="text/html" pageEncoding="UTF-8"%>

<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tcsidcardsystem","root", "root");
	
	PreparedStatement ps = con.prepareStatement("select count(*) from employee");
	ResultSet rs = ps.executeQuery();
	rs.next();
	String emp_id="VAV_";
	int id=0;
	id=rs.getInt(1);
	id=100+1+id;
	emp_id=emp_id+id;
	String password="";
		for(int k=0;k<5;k++)
		{
			int x=(int)(Math.random()*10);
			char c=(char)(x+66);
			password=password+c;
		}
	
	String name = request.getParameter("name");
	String dob = request.getParameter("dob");
	String gender = request.getParameter("gender");
	String email = request.getParameter("email");
	String mobile = request.getParameter("mobile");
	String address1 = request.getParameter("address");
	String bloodgroup = request.getParameter("bloodgroup");
	String designation = request.getParameter("designation");
	String doj = request.getParameter("doj");
	String location = request.getParameter("location");
	String photo = null;
	String card_no="Not Available";
	String card_status="Not Available";
	
	PreparedStatement stml=con.prepareStatement("insert into employee(name,dob,gender,email,mobile,address,bloodgroup,designation,doj,location,photo,card_no,card_status) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
	stml.setString(1,name);
	stml.setString(2,dob);	
	stml.setString(3,gender);
	stml.setString(4,email);
	stml.setString(5,mobile);
	stml.setString(6,address1);
	stml.setString(7,bloodgroup);
	stml.setString(8,designation);
	stml.setString(9,doj);
	stml.setString(10,location);
	stml.setString(11,photo);
	stml.setString(12,card_no);
	stml.setString(13,card_status);
	int i=stml.executeUpdate();
	if(i==1)
	{
	 try {
           
            String host="smtp.gmail.com";
            String user="arvindmandi16@gmail.com";
            String pass="Angel@papa";
            String to = "guptavipul09@gmail.com";
            String from = user;
            String subject = "Password Change Confirmation";
            String messageText = "Dear ,register sucessful <br>Login:"+emp_id+"";
            messageText+=" Password:<b>"+password+"</b><br>Thanks<br>Mail Team";
            
            Properties props = System.getProperties();
            props.put("mail.host", host);
            props.put("mail.transport.protocol.", "smtp");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.", "true");
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.socketFactory.fallback", "false");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            Session mailSession = Session.getDefaultInstance(props, null);
            Message msg = new MimeMessage(mailSession);
            msg.setFrom(new InternetAddress(from));
            InternetAddress[] address = {new InternetAddress(to)};
            msg.setRecipients(Message.RecipientType.TO, address);
            msg.setSubject(subject);
            msg.setContent(messageText, "text/html"); // use setText if you want to send text
            Transport transport = mailSession.getTransport("smtp");
			try{
            transport.connect(host, user, pass);
            transport.sendMessage(msg, msg.getAllRecipients());  
						
            }
			catch (Exception err) 
			{
                        out.println(err);
            }
			 transport.close(); 
            
	}
	catch(Exception ee)
	{
		out.println(ee);
	}
	}
	
%>