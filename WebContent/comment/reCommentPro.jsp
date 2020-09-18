<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	int re_ref = Integer.parseInt(request.getParameter("re_ref"));
	int re_lev = Integer.parseInt(request.getParameter("re_lev"));
	int re_seq = Integer.parseInt(request.getParameter("re_seq"));
	String comment = request.getParameter("comment");
	String id = (String)session.getAttribute("id");
	
	CommentBean bean = new CommentBean();
	bean.setNum(num);
	bean.setRe_ref(re_ref);
	bean.setRe_lev(re_lev);
	bean.setRe_seq(re_seq);
	bean.setComment(comment);
	bean.setId(id);
	CommentDAO dao = new CommentDAO();
	boolean check = dao.InsertRecomment(bean);
	if(!check){
%>
	<script>
		alert("댓글 저장 실패");
	</script>
<%}%>
	<script>
		location.href="../board/content.jsp?num=<%=num%>"
	</script>
