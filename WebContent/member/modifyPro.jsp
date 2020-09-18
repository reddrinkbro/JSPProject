<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String pw = request.getParameter("pw");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");
	String postal = request.getParameter("signup_postcode");
	String addr = request.getParameter("signup_address");
	String detailAddr = request.getParameter("signup_detailAddress");
	MemberBean mbean = new MemberBean();
	MemberDAO dao = new MemberDAO();
	
	mbean.setId(id);
	mbean.setPw(pw);
	mbean.setTel(tel);
	mbean.setEmail(email);
	mbean.setPostal(postal);
	mbean.setAddr(addr);
	mbean.setDetailAddr(detailAddr);
	
	boolean check = dao.modifyMember(mbean);
	
	if(check){
		session.invalidate();
%>
		<script>
			window.alert("수정 완료! 다시 로그인해주세요.");
			location.href="../index.jsp";
		</script>
<%}else{%>
		<script>
			window.alert("수정 오류 발생");
			//이전 페이지(modify_3.jsp)로 이동
			history.go(-1);
		</script>
<%
	}
%>