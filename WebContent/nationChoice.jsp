<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beproject.NATION" %>
<%@ page import="beproject.NationDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

function choice(eng,korea){
	
	opener.nationChoice(eng,korea);
	
	window.close();
}

</script>

<script>
$(document).ready(function(){

	$('tr').on('click',function(){
		
		choice( $(this).children('td:eq(0)').html() , $(this).children('td:eq(1)').html() );
	});
});
	
	
</script>

<title>거래처 관리</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<table class="table">
				<thead>
					<tr>
						<th>영문명</th>
						<th>한글명</th>
					</tr>
				</thead>
				<tbody>
				
<%

NationDAO ndao = new NationDAO();
ArrayList<NATION> list = ndao.getNation();

for( int i=0; i<list.size() ; i++ ) { 
%>
					<tr style="cursor: pointer" >
						<td><%= list.get(i).getENG_NAME() %></td>
						<td><%= list.get(i).getKOREA_NAME() %> </td>
					</tr>
				</tbody>
<% 
	} 
%>
			
			
			</table>
		 </div>
	</div>
</body>
</html>