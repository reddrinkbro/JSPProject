<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = (String)session.getAttribute("id");
	if(id== null){
%>
	<script>
		alert("로그인이 필요합니다.");
		history.go(-1);
	</script>
<%
	}
	MemberDAO dao = new MemberDAO();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ALL MARKET</title>
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="../css/styles.css" rel="stylesheet" />
<script language="javascript"
	src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
</head>
<body>
<jsp:include page="../inc/top.jsp"/>
	<section class="page-section" id="contact">
            <div class="container">
                <!-- Contact Section Heading-->
                <br>
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">메일보내기</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <!-- Contact Section Form-->
                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <!-- To configure the contact form email address, go to mail/contact_me.php and update the email address in the PHP file on line 19.-->
                        <form id="contactForm" name="sentMessage" action="mailPro.jsp" method="post">
 							<div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                    <input class="form-control" name="subject" type="text" placeholder="제목" required="required"/>
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                    <textarea class="form-control" name = "text" rows="20" placeholder="Message"></textarea>
                                </div>
                            </div>
                            <div>
	                            <div class="form-group"><input class="btn btn-primary btn-xl" type="submit" value = "보내기"></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
	</section>
<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>