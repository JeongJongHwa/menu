<%@page import="menu.MenuImageDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.Writer"%>
<%@page import="menu.MenuDAO" %>
<%@page import="menu.Menu" %>
<%@page import="menu.MenuAppraisalDAO" %>
<%@page import="menu.MenuAppraisal" %>
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
<input type="hidden" id="myID" name="myID" value="<%=session.getAttribute("userID") %>" />

<%
	
	String data = request.getParameter("data5");
	String data1 = request.getParameter("data6");
			
%>

	<%
		String userID =  (String) session.getAttribute("userID");
		int menuNumber;
		if ( request.getParameter("menuNumber") == null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근이 올바르지 않습니다')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		} else {
			
			menuNumber = Integer.parseInt( request.getParameter("menuNumber")) ;
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
			
			MenuDAO menuDAO = new MenuDAO();
			Menu menu = menuDAO.getMenu(menuNumber);
			
			menuDAO.readCntUpdate(menuNumber);
			
			MenuImageDAO menuImageDAO = new MenuImageDAO();
			int menuImageNumber = menu.getMenuImageNumber();
			String imageName=""; 
			
			String imageSrc = "./upload/";
			
			if( menuImageNumber != 0 ){
				imageName = menuImageDAO.getImage( menuImageNumber );
			} else {
				imageName = "대체이미지.jpg";  // 대체 이미지 사용
			}
			
	%>
	
	<div class="container">
		<form action="menuUpdateAction.jsp" method="post" >
		<input type="hidden" id="menuNumber" name="menuNumber" value="<%=menu.getMenuNumber() %>" />
		<div class="row">
			<div class="well text-center"><h2>식단 보기</h2></div>
			<div class="col-sm-1" ></div>
			<div class="col-sm-10" >
				<div class="panel">
					<div class="panel-body">
						<div class="row text-center">
							<label for="menuTitle">제목</label>
							<input class="form-control" id="menuTitle" name="menuTitle" value="<%=menu.getMenuTitle() %>" readonly="readonly"  />
							<div class="col-sm-6">
								<label for="menuDate">일자</label>
								<input class="form-control" id="menuDate" name="menuDate" value="<%=menu.getMenuDate() %>" readonly="readonly" />
							</div>
							<div class="col-sm-6">
								<label for="readCnt">조회수</label>
								<input class="form-control" id="readCnt" name="readCnt" value="<%=menu.getReadCnt() %>" readonly="readonly" />
							</div>
							<label for="menuContent">내용</label>
							<textarea class="form-control" id="menuContent" name="menuContent" rows="10" cols="200" readonly="readonly"><%= menu.getMenuContent() %></textarea><br/>
							<img class="img-rounded" alt="대체 이미지" src="<%=imageSrc+imageName %>" width="800px" height="700px" />
						</div>
					</div>	
				</div>
			</div>
			<div class="col-sm-1" ></div>
		</div>
		<div class="row text-center" >
			<div class="col-sm-5"></div>
			<div class="col-sm-3">
			<%
				MenuAppraisalDAO MADAO = new MenuAppraisalDAO();
				int MenuAppraisal = MADAO.getMenuappraisal(menuNumber, (String) session.getAttribute("userID"));
				
				if( MenuAppraisal == 1 ){
			%>
				<p id="upBtn" updown="1" style="font-size:80px;cursor: pointer;" class="pull-left">&#128077;&#127995;</p>
				<p id="downBtn" updown="-1" style="font-size:80px;cursor: pointer;" class="pull-left">&#128078;&#127999;</p>
			<% 
				} else if ( MenuAppraisal == -1 ){
			%>
				<p id="upBtn" updown="1" style="font-size:80px;cursor: pointer;" class="pull-left">&#128077;&#127999;</p>
				<p id="downBtn" updown="-1" style="font-size:80px;cursor: pointer;" class="pull-left">&#128078;&#127995;</p>
			<% 
				} else {
			%>
				<p id="upBtn" updown="1" style="font-size:80px;cursor: pointer;" class="pull-left">&#128077;&#127999;</p>
				<p id="downBtn" updown="-1" style="font-size:80px;cursor: pointer;" class="pull-left">&#128078;&#127999;</p>
			<% 
				}
			%>
			</div>
			<div class="col-sm-4"></div>
		</div>
		
		</form>
		
		<div class="row" >
			<div class="col-sm-1" ></div>
				<a class="btn btn-primary pull-left" href="menuList.jsp">뒤로가기</a>
	<% 
		if( menu.getId().equals( session.getAttribute("userID") )  ){			
	%>
				<a class="btn btn-primary pull-right" href="menuDeleteAction.jsp?menuNumber=<%=menu.getMenuNumber() %>">삭제하기</a>
				<a class="btn btn-primary pull-right" href="menuUpdate.jsp?menuNumber=<%=menu.getMenuNumber() %>">수정하기</a>
	<% 
		} 
	%>
			
		</div>
	</div>
	<br/><br/><br/>
		
	
	<%
		}
	%>


<script>
$(document).ready(function(){
	
	var upDown = {
			darkUp:"&#128077;&#127999;",
			Up:"&#128077;&#127995;",
			darkDown:"&#128078;&#127999;",
			Down:"&#128078;&#127995;"
	} ;
	
	$('p[updown]').on('click',function(e){
		
		var param = {
				menuNumber:$("#menuNumber").val() ,
				id:$("#myID").val(),
				data: $(this).attr("updown")
		};
		
		if( param.id == "null" ){
			alert("로그인을 해주세요.");		
			return 0;
		}
		
		
		$.ajax({
			type:'post',
			url:"MenuAppraisalServlet",
			data:JSON.stringify(param),
			dataType:'json',
			contentType: "application/json; charset=utf-8",
			success:function(data){
				
				if( data == 1 ){
					alert("로그인을 해주시기 바랍니다.");
					location.href='login.jsp';
				} else {
					
					if( data == null ){
						$("#upBtn").html(upDown.darkUp);
						$("#downBtn").html(upDown.darkDown);
						// 따봉색 원래대로
					} else {
						
						if( data.menuAppraisal == 1 ){
							$("#upBtn").html(upDown.Up);
							$("#downBtn").html(upDown.darkDown);
						} else if ( data.menuAppraisal == -1 ){
							$("#downBtn").html(upDown.Down);
							$("#upBtn").html(upDown.darkUp);
						}
						// 따봉색 주기
					}
				}
			},
			error:function(request, status, error){
				 var msg = "ERROR : " + request.status + "<br>"
			      msg +=  + "내용 : " + request.responseText + "<br>" + error;
			}
		});
	});
});

</script>


</body>
</html>
