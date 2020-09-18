<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	BoardDAO boardDAO = new BoardDAO();

	//DB에 저장되어 있는 전체 글의 개수를 조회하기 위해
	//BoardDAO의 getBoardCount()메소드를 호출함
	int count = boardDAO.getBoardCount();
		
	//board테이블에 존재하는 모든 글을 조회하여 저장할 용도의 ArrayList배열객체를 담을 변수 선언
	List<BoardBean> list = null;

	//만약 board테이블에 글이 잇다면
	if(count > 0){
		//board테이블에 존재하는 글을 검색해서 가져옴
		list = boardDAO.getBoardList();
	}

	String id = (String)session.getAttribute("id");
	
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
        <link href="css/styles.css" rel="stylesheet"/>
    </head>
    <body id="page-top">
    <!-- Header -->
    	<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
	    <div class="container">
	        <div class="navbar-brand">올 마켓</div>
	        <div class="collapse navbar-collapse" id="navbarResponsive">
	            <ul class="navbar-nav ml-auto">
	                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="index.jsp">Home</a></li>
	                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="board/writeBoard.jsp">Register</a></li>
	                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="mail/mail.jsp">Mail</a></li>
	            </ul>
	        </div>
<%
	if(id == null)
	{
%>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="member/login.jsp">Login</a></li>
               
            </ul>
        </div>
<%
	}else{
%>
		<div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
            	<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="member/modify_1.jsp">Profile</a></li>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="member/logout.jsp">Logout</a></li>
            </ul>
	    </div>
<%
	}
%>
	    </div>
	</nav>
    <!-- Header End -->
        <!-- Portfolio Section-->
        <section class="page-section portfolio" id="portfolio">
            <div class="container">
                <!-- Portfolio Section Heading-->
                <br>
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">최근 상품</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <!-- Portfolio Grid Items-->
                <div class="row">
<%
	//만약 게시판 글개수가 조회된다면 (게시판에 글이 저장되어있다면)
	if(count > 0){
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		Date date = new Date();
		//ArrayList에 저장되어 있는 검색한 글정보들(BoardBean객체들)의 갯수 만큼 반복하는데
		for(int i = 0; i<list.size(); i++){
			
			//ArrayList의 각 인덱스 위치에 저장되어 있는 BoardBean객체를 ArrayList배열로부터 얻어 BoardBean객체의 각 변수값들을
			//getter메소드를 통해 얻어 출력
			BoardBean bean = list.get(i);
			String beandate = bean.getDate();
			Date bday = format.parse(beandate);
			long d = date.getTime() - bday.getTime();
			long minute = TimeUnit.MILLISECONDS.toMinutes(d);
			long hour = TimeUnit.MILLISECONDS.toHours(d);
%>
		    <div class="col-md-6 col-lg-4 mb-5">
		        <div class="portfolio-item mx-auto">
		            <a href="board/content.jsp?num=<%=bean.getNum()%>">
		     <%if(bean.getImg1()!=null) {%>
		            <img class="img-fluid " src="upload/<%=bean.getImg1()%>" alt="" style="width:900px; height:250px;"/>
		     <%}else{ %>
		     		<img class="img-fluid " src="images/noImage.png" alt="" style="width:900px; height:250px;"/>
		     <%} %>
		            <br>
			            <h4 class ="text-center text-secondary"><%=bean.getSubject()%></h4>
			            <h6 class ="text-center text-secondary"><%=bean.getCategory()%></h6>
			            <h5 class ="text-center text-secondary"><%=bean.getPrice()%>원</h5>
			            <%--게시판 등록한지 하루가 지났을때 --%>
			            <%if(hour - 12 > 23){%>
			            	<h5 class ="text-center text-secondary"><%=beandate.substring(0,10)%></h5>
			            <%}else{
			            	if(minute%60 == 0 && hour - 12 == 0){
			            %>
			            	<h5 class ="text-center text-secondary">몇초전</h5>
			            <%
			            	}else if(minute%60 < 60 && hour - 12 < 1){//차이가 1시간 미만일때
			            %>
			            	<h5 class ="text-center text-secondary"><%=(minute%60)%>분전</h5>
			            <%
			            	}else if(hour-12 >= 1){
			            %>
			            	<h5 class ="text-center text-secondary"><%=(hour-12)%>시간전</h5>
			            <%}
			            }
			            %>
		            </a>
		        </div>
		    </div>
<%			
		}
	}
%>
				</div>
            </div>
        </section>
        <!-- footer -->
        <jsp:include page="inc/bottom.jsp"/>
    </body>
</html>