<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	MemberBean bean = null;
	MemberDAO dao = new MemberDAO();
	
	bean = dao.getMember(id);
	String DBtel = bean.getTel();
	String DBpost = bean.getPostal();
	String DBaddr = bean.getAddr();
	String DBdetail = bean.getDetailAddr();
	String DBemail = bean.getEmail();
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
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script language="javascript"
	src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
<!-- 다음 API 함수-->
	function signup_Postcode(){
		new daum.Postcode({
			 oncomplete: function(data) {
	             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	             // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	             // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	             var addr = ''; // 주소 변수

	             //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	             if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                 addr = data.roadAddress;
	             } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                 addr = data.jibunAddress;
	             }
	             // 우편번호와 주소 정보를 해당 필드에 넣는다.
	             document.getElementById('signup_postcode').value = data.zonecode;
	             document.getElementById("signup_address").value = addr;
	             // 커서를 상세주소 필드로 이동한다.
	             document.getElementById("signup_detailAddress").focus();
	         }
		}).open();
	}
	//회원가입 유효성 검사
	function checkForm(){
		var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
		var getCheckPW = RegExp(/^[a-zA-Z0-9]{8,20}$/);
		
		if($("#pw").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#pw").focus();
			return false;
		}else if($("#pw2").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#pw2").focus();
			return false;
		}else if(!getCheckPW.test($("#pw").val())){
			alert("비밀번호 형식에 맞게 입력해주세요");
			$("#pw").focus();
			$("#pw").val("");
			return false;
		}else if($("#pw").val() != $("#pw2").val()){
			alert("비밀번호가 서로 다릅니다.");
			$("#pw2").focus();
			$("#pw2").val("");
			return false;
		}else if($("#tel").val() ==""){
			alert("전화번호를 입력해주세요.");
			$("#tel").focus();
			return false;
		}else if($("#email").val() ==""){
			alert("이메일을 입력해주세요.");
			$("#email").focus();
			return false;
		}else if(!getMail.test($("#email").val())){
			alert("이메일 형식에 맞게 입력해주세요");
			$("#email").focus();
			$("#email").val("");
			return false;
		}else if($("#signup_postcode").val() ==""){
			alert("우편번호를 입력해주세요.");
			$("#signup_postcode").focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<jsp:include page="../inc/top.jsp"/>
	<section class="page-section" id="contact">
            <div class="container">
                <!-- Contact Section Heading-->
                <br>
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">정보 수정</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <!-- Contact Section Form-->
                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <form id="contactForm" name="sentMessage" onsubmit="return checkForm()" action="modifyPro.jsp" method="post">
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                    <input class="form-control" id = "pw"  name="pw" type="password" placeholder="Password" required="required"/>
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">

                                    <input class="form-control" id = "pw2" type="password" placeholder="Password-confirm" required="required" />
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">

                                    <input class="form-control" id = "tel"  name="tel" placeholder="Tel" type="text" value="<%=DBtel %>" onFocus ="this.value='';"/>
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                    <input class="form-control" id = "email"  name="email" type="text" placeholder="Email" required="required" value="<%=DBemail%>" onFocus ="this.value='';"/>
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                	<input class="form-post" type="text" name = "signup_postcode" id="signup_postcode" readonly placeholder="Postcode" value="<%=DBpost %>">
                                	<input class=" btn-post" name="signup_address" type="button" readonly onclick="signup_Postcode()" value="우편번호 찾기"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                    <input class="form-control" type="text" name = "signup_address" id="signup_address" placeholder = "주소" readonly value="<%=DBaddr %>">
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                     <input class="form-control" type="text" name = "signup_detailAddress" id="signup_detailAddress" placeholder = "상세주소" value="<%=DBdetail %>"  onFocus ="this.value='';"> 
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <br>
                            <div>
	                            <div class="form-group"><input class="btn btn-primary btn-xl" type="submit" value = "수정"></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
	</section>
<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>