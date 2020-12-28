<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean> 
<jsp:setProperty property="name" name="user"/>
<jsp:setProperty property="memberdate" name="user"/>
<jsp:setProperty property="email" name="user"/>
<jsp:setProperty property="id" name="user" />


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
		
			if( user.getName() == null || user.getMemberdate() == null || user.getEmail() == null ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
		
				UserDAO userDAO = new UserDAO();
			
			
				String result = userDAO.findPassword(user.getName(), user.getMemberdate(), user.getEmail(),user.getId());
				
				System.out.println( result );
				
				if( result == null ){
					
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력사항에 일치하는 유저가 없습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}  else {
					
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('비밀번호는   "+result+"   입니다.') ");
					script.println("location.href='login.jsp'");
					script.println("</script>");
					
				}
			}
		
		}
		

	%>

</body>
</html>
