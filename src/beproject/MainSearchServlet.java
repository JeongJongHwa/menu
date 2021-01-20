package beproject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;

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
@WebServlet("/MainSearchServlet")
public class MainSearchServlet extends HttpServlet {
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
		String CUSTOM = (String) jsonObject.get("CUSTOM");
		
		if( "".equals(BUSI_NUM) ) {
			BUSI_NUM = " ";
		}
		
		if( "".equals(CUSTOM) ) {
			CUSTOM = " ";
		}
		
		CustomDAO customDAO = new CustomDAO();
		ArrayList<CUSTOM> list = customDAO.getList(BUSI_NUM,CUSTOM);
		
		Gson gson = new Gson();
		
		response.getWriter().print( gson.toJson(list) );
	
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
