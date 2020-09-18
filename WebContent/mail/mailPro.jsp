<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.internet.AddressException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="java.util.Date"%>
<%@page import="mail.SMTPAuthenticatior"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	boolean check = false;
	request.setCharacterEncoding("UTF-8");
	String subject = request.getParameter("subject");
	String text = request.getParameter("text");
	
	Properties prop = new Properties();
	prop.put("mail.smtp.host", "smtp.gmail.com"); 
	prop.put("mail.smtp.port", "465"); 
	prop.put("mail.smtp.auth", "true"); 
	prop.put("mail.smtp.ssl.enable", "true"); 
	prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
	prop.put("mail.smtp.socketFactory.port", "465");
	prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	prop.put("mail.smtp.socketFactory.fallback", "false");
	
    Authenticator auth = new SMTPAuthenticatior();
    MimeMessage msg = new MimeMessage(Session.getDefaultInstance(prop, auth));
    try{
    	msg.setSentDate(new Date());
    	Address fromAddr = new InternetAddress("allmarket324@gmail.com");
        msg.setFrom(fromAddr);
        
        Address to = new InternetAddress("ghdwn94@gmail.com");
        msg.setRecipient(Message.RecipientType.TO, to);
        
        msg.setSubject(subject, "UTF-8");
        msg.setText(text,"UTF-8");
        Transport.send(msg);
        check = true;
    }catch(AddressException ae) {            
        System.out.println("AddressException : " + ae.getMessage());           
    } catch(MessagingException me) {            
        System.out.println("MessagingException : " + me.getMessage());
    }
    if(check){
%>
	<script>
		alert("메일이 발송되었습니다.");
		location.href= "../index.jsp";
	</script>
<%}else{%>
	<script>
		alert("메일이 실패했습니다.");
		location.href= "mail.jsp";
	</script>	
<%} %>
