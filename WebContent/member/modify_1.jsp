<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>
<jsp:include page="../inc/top.jsp"/>
	<section class="page-section" id="contact">
            <div class="container">
                <br>
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">비밀번호 확인</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <form id="contactForm" name="sentMessage" method ="post" action="modify_2.jsp">
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                    <input class="form-control" name="pw" type="password" placeholder="Password" required="required"/>
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <br>
                            <div>
	                            <input class="btn btn-primary btn-xl" type="submit" value = "확인">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
	</section>
<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>