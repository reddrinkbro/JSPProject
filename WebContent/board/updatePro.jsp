<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String encoding = "UTF-8";
	int num = Integer.parseInt(request.getParameter("num"));
	//업로드할 실제 서버의 경로 얻기
	String realFolder = getServletContext().getRealPath("/upload");
	String contextPath = request.getContextPath();
	String id = (String)session.getAttribute("id");
	String pw = (String)session.getAttribute("pw");
	if(id == null){
		response.sendRedirect(contextPath +"/member/update.jsp");
	}
	BoardDAO dao = new BoardDAO();
	BoardBean board = new BoardBean();
	SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
	Date date = new Date();
	board.setDate(format.format(date));
	board.setNum(num);
	
	File currentPath = new File(realFolder);
	DiskFileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(factory);
	
	List<FileItem> items = upload.parseRequest(request);
	
	String fieldName = "";
	String fieldString = "";	
	String fileName = "";
	String nameTemp = "";
	try{
		int num1 = 1;
		for(int i = 0; i < items.size(); i++){
			FileItem item = (FileItem)items.get(i);
			//파일데이터가 아닌 경우
			if(item.isFormField()){
				fieldName = item.getFieldName();
				fieldString = item.getString(encoding);
				
				if(fieldName.equals("subject")){
					board.setSubject(fieldString);
				}else if(fieldName.equals("price")){
					board.setPrice(fieldString);
				}else if(fieldName.equals("category")){
					board.setCategory(fieldString);
				}else if(fieldName.equals("content")){
					board.setContent(fieldString);
				}
			}else{
				fieldName = item.getFieldName();
				fileName = item.getName();
				long fileSize = item.getSize();
				//파일 이름부분만 가져오기
				if(fileSize > 0){
					int index = fileName.lastIndexOf("\\");
					fileName = fileName.substring(index + 1);
					//파일 업로드 위치
					File uploadFile = new File(realFolder +"\\"+fileName);
					item.write(uploadFile);
					if(num1 == 1){
						board.setImg1(fileName);
						num1++;
					}else if(num1 == 2){
						board.setImg2(fileName);
						num1++;
					}else{
						board.setImg3(fileName);
					}
				}
			}
		}
	} catch(Exception e){
		System.out.println("업로드 실패!: " + e);
	}
	boolean check = dao.updateBoard(board);
	if(check) {
%>
	<script>
		window.alert("수정 완료");
		location.href= "content.jsp?num=<%=num%>";
	</script>
<%	}else{ %>
	<script>
		window.alert("수정 실패")
		location.href= "update.jsp?num=<%=num%>";
	</script>
<% 	
	}
%>


	

	
