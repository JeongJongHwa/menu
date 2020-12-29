<%@page import="setting.Setting"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	
		String userID = null;
		if( session.getAttribute("userID") != null ) {
			userID = (String) session.getAttribute("userID");	
		}
	
		if( userID == null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} else {
		
			if( ! Setting.getNoticeID().equals(userID) ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('관리자만이 삭제가 가능합니다.')");
				script.println("location.href='notice.jsp'");
				script.println("</script>");
			
			
			}else{
		
				if( request.getParameter("noticeNumber") == null  ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('잘못된 접근입니다.')");
					script.println("location.href='notice.jsp'");
					script.println("</script>");
				}
				
				NoticeDAO noticeDAO = new NoticeDAO();
				int noticeNumber = Integer.parseInt( request.getParameter("noticeNumber"));
						
				int result = noticeDAO.delete(noticeNumber) ;
				
				if( result == -1 ){
					
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('서버에 문제가 발생하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}  else {
					
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='notice.jsp'");
					script.println("</script>");
					
				}
			}
		}
		
		

	%>

</body>
</html>
