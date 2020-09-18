<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pw = (String)session.getAttribute("pw");
	BoardDAO dao = new BoardDAO();
	int check = dao.deleteBoard(num, pw);
	if(check == 1){
%>
	<script type="text/javascript">
		alert("삭제성공");
		location.href="../index.jsp";
	</script>
<%
	}else{
%>
	<script type="text/javascript">
		alert("비밀번호가 틀렸습니다");
		location.href="delete.jsp";
	</script>
<%
	}
%>