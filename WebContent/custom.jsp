<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
function postNumFind() {
    new daum.Postcode({
        oncomplete: function(data) {
            
        	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("ADDR2").value = extraAddr;
            
            } else {
                document.getElementById("ADDR2").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('POST_NUM').value = data.zonecode;
            document.getElementById("ADDR1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("ADDR2").focus();
        	
        	
            document.getElementById('POST_NUM').value = data.zonecode;
            document.getElementById('POST_NUM').value = data.zonecode;
            document.getElementById('POST_NUM').value = data.zonecode;
           
        }
    }).open();
}

function open_popup(){
    window.open('nationChoice.jsp','windowPop','width=600, height=600, left=400, top=400,resizable = yes');
}

function nationChoice(ENG_NAME,KOREA_NAME){
	 document.getElementById('COUNTRY_ENG').value = ENG_NAME+"";
	 document.getElementById('COUNTRY_KOR').value = KOREA_NAME+"";
}
</script>


<script>
$(document).ready(function(){
	
	$("button[nationBtn]").on('click',function(e){
		
	});
	
	$("button[delBtn]").on('click',function(e){
		location.href='deleteCustomAction.jsp?BUSI_NUM='+$("#BUSI_NUM").val()+'&CUSTOM='+$("#CUSTOM").val();
	});
	
	$('button[btn5]').on('click',function(e){
		
		$('#table').html("<thead><tr class='text-center'><th class='text-center'>사업자 번호</th><th class='text-center'>거래처명</th></tr></thead><tbody><tr></tr></tbody>");
		
		var param = {
			BUSI_NUM:$('#BUSI_NUM_LT').val(),	
			CUSTOM:$('#CUSTOM_LT').val(),
			TYPE:''
		};
		
		if( ! param.BUSI_NUM && ! param.CUSTOM ){
			alert( "사업자번호 혹은 거래처명을 입력해주세요" );
			return 0;
		}
		
		$.ajax({
			type:'post',
			url:"MainSearchServlet",
			data:JSON.stringify(param),
			dataType:'json',
			contentType: "application/json; charset=utf-8",
			success:function(data){
				
				var results = data;
	            var str = "";
	            
	            $.each(results , function(i){
	                str += "<tr class='abab' style='cursor: pointer' rn="+results[i].BUSI_NUM+" ><td>" + results[i].BUSI_NUM +
	                						'</td><td>' + results[i].CUSTOM + '</td>';
	                str += '</tr>';
	           });
	           $('#table').append(str); 
				
			},
			error:function(request, status, error){
				 var msg = "ERROR : " + request.status + "<br>"
			      msg +=  + "내용 : " + request.responseText + "<br>" + error;
			}
		});
	});
	
	$(document).on('dblclick','.abab',function(e){

		$('#rightTable').html(" ");
		
		/* $('#rightTable').html("<thead><tr class='text-center'><th class='text-center'>"+
				"사무소</th><th class='text-center'>은행</th><th class='text-center'>계좌번호</th></tr></thead>"+
				"<tbody><tr><td><input type='text' name='FACTORY' class='form-data in_s'  maxlength='20' /></td>"+
				"<td><input type='text' name='TRADE_BANK' class='form-data in_s'  maxlength='20' /></td>"+
				"<td><input type='text' name='ACCOUNT_NUM' class='form-data in_s'  maxlength='20' /></td></tr></tbody>");
		 */
		var param = {
				BUSI_NUM:$(this).attr('rn'),	
		};
		
		if( ! BUSI_NUM ){
			alert("올바르지 않은 방식입니다.");
		}
		
		$.ajax({
			type:'post',
			url:"MainRightSearchServlet",
			data:JSON.stringify(param),
			dataType:'json',
			contentType: "application/json; charset=utf-8",
			success:function(data){
				
				$("form").each(function() {
				       this.reset();

				      $("input[type=hidden]").val(''); //reset만으로 hidden type은 리셋이 안되기 때문에 써줌
				  });
				
				var CUSTOM = JSON.parse( data['CUSTOM'] );
				var ACCOUNT = JSON.parse( data['ACCOUNT'] ); 
				
				var tableHead = "<thead><tr class='text-center'><th class='text-center'>"+
				"사무소</th><th class='text-center'>은행</th><th class='text-center'>계좌번호</th></tr></thead>";
				
				
				if(Object.keys(ACCOUNT).length == 0){
					
					 $('#rightTable').html(tableHead+
					"<tbody><tr><td><input type='text' name='FACTORY' class='form-data in_s'  maxlength='20' /></td>"+
					"<td><input type='text' name='TRADE_BANK' class='form-data in_s'  maxlength='20' /></td>"+
					"<td><input type='text' name='ACCOUNT_NUM' class='form-data in_s'  maxlength='20' /></td></tr></tbody>");
			 
					
				} else {
					var str=tableHead;
		               
					str += "<tbody><tr><td><input type='text' name='FACTORY' class='form-data in_s'  maxlength='20' value='"+ACCOUNT.FACTORY+"'/></td>" 
					+"<td><input type='text' name='TRADE_BANK' class='form-data in_s'  maxlength='20' value='"+ACCOUNT.TRADE_BANK+"'/></td>" 
					+"<td><input type='text' name='ACCOUNT_NUM' class='form-data in_s'  maxlength='20' value='"+ACCOUNT.ACCOUNT_NUM+"'/></td></tr></tbody>" ;
					
				 $('#rightTable').append(str); 
				 
				/*  <td><input type="text" name="FACTORY" class="form-data in_s"  maxlength="20" /></td>
					<td><input type="text" name="TRADE_BANK" class="form-data in_s"  maxlength="20" /></td>
					<td><input type="text" name="ACCOUNT_NUM" class="form-data in_s"  maxlength="20" /></td> */
				 
				 
				 
				}

				var type;
				
				$.each( CUSTOM, function (key,value){
					
					type = $(".right_row *[name="+key+"]").attr("type");
					
					if( type == "text" ){
						$(".right_row *[name="+key+"]").val(value);
					} else if ( type== "checkbox" ){
						
						if( value == true ){
							$(".right_row *[name="+key+"]").prop('checked',true);
						}else {
							$(".right_row *[name="+key+"]").prop('checked',false);
						}					
						
					} else if ( type== "radio" ){
						
						//console.log( "key : "+key+"   value : "+value );
						if( value === true ){
							$(".right_row *[name="+key+"][value=1]").prop('checked',true);
						} else {
							$(".right_row *[name="+key+"][value=0]").prop('checked',true);
						}
						
					} else if( type == "date" ){
						
						$(".right_row *[name="+key+"]").val(value);
						
					} else if( $("select[name="+key+"]").attr("name") == key ){
						
						//console.log( "key : "+key+"   value : "+value );
						if( value == true ){
							$("#"+key).val("1");
							//$("select[name="+key+"]").attr("name").val("1");
						} else {
							$("#"+key).val("0");
							//$("select[name="+key+"]").attr("name").val("0");
						}
					}
				});

				
			},
			error:function(request, status, error){
				 var msg = "ERROR : " + request.status + "<br>"
			      msg +=  + "내용 : " + request.responseText + "<br>" + error;
			}
		});
		
		
		
	});
	
	
});


</script>


<style>
.in_s1 {
	width: 45px;
	height: 25px;
	font-size: 12px;
}
.in_s2 {
	width: 90px;
	height: 25px;
	font-size: 12px;
}

.in_s {
	width: 145px;
	height: 25px;
	font-size: 12px;
}

.in_b {
	width: 290px;
	height: 25px;
	font-size: 12px;
}

.btn_s {
	width: 40px;
	height: 25px;
	padding: 0;
}
</style>
<title>거래처 관리</title>
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
				<li  class="active" ><a href="custom.jsp">식단 거래처 관리</a></li>
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
				<li ><a class="navbar-brand" href="index.jsp">육식메인화면</a></li>
				<li><a href="menuList.jsp">식단</a></li>
				<li><a href="notice.jsp">공지사항</a></li>
				<li class="active" ><a href="custom.jsp">식단 거래처 관리</a></li>
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



	<div class="navbar">
		<div class="container">
			<ul class="nav navbar-nav navbar-right">
				<li><button type="submit" form="saveForm" class="btn btn-primary" >저장</button></li>
				<li><button delBtn class="btn btn-primary" >삭제</button></li>
			</ul>
		</div>
	</div>

	<div class="container">
	
		<div class="row">
			<div class="col-sm-3 pull-left" style="border: 1px solid black;">
				<div class="row">
					<br /> <label for="BUSI_NUM_LT">사업자번호</label> 
					<input type="text" id="BUSI_NUM_LT" name="BUSI_NUM_LT" class="form-data in_s" maxlength="20" /></br>
					

					<label for="CUSTOM_LT">거래처명 </label> 
					<input type="text" id="CUSTOM_LT" name="CUSTOM_LT" class="form-data in_s" maxlength="20" />
					<button type="button" class="btn btn-right pull-right btn_s" btn5>조회</button>
					<br />

				</div>
				<div class="row">
					<div style="border: 1px solid black;">
						<table id="table" class="table text-center table-bordered table-hover">
							<thead>
								<tr class="text-center">
									<th class="text-center">사업자 번호</th>
									<th class="text-center">거래처명</th>
								</tr>
							</thead>
							<tbody>
								<tr>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>



<form action="writeCustomAction.jsp" id="saveForm" method="post" name="indexForm">
		<div class="right_row">
		
			<div class="col-sm-9" style="border: 1px solid black;">
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="BUSI_NUM">사업자번호</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="BUSI_NUM" name="BUSI_NUM" class="form-data in_s" maxlength="20" />
					</div>
					<div class="col-sm-2">
						<label for="SHORT">약칭</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="SHORT" name="SHORT" class="form-data in_s" maxlength="20" /><br />
					</div>
				</div>
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="CUSTOM">거래처명</label>
					</div>
					<div class="col-sm-10">
						<input type="text" id="CUSTOM" name="CUSTOM" class="form-data in_b" maxlength="10" /><br />
					</div>
				</div>
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="CEO">대표자</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="CEO" name="CEO" class="form-data in_s" maxlength="10" />
					</div>

					<div class="col-sm-2">
						<label for="CHARGE_PERSON">담당자</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="CHARGE_PERSON" name="CHARGE_PERSON" class="form-data in_s" maxlength="10" /><br />
					</div>
				</div>
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="BUSI_CONDITION">업태</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="BUSI_CONDITION" name="BUSI_CONDITION" class="form-data in_s" maxlength="10" />
					</div>
					<div class="col-sm-2">
						<label for="ITEM">종목</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="ITEM" name="ITEM" class="form-data in_s" maxlength="10" />
					</div>
				</div>
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="POST_NUM">우편번호</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="POST_NUM" name="POST_NUM" class="form-data in_s" maxlength="10" />
						<button type="button" onclick="postNumFind()" class="btn btn-right pull-right btn_s">검색</button>
						<!-- 검색 클릭시 검색창 띄우서 데이터 넣는방식으로 .. -->
					</div>
					<div class="col-sm-2">
						<label for="ADDR1">주소1</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="ADDR1" name="ADDR1" class="form-data in_s" maxlength="80" />
					</div>
				</div>
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="ADDR2">주소2</label>
					</div>
					<div class="col-sm-10">
						<input type="text" id="ADDR2" name="ADDR2" class="form-data in_b" maxlength="80" /><br />
					</div>
				</div>
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="TEL">전화번호</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="TEL" name="TEL" class="form-data in_s" maxlength="10" />
					</div>
					<div class="col-sm-2">
						<label for="FAX">팩스번호</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="FAX" name="FAX" class="form-data in_s" maxlength="10" />
					</div>
				</div>
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="HOMEPAGE">홈페이지</label>
					</div>
					<div class="col-sm-10">
						<input type="text" id="HOMEPAGE" name="HOMEPAGE" class="form-data in_b" maxlength="20" />
					</div>
				</div>
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="CO_YN">법인여부</label>
					</div>
					<div class="col-sm-4">
						<input type="radio"  name="CO_YN" value="0" /> <label for="CO_YN">법인</label>
						<input type="radio" name="CO_YN" value="1" /> <label for="CO_YN">개인</label>
					</div>
					<div class="col-sm-2">
						<label for="FOREIGN_YN">해외여부</label>
					</div>
					<div class="col-sm-4">
						<input type="radio" name="FOREIGN_YN" value="0" /> <label for="FOREIGN_YN">국내</label>
						<input type="radio" name="FOREIGN_YN" value="1"  /> <label for="FOREIGN_YN">해외</label>
					</div>
				</div>
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="TAX_YN">과세구분</label>
					</div>
					<div class="col-sm-4">
						<select id="TAX_YN" name="TAX_YN">
							<option value="0">과세/면세</option>
							<option value="1">비과세</option>
						</select>
					</div>
					<div class="col-sm-2">
						<label for="COUNTRY_ENG">국가</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="COUNTRY_ENG" name="COUNTRY_ENG"  class="form-data in_s1" maxlength="20" />
						<input type="text" id="COUNTRY_KOR" name="COUNTRY_KOR" class="form-data in_s2" maxlength="20" />
						<a href="#" class="btn btn-primary" onclick="open_popup();">검색</a>
					</div>
				</div>
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="SPECIAL_RELATION">특수관계자</label>
					</div>
					<div class="col-sm-4">
						<input type="checkbox" id="SPECIAL_RELATION" name="SPECIAL_RELATION" class="form-data in_s" />
					</div>
					<div class="col-sm-2">
						<label for="TRADE_STOP">거래중지</label>
					</div>
					<div class="col-sm-4">
						<input type="checkbox" id="TRADE_STOP" name="TRADE_STOP" class="form-data in_s" maxlength="20" />
					</div>
				</div>
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="CONTRACT_PERIOD_S">계약기간</label>
					</div>
					<div class="col-sm-10">
						<input type="date" name="CONTRACT_PERIOD_S" date-type="1" class="form-data in_s" /> ~ 
						<input type="date" name="CONTRACT_PERIOD_E" date-type="1" class="form-data in_s"	/>
					</div>
				</div>
				<div class="row" style="padding: 1px;">
					<div class="col-sm-2">
						<label for="REGI_INFO_MAN">등록정보</label>
					</div>
					<div class="col-sm-4">
						<input type="text" name="REGI_INFO_MAN" class="form-data in_s1" maxlength="10" />
						<input type="text" name="REGI_INFO_DATE" readonly="readonly" date-type="2" class="form-data in_s" />
					</div>

					<div class="col-sm-2">
						<label for="MODI_INFO_MAN">변경정보</label>
					</div>
					<div class="col-sm-4">
						<input type="text" name="MODI_INFO_MAN" class="form-data in_s1" maxlength="10" />
						<input type=text name="MODI_INFO_DATE" readonly="readonly" date-type="2" class="form-data in_s" />
					</div>
				</div>
				<div class="col-sm-12">(거래처 계좌정보)</div>

				<table id="rightTable" class="table text-center table-bordered">
					<thead>
						<tr class="text-center">
							<th class="text-center">사무소</th>
							<th class="text-center">은행</th>
							<th class="text-center">계좌번호</th>
						</tr>
					</thead>
					<tbody>
					 	<tr>
							<td><input type="text" name="FACTORY" class="form-data in_s"  maxlength="20" /></td>
							<td><input type="text" name="TRADE_BANK" class="form-data in_s"  maxlength="20" /></td>
							<td><input type="text" name="ACCOUNT_NUM" class="form-data in_s"  maxlength="20" /></td>
						</tr>
						 
					</tbody>
				</table>
			</div>
			
			</div>


</form>
		</div>
	</div>
</body>
</html>