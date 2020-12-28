package menu;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.google.gson.Gson;

@WebServlet("/MenuAppraisalServlet")
public class MenuAppraisalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

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

		int menuAppraisal = Integer.parseInt((String) jsonObject.get("data"));
		int menuNumber = Integer.parseInt((String) jsonObject.get("menuNumber"));
		String id = (String) jsonObject.get("id");

		if( "null".equals(id) ) {
			// 로그인이 안되어있는경우 로그인 유도 1로진행
			response.getWriter().println(1);
			response.getWriter().close();
		}
		
		// 1 up , 0 down
		
		MenuAppraisalDAO maDAO = new MenuAppraisalDAO();
		int nowAppraisal = maDAO.getMenuappraisal(menuNumber, id);

		// -5 면 데이터 없음 새로이 작성
		// menuappraisal up 이라면 현재가 -1 일경우 1로 변경 , 현재가 1이라면 삭제
		// menuappraisal down 이라면 현재가 -1 일경우 삭제 , 현재가 1이라면 -1으로 변경
		
		if (nowAppraisal == -5) {

			maDAO.newMenuappraisal(menuNumber, id, menuAppraisal);

		} else if (menuAppraisal == 1) {

			if (nowAppraisal == -1) {
				maDAO.updateMenuappraisal(1, menuNumber, id);
			} else if (nowAppraisal == 1) {
				maDAO.deleteMenuappraisal( menuNumber, id);
			}

		} else if (menuAppraisal == -1) {

			if (nowAppraisal == -1) {
				maDAO.deleteMenuappraisal( menuNumber, id);
			} else if (nowAppraisal == 1) {
				maDAO.updateMenuappraisal(-1, menuNumber, id);
			}

		} 
		
		MenuAppraisal ma =  maDAO.getObject(menuNumber, id) ;
		
		Gson gson = new Gson();

	

		response.getWriter().print( gson.toJson(ma) );

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
