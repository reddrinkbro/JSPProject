<%@page import="comment.CommentBean"%>
<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String comment = request.getParameter("comment");
	String id = (String)session.getAttribute("id");
	int num = Integer.parseInt(request.getParameter("num"));
	
	CommentDAO dao = new CommentDAO();
	CommentBean bean = new CommentBean();
	bean.setId(id);
	bean.setComment(comment);
	bean.setNum(num);
	dao.insertComment(bean);
	
%>
<%=id%>