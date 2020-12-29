<%@page import="setting.Setting"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="notice.Notice"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDAO"%>
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
		String userID = (String) session.getAttribute("userID");
		int pageNumber = 1;
		if( request.getParameter("pageNumber") != null ){
			pageNumber = Integer.parseInt( request.getParameter("pageNumber"));
		}
	
	
	if (userID == null) {
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
				<li><a><%=userID%> 님 환영합니다</a></li>
				<li><a href="logoutAction.jsp">로그아웃</a></li>
			</ul>
		</div>
	</div>
	<%
		}
	%>

	<div class="container">

		<div class="row">
			<div class="well text-center">
				<h2>공지사항</h2>
			</div>
			<div class="col-sm-1"></div>
			<div class="col-sm-10">
				<div class="panel">
					<div class="panel-body">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>글번호</th>
									<th>제목</th>
									<th>등록일자</th>
									<th>작성자</th>
								</tr>
							</thead>
							<tbody>
							<%
								NoticeDAO noticeDAO = new NoticeDAO();
								ArrayList<Notice> list = noticeDAO.getList(pageNumber);
								SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
								
								for(int i=0;list.size()>i;i++){
							%>
								<tr>
									<td><%=list.get(i).getNoticeNumber() %></td>
									<td><a  href="noticeView.jsp?noticeNumber=<%=list.get(i).getNoticeNumber() %>" ><%=list.get(i).getNoticeTitle() %></a></td>
									<td><%= format.format( list.get(i).getNoticeDate() ) %></td>
									<td><%=list.get(i).getNoticeId() %></td>
								</tr>
							<%
							}
							%>

							</tbody>
						</table>
					</div>
				</div>
			</div>
			
			
			
			<div class="col-sm-1"></div>

		</div>

		<div class="row">
			<div class="col-sm-2"></div>
			
			<%
				if( pageNumber != 1 ){
			%>
				<a class="btn btn-primary pull-left" href="notice.jsp?pageNumber=<%=pageNumber-1 %>" >이전</a>
			<%
				} if ( noticeDAO.nextPage(pageNumber+1) ) {
			%>
				<a class="btn btn-primary pull-left" href="notice.jsp?pageNumber=<%=pageNumber+1 %>" >다음</a>
			<%
				}
			%>
			
		<%
		if (Setting.getNoticeID().equals(userID)) {
		%>
			<a href="noticeWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
		<%
			}
		%>
			
		</div>

	</div>



</body>
</html>