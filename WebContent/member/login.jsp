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
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script type="text/javascript">
	function reCaptcha(){
		var v = grecaptcha.getResponse();
	     if(v.length == 0)
	     {
	    	 alert("체크해주세요");
	         return false;
	     }
	     if(v.length != 0)
	     {
	         return true;
	     }
	}
</script>
</head>
<body>
<jsp:include page="../inc/top.jsp"/>
	<section class="page-section" id="contact">
            <div class="container">
                <!-- Contact Section Heading-->
                <br>
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">로그인</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <!-- Contact Section Form-->
                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <form id="contactForm" name="sentMessage" onsubmit="return reCaptcha()" method ="post" action="loginPro.jsp">
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                    <input class="form-control" name="id" type="text" placeholder="ID" required="required"/>
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                    <input class="form-control" name="pw" type="password" placeholder="Password" required="required"/>
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
									<div id="captcha" class="g-recaptcha" data-sitekey="6LeDybAZAAAAANVOj8pTEirfnUW3xLNLFDqgjAEi"></div>
                                </div>
                            </div>                           
                            <br>
                            <div class ="btn-submit">
	                            <div class="form-group" ><input class="btn btn-primary btn-xl" type="submit" value = "로그인">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div style ="text-align: center;">올마켓에 처음이세요?<a href="signup.jsp">회원가입하기</a></div>	
        </section>
<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>