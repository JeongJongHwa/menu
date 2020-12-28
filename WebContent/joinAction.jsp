<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean> 
<jsp:setProperty property="id" name="user"/>
<jsp:setProperty property="password" name="user"/>
<jsp:setProperty property="name" name="user"/>
<jsp:setProperty property="memberdate" name="user"/>
<jsp:setProperty property="gender" name="user"/>
<jsp:setProperty property="email" name="user"/>


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
	
		if( userID != null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		} else {
		
			if( user.getId() == null || user.getPassword() == null || user.getName() == null || user.getMemberdate() == null || user.getEmail() == null ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
		
				UserDAO userDAO = new UserDAO();
			
			
				int result = userDAO.userJoin(user);
				
				if( result == -1 ){
					
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 ID 입니다.')");
					script.println("history.back()");
					script.println("</script>");
				}  else {
					
					session.setAttribute("userID", user.getId());
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('회원가입이 성공하였습니다.')");
					script.println("location.href='index.jsp'");
					script.println("</script>");
					
				}
			}
		
		}
		

	%>

</body>
</html>
