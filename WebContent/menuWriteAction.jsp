<%@page import="menu.MenuDAO"%>
<%@page import="menu.MenuImageDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="menu" class="menu.Menu" scope="page"></jsp:useBean>
<jsp:setProperty property="menuTitle" name="menu" />
<jsp:setProperty property="menuContent" name="menu" />

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
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	} else {

		int menuImageNumber = 0; // 0 이면 이미지 없음 , 1이상 이면 이미지 존재
		

		String menuTitle = "";
		String menuContent = "";
		String fileName1 = "";
		String orgfileName1 = "";

		String uploadPath = request.getRealPath("upload");
		System.out.println("절대경로 : " + uploadPath);

		try {
			MultipartRequest multi = new MultipartRequest( // MultipartRequest 인스턴스 생성(cos.jar의 라이브러리)
			request, uploadPath, // 파일을 저장할 디렉토리 지정
			10 * 1024 * 1024, // 첨부파일 최대 용량 설정(bite) / 10KB / 용량 초과 시 예외 발생
			"utf-8", // 인코딩 방식 지정
			new DefaultFileRenamePolicy() // 중복 파일 처리(동일한 파일명이 업로드되면 뒤에 숫자 등을 붙여 중복 회피)
			);

			fileName1 = multi.getFilesystemName("file1"); // name=file1의 업로드된 시스템 파일명을 구함(중복된 파일이 있으면, 중복 처리 후 파일 이름)
			orgfileName1 = multi.getOriginalFileName("file1"); // name=file1의 업로드된 원본파일 이름을 구함(중복 처리 전 이름)
			menuTitle = multi.getParameter("menuTitle");
			menuContent = multi.getParameter("menuContent");

			if (fileName1 != null) {

				MenuImageDAO menuImageDAO = new MenuImageDAO();
				menuImageNumber = menuImageDAO.getNext();
		
				if (menuImageDAO.write(fileName1,menuImageNumber) != 1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('업로드중 오류가 발생하였습니다.')");
					script.println("location.href='login.jsp'");
					script.println("</script>");
				}

			}

		} catch (Exception e) {
			e.getStackTrace();
		}

		System.out.println("시스템 파일명 : " + fileName1);
		System.out.println("원래 파일명 : " + orgfileName1);

		if ("".equals(menuTitle) || "".equals(menuContent)) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('작성하지 않은 칸이 존재합니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {

			MenuDAO menuDAO = new MenuDAO();

				// menuImageNumber 0 이라면 이미지 없음 , 0이외에는 이미지 존재
				if (menuImageNumber == 0) {
		
					if (menuDAO.write(menuTitle, menuContent, userID) == 1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href='menuList.jsp'");
						script.println("</script>");
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('서버에 문제가 발생하였습니다. 다시 시도해주세요')");
						script.println("location.href='index.jsp'");
						script.println("</script>");
					}
					
				} else {
					
					if (menuDAO.write(menuTitle, menuContent, userID, menuImageNumber) == 1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href='menuList.jsp'");
						script.println("</script>");
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('서버에 문제가 발생하였습니다. 다시 시도해주세요')");
						script.println("location.href='index.jsp'");
						script.println("</script>");
					}
					
				}
			
				
			

		}

	}
	%>



</body>
</html>