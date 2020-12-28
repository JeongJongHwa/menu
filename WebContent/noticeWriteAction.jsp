<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="notice" class="notice.Notice" scope="page"></jsp:useBean>
<jsp:setProperty property="noticeTitle" name="notice" />
<jsp:setProperty property="noticeContent" name="notice" />



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
		
			if( notice.getNoticeTitle() == null || notice.getNoticeContent() == null ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			if( ! "ekfqlccodls".equals(userID) ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('관리자만이 작성이 가능합니다.')");
				script.println("location.href='index.jsp'");
				script.println("</script>");
			
			
			}else{
		
				NoticeDAO noticeDAO = new NoticeDAO();
						
				int result = noticeDAO.write(notice.getNoticeTitle(), userID, notice.getNoticeContent());
				
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
