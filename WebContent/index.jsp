<%@page import="menu.Menu"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="menu.MenuDAO" %>
<%@ page import="menu.MenuImageDAO" %>
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
		if( userID == null ) {
	%>

	<div class="navbar navbar-inverse">
		<div class="container">
			<ul class="nav navbar-nav">
				<li class="active" ><a class="navbar-brand" href="index.jsp">육식메인화면</a></li>
				<li><a href="menuList.jsp">식단</a></li>
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
				<li class="active" ><a class="navbar-brand" href="index.jsp">육식메인화면</a></li>
				<li><a href="menuList.jsp">식단</a></li>
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
			<div class="well text-center"><h2>Best 식단</h2></div>
			
			<%  MenuDAO menuDAO = new MenuDAO(); 
				ArrayList<Menu> menu = menuDAO.mainList();
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
					
			%>
			<div class="col-sm-4" style="cursor: pointer" onclick="location.href='menuView.jsp?menuNumber=<%=menu.get(i).getMenuNumber() %>'">
				<div class="panel panel-primary">
					<div class="panel-heading"><%=menu.get(i).getMenuTitle() %></div>
					<div class="panel-body"><img alt="대체 이미지" src="<%=imageSrc+imageName %>" width="340px" height="225px" /></div>
					<div class="panel-footer">좋아요 : <%=menu.get(i).getSumAppraisal() %><br/>       작성자 : <%=menu.get(i).getId() %></div>
				</div>
			</div>
			<%
			}
			%>
			
			
			
			
		</div>
	
	</div>



</body>
</html>