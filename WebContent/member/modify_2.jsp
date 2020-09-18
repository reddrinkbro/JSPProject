<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
	String pw = request.getParameter("pw");
	MemberDAO dao = new MemberDAO();
	
	int check = dao.checkMember(id, pw);
	//비밀번호가 맞음
	if(check == 1){
		response.sendRedirect("modify_3.jsp");
	}else{
%>
		<script type="text/javascript">
			window.alert("비밀번호 틀림");
			//이전 페이지(login.jsp)로 이동
			history.back();
		</script>
<%
	}
%>
	