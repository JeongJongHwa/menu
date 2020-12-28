<%@page import="menu.MenuAppraisalDAO"%>
<%@page import="menu.Menu"%>
<%@page import="menu.MenuDAO"%>
<%@page import="menu.MenuImageDAO"%>
<%@page import="menu.MenuAppraisal" %>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<% request.setCharacterEncoding("UTF-8"); %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>육식</title>
</head>
<body>

	<%
		String userID = null;
		if( session.getAttribute("userID") != null ){
			userID =  (String) session.getAttribute("userID");
		} 
		
		if( userID == null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} else {
			
			int menuNumber;
			
			System.out.println( request.getParameter("menuNumber") );
			if ( request.getParameter("menuNumber") == null ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('접근이 올바르지 않습니다')");
				script.println("location.href='index.jsp'");
				script.println("</script>");
			} else {
					
					menuNumber= Integer.parseInt(request.getParameter("menuNumber"));
					MenuDAO menuDAO = new MenuDAO();
					Menu menu = menuDAO.getMenu(menuNumber);
					MenuImageDAO menuImageDAO = new MenuImageDAO();
					MenuAppraisalDAO menuAppraisalDAO = new MenuAppraisalDAO();
					
					if( menu.getId().equals( userID ) ) {
					
							if ( menuImageDAO.isImage(menuNumber) ){
								if( ! menuImageDAO.deleteImage(menuNumber) ){
									PrintWriter script = response.getWriter();
									script.println("<script>");
									script.println("alert('서버에 문제가 발생하였습니다. 다시 시도해주세요 1')");
									script.println("location.href='index.jsp'");
									script.println("</script>");
								}
							}
							
						if ( menuDAO.delete( menuNumber ) == 1 && menuAppraisalDAO.deleteMenuappraisal(menuNumber) == 1 ){
							
							PrintWriter script = response.getWriter();
							
							script.println("<script>");
							script.println("location.href='menuList.jsp'"   );
							script.println("</script>");
						} else {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('서버에 문제가 발생하였습니다. 다시 시도해주세요')");
							script.println("location.href='index.jsp'");
							script.println("</script>");
						
						}
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('작성자가 동일하지 않습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
			}
		}
	
	%>



</body>
</html>