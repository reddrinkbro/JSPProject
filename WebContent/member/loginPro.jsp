<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	MemberDAO dao = new MemberDAO();
	int check = dao.checkMember(id, pw);
	if(check == 1){
		session.setAttribute("id", id);
		session.setAttribute("pw", pw);
%>
		<script>
			alert("로그인 완료");
			//이전 페이지(login.jsp)로 이동
			location.href= "../index.jsp";
		</script>
<%	}else if(check == 0){%>
		<script type="text/javascript">
			alert("비밀번호 틀림");
			//이전 페이지(login.jsp)로 이동
			history.back();
		</script>
<%}else{%>
		<script>
			alert("아이디가 없음");
			//이전 페이지(login.jsp)로 이동
			history.go(-1);
		</script>
<%}%>