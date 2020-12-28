<%@page import="menu.Menu"%>
<%@page import="java.util.ArrayList"%>
<%@page import="menu.MenuDAO"%>
<%@page import="menu.MenuImageDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		String userID =  (String) session.getAttribute("userID");
		int pageNumber = 1;
		if( request.getParameter("pageNumber") != null ){
			pageNumber = Integer.parseInt( request.getParameter("pageNumber") );
		}
	
		if( userID == null ) {
	%>

	<div class="navbar navbar-inverse">
		<div class="container">
			<ul class="nav navbar-nav">
				<li><a class="navbar-brand" href="index.jsp">육식메인화면</a></li>
				<li  class="active" ><a href="menuList.jsp">식단</a></li>
				<li><a href="notice.jsp">공지사항</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="login.jsp">로그인</a></li>
				<li><a href="userJoin.jsp">회원가입</a></li>
			</ul>
		</div>
	</div>
	<%
		} else {
	%>
	<div class="navbar navbar-inverse">
		<div class="container">
			<ul class="nav navbar-nav">
				<li><a class="navbar-brand" href="index.jsp">육식메인화면</a></li>
				<li  class="active" ><a href="menuList.jsp">식단</a></li>
				<li><a href="notice.jsp">공지사항</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a ><%=userID %> 님 환영합니다</a></li>
				<li><a href="logoutAction.jsp">로그아웃</a></li>
			</ul>
		</div>
	</div>
	<%
		}
	%>
	
	<div class="container">
		
		<div class="row">
			<div class="well text-center"><h2>사용자의 식단 게시판</h2></div>
			<div class="col-sm-1" ></div>
			<div class="col-sm-10" >
				<div class="panel">
					<div class="panel-body">
						<table class="table table-hover">
							<thead>
								<tr >
									<th>대표 이미지</th>
									<th>글번호</th>
									<th>제목</th>
									<th>등록일자</th>
									<th>작성자</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
							
							<%  MenuDAO menuDAO = new MenuDAO(); 
								ArrayList<Menu> menu = menuDAO.getList(pageNumber);
								MenuImageDAO menuImageDAO = new MenuImageDAO();
								String imageName="";
								
								for( int i=0; i<menu.size(); i++ ) {
									
									int menuImageNumber = menu.get(i).getMenuImageNumber();
									
									String imageSrc = "./upload/";
									
									if( menuImageNumber != 0 ){
										imageName = menuImageDAO.getImage( menuImageNumber );
									} else {
										imageName = "대체이미지.jpg";  // 대체 이미지 사용
									}
									
									System.out.println(menu.get(i).getMenuImageNumber());
							%>
								<tr style="cursor: pointer" onclick="location.href='menuView.jsp?menuNumber=<%=menu.get(i).getMenuNumber() %>'" >
									<td><img alt="대체 이미지" src="<%=imageSrc+imageName %>" width="150px" height="110px" /></td>
									<td><%=menu.get(i).getMenuNumber() %></td>
									<td><%=menu.get(i).getMenuTitle() %></td>
									<td><%=menu.get(i).getMenuDate() %></td>
									<td><%=menu.get(i).getId() %></td>
									<td><%=menu.get(i).getReadCnt() %></td>
								</tr>
							<%
							}
							%>
							</tbody>
						</table>
					</div>	
				</div>
			</div>
			<div class="col-sm-1" ></div>
			
			</div>
			<div class="row">
				<div class="col-sm-2" ></div>
				
				<%
					if( pageNumber != 1 ){
				%>
					<a class="btn btn-primary" href="menuList.jsp?pageNumber=<%=pageNumber-1 %>" >이전</a>
				<%
					} if ( menuDAO.nextPage(pageNumber+1) ) {
				%>
					<a class="btn btn-primary" href="menuList.jsp?pageNumber=<%=pageNumber+1 %>" >다음</a>
				<%
					}
				%>
					
					<a class="btn btn-primary pull-right" href="menuWrite.jsp">작성하기</a>
				<div style="width: 100px; height: 100px;" ></div>
			</div>
			
		
	
	</div>



</body>
</html>