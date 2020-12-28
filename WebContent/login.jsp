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
				<li><a href="menuList.jsp">식단</a></li>
				<li><a href="notice.jsp">공지사항</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li  class="active" ><a href="login.jsp">로그인</a></li>
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
				<li><a href="menuList.jsp">식단</a></li>
				<li><a href="notice.jsp">공지사항</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a ><%=userID %> 님 환영합니다</a></li>
				<li  class="active" ><a href="logoutAction.jsp">로그아웃</a></li>
			</ul>
		</div>
	</div>
	<%
		}
	%>

	<div class="container">
	<form action="loginAction.jsp" method="post">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8 text-center">
				<div class="panel panel-primary text-center">
					<div class="panel-heading">Login</div>
					
					<div class="panel-body">
						<label for="id">아이디</label> <input type="text" id="id" name="id"
							class="form-control" /> <label for="password">비밀번호</label> <input
							type="password" id="password" name="password" class="form-control" /> 
					</div>
					
					
				</div>
			</div>
			<div class="col-sm-2"></div>
		</div>
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-2">
				<div class="btn-group">
					<button type="submit" class="btn btn-primary">로그인</button>
				</div>
			</div>
			<div class="col-sm-3"></div>
			<div class="col-sm-3">
				<div class="btn-group btn-group-justified">
					<a href="findId.jsp" class="btn btn-primary">아이디찾기</a> <a href="findPassword.jsp"
						class="btn btn-primary">비밀번호찾기</a>
				</div>
			</div>

		</div>
	</form>

	</div>



</body>
</html>