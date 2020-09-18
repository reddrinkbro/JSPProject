<%@page import="comment.CommentBean"%>
<%@page import="java.util.List"%>
<%@page import="comment.CommentDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*글 상세보기 페이지*/	
	
	// num  pageNum 가져오기
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String id = (String)session.getAttribute("id");

	//전달받은 글num을 이용하여 글을 검색 하기 위해 BoardDAO객체를 생성하고 
	BoardDAO bdao = new BoardDAO();
	
	//하나의 글정보를 검색 하여 얻는다.s
	BoardBean bBean = bdao.getBoard(num); 
	int DBnum = bBean.getNum(); //조회한 글번호 
	String DBId = bBean.getId(); //조회한 작성자
	
	String DBContent ="";
	
	//조회한 글내용이 존재하면
	if(bBean.getContent() != null){
		//조회한 글 내용을 변수에 저장. 단! 작성한 글내용중 엔터키로 줄바꿈 한것들을 똑같이 처리하여 반환
		DBContent = bBean.getContent().replace("\r\n","<br/>");
	}
	
	String DBSubject = bBean.getSubject();//조회한 글제목	
	String DBPrice = bBean.getPrice();
	String DBImg1;
	String DBImg2;
	String DBImg3;
	if(bBean.getImg1() == null)
		DBImg1 = "null";
	else DBImg1 = bBean.getImg1();
	if(bBean.getImg2() == null)
		DBImg2 = "null";
	else DBImg2 = bBean.getImg2();
	if(bBean.getImg3() == null)
		DBImg3 = "null";
	else DBImg3 = bBean.getImg3();
	
	CommentDAO cdao = new CommentDAO();
	List<CommentBean> clist =null;
	clist = cdao.getComment(num);
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
<script type="text/javascript">
	function fn_inputComment(){
		var _comment = $("#comment").val();
		$.ajax({
			type:"post",
			async:false,
			url:"<%=request.getContextPath()%>/comment/writeComment.jsp",
			data:{comment:_comment, num : <%=DBnum%>},
			dataType : "text",
			success:function(data, textStatus){
				$('#comment_input').append(
						"<tr class='uptd'>"+
						"<td><h3>"+
						"<font color='blue'>"+
						data+
						"</font></h3></td></tr>"+
						"<tr class='downtd'><td><h5>&emsp;"+
						_comment+
						"</h5></td></tr>");
			},
			error:function(){
				alert("에러가 발생했습니다.");
			}
		});
		$("#content").val("");
	}
	function showImage(img){
		var imgObj = new Image();
		imgObj.src = "../upload/"+img;
		if(imgObj.width > 1000){
			if(imgObj.height > 800)
				imageWin = window.open("", "profile_popup", "width=1024px, height= 800px");
			else
				imageWin = window.open("", "profile_popup", "width=1024px, height="+imgObj.height+"px");
		}else{
			imageWin = window.open("", "profile_popup", "width=" + (imgObj.width+20) + "px, height=" + (imgObj.height+20) + "px");
		}
		imageWin.document.write("<html><body>"); 
		imageWin.document.write("<a href=javascript:window.close()><img src='" + imgObj.src + "' border=0></a>"); 
		imageWin.document.write("</body><html>"); 
		imageWin.document.title = "사진보기";
}
	
</script>
</head>
<body>
<jsp:include page="../inc/top.jsp"/>
	<section class="page-section portfolio" id="portfolio">
	    <div class="container">
	        <br>
	        <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">상품 보기</h2>
	        <!-- Icon Divider-->
	        <div class="divider-custom">
	            <div class="divider-custom-line"></div>
	            <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
	            <div class="divider-custom-line"></div>
	        </div>
	        <div class="row">
			    <div class=" mx-auto">
					<%if(!DBImg1.equals("null")){ %><a href = "#" onclick="showImage('<%=DBImg1%>');"><img class="img-fluid " src="../upload/<%=DBImg1%>" style="width:360px; height:250px;"/></a><%} %>
					<%if(!DBImg2.equals("null")){ %><a href = "#" onclick="showImage('<%=DBImg2%>');"><img class="img-fluid " src="../upload/<%=DBImg2%>" style="width:360px; height:250px;"/></a><%} %>
					<%if(!DBImg3.equals("null")){ %><a href = "#" onclick="showImage('<%=DBImg3%>');"><img class="img-fluid " src="../upload/<%=DBImg3%>" style="width:360px; height:250px;"/></a><%} %>
				</div>
			</div><hr/>
			<div class=" mx-auto">
			    <h2 class = "text-center text-secondary mb-0"><%=DBSubject %></h2><hr/>
			    <h2 class = "text-center text-secondary mb-0"><%=DBPrice %>원</h2><hr/>
			    <h4 class = "text-center"><%=DBContent %></h4><hr/></div>
<%
	if(id != null){	
		if(id.equals(DBId)){
%>
			<div class="row">
				<div class=" mx-auto">
					<input class ="btn btn-primary btn-xl" type="button" value = "수정" onclick="location.href ='update.jsp?num=<%=num%>'">
					<input class ="btn btn-primary btn-xl" type="button" value = "삭제" onclick="location.href ='delete.jsp?num=<%=num%>'">
				</div>
			</div><hr/>
	<%} %>
			<h4>댓글</h4><br>
			<div>
				<table id ="comment_input" class = "table">
<%
			if(clist.size()>0){
				for(int i = 0; i < clist.size(); i++){
					CommentBean bean = clist.get(i);
					int width = 0;
					if(bean.getRe_lev() > 0){
						width = bean.getRe_lev() * 20;
					}
%>				
				<tr class='uptd'><td><h3><font color='blue'><img src="../images/level.gif" width ="<%=width %>" height ="15"><%=bean.getId() %></font></h3></td></tr>
				<tr class='downtd'><td><h5>&emsp;<img src="../images/level.gif" width ="<%=width %>" height ="15"><a href="../comment/reComment.jsp?num=<%=DBnum%>&re_lev=<%=bean.getRe_lev()%>&re_seq=<%=bean.getRe_seq()%>&re_ref=<%=bean.getRe_ref()%>" title="댓글달기">
				<%=bean.getComment() %></a></h5></td></tr>
<%
				}
			}
%>
				</table>
			</div>
			<div class="row">
				<div class="col-lg-8">
					<div class="control-group">
					    <div class="controls mb-0 pb-2">
					        <textarea class="form-control-lg" id = "comment" name = "comment" rows="5" placeholder="댓글달기" style="width:500px;"></textarea>&nbsp;
					        <input class ="btn btn-primary" onclick ="fn_inputComment()" type="button" value ="입력" style="margin-bottom: 30px;">
					    </div>
					</div>
				</div>
			</div>
		</div>	
<%} %>
	</section>
<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>