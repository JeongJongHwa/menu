package beproject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.google.gson.Gson;

/**
 * Servlet implementation class MainSearchServlet
 */
@WebServlet("/MainRightSearchServlet")
public class MainRightSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=UTF-8");
		
		JSONParser parser = new JSONParser();
		JSONObject jsonObject = null;
		
		try {
			jsonObject = (JSONObject) parser.parse(getrequestBody(request));
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("변환에 실패해씁니다.");
		}
		
		String BUSI_NUM = (String) jsonObject.get("BUSI_NUM");
		
		CustomDAO customDAO = new CustomDAO();
		CUSTOM custom = customDAO.getCUSTOM( BUSI_NUM );
		AccountDAO accountDAO = new AccountDAO();
		ACCOUNT account = accountDAO.getAccount(BUSI_NUM);
		
		Gson gson = new Gson();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("CUSTOM", gson.toJson(custom));
		map.put("ACCOUNT", gson.toJson(account));
		
		response.getWriter().print( gson.toJson( map ) );
		//response.getWriter().print( gson.toJson(account) );
		
		//[{"BUSI_NUM":"111-11-11111","CUSTOM":"동아제약","CO_YN":false,"FOREIGN_YN":false,"TAX_YN":false,"SPECIAL_RELATION":false,"TRADE_STOP":false},{"BUSI_NUM":"111-12-23451","CUSTOM":"흥국제약","CO_YN":false,"FOREIGN_YN":false,"TAX_YN":false,"SPECIAL_RELATION":false,"TRADE_STOP":false},{"BUSI_NUM":"123-22-2345","CUSTOM":"asdf동아제약","CO_YN":false,"FOREIGN_YN":false,"TAX_YN":false,"SPECIAL_RELATION":false,"TRADE_STOP":false}]
		//{ACCOUNT={"BUSI_NUM":"111-11-11111","FACTORY":"강서구어딘가","TRADE_BANK":"신한은행","ACCOUNT_NUM":"22-334-5345345"}, CUSTOM={"BUSI_NUM":"111-11-11111","CUSTOM":"동아제약","SHORT":"동아","CEO":"동아사장","CHARGE_PERSON":"동아부장","BUSI_CONDITION":"A","ITEM":"타이레놀","POST_NUM":"357-12","ADDR1":"서울 ...","ADDR2":"xx빌딩 1401호 ","TEL":"025677891","FAX":"025677412","HOMEPAGE":"ehddk123@ehkt.com","CO_YN":true,"FOREIGN_YN":true,"TAX_YN":true,"COUNTRY_ENG":"KOR","COUNTRY_KOR":"대한민국","SPECIAL_RELATION":true,"TRADE_STOP":false,"CONTRACT_PERIOD_S":"1월 1, 2015","CONTRACT_PERIOD_E":"1월 1, 2018","REGI_INFO_MAN":"동아사장","REGI_INFO_DATE":"1월 2, 2015","MODI_INFO_MAN":"동아부장","MODI_INFO_DATE":"1월 2, 2018"}}

	
	}
	
	
	public static String getrequestBody(HttpServletRequest request) throws IOException {

		String reqStr = null;
		StringBuilder stringBuilder = new StringBuilder();
		BufferedReader bufferedReader = null;

		try {
			InputStream inputStream = request.getInputStream();
			if (inputStream != null) {
				bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
				char[] charBuffer = new char[128];
				int bytesRead = -1;
				while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
					stringBuilder.append(charBuffer, 0, bytesRead);
				}
			} else {
				stringBuilder.append("");
			}
		} catch (IOException ex) {
			throw ex;
		} finally {
			if (bufferedReader != null) {
				try {
					bufferedReader.close();
				} catch (IOException ex) {
					throw ex;
				}
			}
		}

		reqStr = stringBuilder.toString();
		return reqStr;
	}

}
