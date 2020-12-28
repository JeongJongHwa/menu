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
				<li  class="active"><a href="notice.jsp">공지사항</a></li>
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
				<li><a href="menuList.jsp">식단</a></li>
				<li  class="active"><a href="notice.jsp">공지사항</a></li>
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
		<form method="post" action="noticeWriteAction.jsp">
		<div class="row">
			<div class="well text-center"><h2>공지사항 글쓰기</h2></div>
			<div class="col-sm-1" ></div>
			<div class="col-sm-10" >
				<div class="panel">
					<div class="panel-body text-center">
					<label for="noticeTitle"  >글 제목</label>
						<input type="text" class="form-control" name="noticeTitle" id="noticeTitle" />
						<label for="noticeContent">글 내용</label>			
						<textarea class="form-control" rows="15" cols="125" name="noticeContent" id="noticeContent"></textarea>
					</div>	
				</div>
			</div>
			<div class="col-sm-1" ></div>
		</div>
		<div class="col-sm-6"></div>
		<button type="submit" class="btn btn-primary pull-right">글저장</button>
		
		</form>
	
	</div>



</body>
</html>