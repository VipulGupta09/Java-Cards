

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sendgrid.SendGrid;

/**
 * Servlet implementation class sendmail
 */
@WebServlet("/sendmail")
public class sendmail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public sendmail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		try
		{
			
			String from="m_rawat_miet@sengrid.net";
			Properties props = new Properties();

			props.put("mail.smtp.host", "smtp.sendgrid.net");
			props.put("mail.smtp.port", "465");
			props.put("mail.smtp.starttls.enable","true");
			props.put("mail.smtp.debug", "true");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.fallback", "false");

			SendGrid sendgrid = new SendGrid("m_rawat_miet", "ayushmangfc27");
			
			SendGrid.Email email = new SendGrid.Email();
			
			String to="sharma.ajay2612@gmail.com";
			email.addTo(to);
			
			email.setFrom(from);
			email.setSubject("Sending with SendGrid");
			
			String msg="";
			email.setHtml("hello");

			SendGrid.Response res = sendgrid.send(email);
			out.println(res.getMessage());

			}catch(Exception e){
			out.println(e);
			}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
