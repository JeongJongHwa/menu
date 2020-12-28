<%@page import="javax.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty property="id" name="user"/>
<jsp:setProperty property="password" name="user"/>

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
		}
	
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getId(), user.getPassword());
		
		System.out.println(user.getId());
		System.out.println(user.getPassword());
		
		if(result == 1){
			session.setAttribute("userID", user.getId() );
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		} else if ( result == 0 ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 일치하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if ( result == -1 ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('ID가 존재하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if ( result == -2 ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('서버 상태가 좋지않습니다. 잠시후 다시 시도해주십시오')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>

</body>
</html>
