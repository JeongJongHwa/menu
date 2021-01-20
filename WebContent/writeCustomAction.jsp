<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="beproject.CUSTOM"%>
<%@ page import="beproject.CustomDAO"%>
<%@ page import="beproject.ACCOUNT"%>
<%@ page import="beproject.AccountDAO"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="custom" class="beproject.CUSTOM" scope="page"></jsp:useBean>
<jsp:setProperty property="BUSI_NUM" name="custom" />
<jsp:setProperty property="CUSTOM" name="custom" />
<jsp:setProperty property="SHORT" name="custom" />
<jsp:setProperty property="CEO" name="custom" />
<jsp:setProperty property="CHARGE_PERSON" name="custom" />
<jsp:setProperty property="BUSI_CONDITION" name="custom" />
<jsp:setProperty property="ITEM" name="custom" />
<jsp:setProperty property="POST_NUM" name="custom" />
<jsp:setProperty property="ADDR1" name="custom" />
<jsp:setProperty property="ADDR2" name="custom" />
<jsp:setProperty property="TEL" name="custom" />
<jsp:setProperty property="FAX" name="custom" />
<jsp:setProperty property="HOMEPAGE" name="custom" />
<jsp:setProperty property="CO_YN" name="custom" />
<jsp:setProperty property="FOREIGN_YN" name="custom" />
<jsp:setProperty property="TAX_YN" name="custom" />
<jsp:setProperty property="COUNTRY_ENG" name="custom" />
<jsp:setProperty property="COUNTRY_KOR" name="custom" />
<jsp:setProperty property="SPECIAL_RELATION" name="custom" />
<jsp:setProperty property="TRADE_STOP" name="custom" />
<jsp:setProperty property="CONTRACT_PERIOD_S" name="custom" />
<jsp:setProperty property="CONTRACT_PERIOD_E" name="custom" />
<jsp:setProperty property="REGI_INFO_MAN" name="custom" />
<jsp:setProperty property="REGI_INFO_DATE" name="custom" />
<jsp:setProperty property="MODI_INFO_MAN" name="custom" />
<jsp:setProperty property="MODI_INFO_DATE" name="custom" />

<jsp:useBean id="account" class="beproject.ACCOUNT" scope="page"></jsp:useBean>
<jsp:setProperty property="BUSI_NUM" name="account" />
<jsp:setProperty property="FACTORY" name="account" />
<jsp:setProperty property="TRADE_BANK" name="account" />
<jsp:setProperty property="ACCOUNT_NUM" name="account" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int accountRunning = 1;

		if (account.getFACTORY() == null && account.getTRADE_BANK() == null && account.getACCOUNT_NUM() == null) {

			accountRunning = 0;
		}

		if ("1".equals(request.getParameter("CO_YN"))) {
			custom.setCO_YN(true);
		}
		if ("1".equals(request.getParameter("FOREIGN_YN"))) {
			custom.setFOREIGN_YN(true);
		}
		if ("1".equals(request.getParameter("TAX_YN"))) {
			custom.setTAX_YN(true);
		}

		if (custom.getBUSI_NUM() == null || custom.getCUSTOM() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('사업자번호와 거래처명은 필수작성입니다.')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		} else {

			// 만약 사업자번호와 거래처명이 들어와서 기존에 있다면 수정 -> 기존에 없다면 생성

			CustomDAO cDAO = new CustomDAO();
			AccountDAO aDAO = new AccountDAO();
			int checkCustom = cDAO.checkCustom(custom.getBUSI_NUM(), custom.getCUSTOM()); // 1이면 수정 0이면 생성
			int checkAccount = aDAO.checkAccount(custom.getBUSI_NUM());

			System.out.println("checkCustom : " + checkCustom);
			System.out.println("accountRunning : " + accountRunning);
			System.out.println("checkAccount : " + checkAccount);

			// checkCustom 0 생성단계 1 수정단계
			// checkAccount 0 생성단계 1 수정단계
			// accountRunning 0이면 동작안함 1이면 동작함

			PrintWriter script = response.getWriter();
			// checkcustom 생성 account x
			if (checkCustom == 0 && accountRunning == 0) {

				cDAO.write(custom);
				script.println("<script>");
				script.println("alert('저장되었습니다.')");
				script.println("location.href='custom.jsp'");
				script.println("</script>");

				// checkcustom 생성 account 생성
			} else if (checkCustom == 0 && accountRunning == 1 && checkAccount == 0) {

				if (cDAO.write(custom, account) == 1) {
					script.println("<script>");
					script.println("alert('저장되었습니다.')");
					script.println("location.href='custom.jsp'");
					script.println("</script>");
				} else {
					script.println("<script>");
					script.println("alert('저장이 실패하였습니다.')");
					script.println("location.href='custom.jsp'");
					script.println("</script>");
				}

				// checkcustom update account 동작 x
			} else if (checkCustom == 1 && accountRunning == 0 && checkAccount == 0) {

				cDAO.update(custom);
				script.println("<script>");
				script.println("alert('저장되었습니다.')");
				script.println("location.href='custom.jsp'");
				script.println("</script>");

				// checkcustom update account update
			} else if (checkCustom == 1 && accountRunning == 1 && checkAccount == 1) {

				if (cDAO.update(custom, account) == 1) {
					script.println("<script>");
					script.println("alert('저장되었습니다.')");
					script.println("location.href='custom.jsp'");
					script.println("</script>");
				} else {
					script.println("<script>");
					script.println("alert('저장이 실패하였습니다.')");
					script.println("location.href='custom.jsp'");
					script.println("</script>");
				}

				// checkcustom update account create
			} else if (checkCustom == 1 && accountRunning == 1 && checkAccount == 0) {

				if (cDAO.updateWrite(custom, account) == 1) {
					script.println("<script>");
					script.println("alert('저장되었습니다.')");
					script.println("location.href='custom.jsp'");
					script.println("</script>");
				} else {
					script.println("<script>");
					script.println("alert('저장이 실패하였습니다.')");
					script.println("location.href='custom.jsp'");
					script.println("</script>");
				}

				// checkcustom update accountRunning 동작 x checkaccount 1
			} else if (checkCustom == 1 && accountRunning == 0 && checkAccount == 1) {

				if (cDAO.updateDelete(custom, account) == 1) {
					script.println("<script>");
					script.println("alert('저장되었습니다.')");
					script.println("location.href='custom.jsp'");
					script.println("</script>");
				} else {
					script.println("<script>");
					script.println("alert('저장이 실패하였습니다.')");
					script.println("location.href='custom.jsp'");
					script.println("</script>");
				}

			}

		}
	%>

</body>
</html>
