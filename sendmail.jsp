<%@page import="java.sql.*,java.util.*,javax.mail.*,javax.mail.internet.*" contentType="text/html" pageEncoding="UTF-8"%>

<%
try {
           
            String host="smtp.gmail.com";
            String user="arvindmandi16@gmail.com";
            String pass="Angel@papa";
            String to = email;
            String from = user;
            String subject = "Password Change Confirmation";
            String messageText = "Dear ,register sucessful <br>Login:"+id+"";
            messageText+=" Password:<b>"+pass1+"</b><br>Thanks<br>Mail Team";
            //messageText=messageText+"see pic of found person below and identify if it is your person";
            //String ssss=""+"<img src='${pageContext.servletContext.contextPath }/showpic2.jsp?id="+foundid+"' width='200px' hight='100px'>";
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
            transport.connect(host, user, pass);
            transport.sendMessage(msg, msg.getAllRecipients());  
            transport.close();   			
            }catch (Exception err) 
			{
                        out.println(err);
            }
            
          
        
    
    
%>