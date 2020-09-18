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
<%}%>
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
<script type="text/javascript">
	function checkPrice(){
		var regexp = /^[0-9]+$/
			
		if($("#subject").val()==""){
			alert("제목을 입력해주세요");
			$("#subject").focus();
			return false;
		}else if($("#price").val()==""){
			alert("가격을 입력해주세요");
			$("#price").focus();
			return false;
		}else if(!regexp.test($("#price").val())){
			alert("숫자만 입력해주세요");
			$("#price").focus();
			$("#price").val("");
			return false;
		}else if($("#category").val() == ""){
			alert("카테고리를 선택해주세요");
			$("#category").focus();
			return false;
		}
		return true;
	}
	function updatePicture(file, id){
		var url = file.value;
		var imgTag = document.getElementById(id);
		var filetype= url.slice(url.length - 3, url.length);
		if(filetype=='jpg' || filetype=='gif' || filetype=='png' || filetype=='jpeg' || filetype=='bmp'){
			imgTag.value = url;
		}else{
			alert("이미지 파일만 업로드 가능합니다.");
			return;
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
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">상품 등록</h2>
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
                        <form id="contactForm" name="sentMessage" enctype="multipart/form-data" onsubmit="return checkPrice()" action="writeBoardPro.jsp" method="post">
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                    <input class="form-control" id="subject" name="subject" type="text" placeholder="제목" required="required"/>
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                    <input class="form-control" id="price" name="price" type="text" placeholder="가격" required="required"/>
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>  
							<div class="control-group">
								<div id ="imageFile">
									<label>사진 업로드								
	                                   <input id="imgfile" type="file" name ="fileimage" onchange="updatePicture(this, 'img1')" >
	                            	</label>
	                               <input class= "image-input" type="text" name ="img1" id="img1" placeholder ="input" readonly>
                                </div>
                            </div>
                            <div class="control-group">
								<div id ="imageFile">
									<label>사진 업로드								
	                                   <input id="imgfile" type="file" name ="fileimage" onchange="updatePicture(this,'img2')" >
	                               </label>
	                               <input class= "image-input" type="text" name ="img2" id="img2" placeholder ="input" readonly>
                                </div>
                            </div> 
							<div class="control-group">
								<div id ="imageFile">
									<label>사진 업로드								
	                                   <input id="imgfile" type="file" name ="fileimage" onchange="updatePicture(this,'img3')" >
	                               </label>
	                               <input class= "image-input" type="text" name ="img3" id="img3" placeholder ="input" readonly>
                                </div>
                            </div>                            
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                	<select class = "form-control" name ="category">
                                		<option value="">카테고리를 선택해주세요</option>
                                		<option value="가구">가구</option>
                                		<option value="옷">옷</option>
                                		<option value="전자">전자기기</option>
                                		<option value="전자">스포츠</option>
                                	</select>
                                    
                                </div>
                            </div>                            
                            <div class="control-group">
                                <div class="form-group floating-label-form-group controls mb-0 pb-2">
                                    <textarea class="form-control" id="content" name = "content" rows="20" placeholder="Message"></textarea>
                                </div>
                            </div>
							<div class ="btn-submit">
								<div class="form-group"><input class="btn btn-primary btn-xl" type="submit" value = "등록">
							</div>	                                                     
                        </form>
                    </div>
                </div>
            </div>
	</section>
<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>