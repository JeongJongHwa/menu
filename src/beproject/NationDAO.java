package beproject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import setting.Setting;

public class NationDAO {

	private Connection conn;
	private ResultSet rs;

	public NationDAO() {
		
		try {

			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(Setting.getDbURL(), Setting.getDbID(), Setting.getDbPassword());

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public ArrayList<NATION> getNation() {
		
		String SQL = "SELECT ENG_NAME,KOREA_NAME FROM NATION";
				
		try {
			
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				
				ArrayList<NATION> list = new ArrayList<NATION>();
				
				while ( rs.next() ) {
					NATION nation= new NATION();
					nation.setENG_NAME(rs.getString(1));
					nation.setKOREA_NAME(rs.getString(2));
					list.add(nation);
				}
				
				return list;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
		
	}
}