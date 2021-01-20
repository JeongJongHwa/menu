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
		if( userID == null ) {
	%>

	<div class="navbar navbar-inverse">
		<div class="container">
			<ul class="nav navbar-nav">
				<li><a class="navbar-brand" href="index.jsp">육식메인화면</a></li>
				<li  class="active" ><a href="menuList.jsp">식단</a></li>
				<li><a href="notice.jsp">공지사항</a></li>
				<li ><a href="custom.jsp">식단 거래처 관리</a></li>
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
				<li ><a href="custom.jsp">식단 거래처 관리</a></li>
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
		<form action="menuWriteAction.jsp" method="post" enctype="multipart/form-data" >
		<div class="row">
			<div class="well text-center"><h2>식단 작성하기</h2></div>
			<div class="col-sm-1" ></div>
			<div class="col-sm-10" >
				<div class="panel">
					<div class="panel-body">
						<div class="row text-center">
							<label for="menuTitle">제목</label>
							<input class="form-control" id="menuTitle" name="menuTitle"  />
							<label for="menuContent">내용</label>
							<textarea class="form-control" id="menuContent" name="menuContent" rows="10" cols="200"></textarea>
							<label>이미지 첨부</label>
							<input type="file" name="file1" class="form-control" />
						</div>
					</div>	
				</div>
			</div>
			<div class="col-sm-1" ></div>
		</div>
			<div class="col-sm-1" ></div>
			<a class="btn btn-primary" href="menuList.jsp">뒤로가기</a>
			<input type="submit" class="btn btn-primary" value="식단 작성" />
		
		</form>
	</div>



</body>
</html>