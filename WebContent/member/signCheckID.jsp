<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");
	MemberDAO dao = new MemberDAO();
%>
<%=dao.idcheck(id)%>