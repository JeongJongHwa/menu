package menu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import setting.Setting;

public class MenuAppraisalDAO {

	private Connection conn;
	private ResultSet rs;
	
	
	public MenuAppraisalDAO() {

		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			conn= DriverManager.getConnection(Setting.getDbURL(), Setting.getDbID(), Setting.getDbPassword());
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	
	}
	
	public int getMenuappraisal(int menuNumber,String id) {
		
		String SQL = "SELECT MENUAPPRAISAL FROM MENUAPPRAISAL WHERE MENUNUMBER=? AND ID=?";
				
		try {
			
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, menuNumber);
				pstmt.setString(2, id);
				
				rs = pstmt.executeQuery();
				if ( rs.next() ) {
					return rs.getInt(1);
				}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -5; // error
		
	}
	
	public MenuAppraisal getObject(int menuNumber,String id) {
		
		String SQL = "SELECT * FROM MENUAPPRAISAL WHERE MENUNUMBER=? AND ID=?";
		MenuAppraisal returnMA = null;	
		try {
			
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, menuNumber);
				pstmt.setString(2, id);
				
				rs = pstmt.executeQuery();
				if ( rs.next() ) {
					 returnMA = new MenuAppraisal();
					 returnMA.setMenuNumber( rs.getInt(1) );
					 returnMA.setId( rs.getString(2) );
					 returnMA.setMenuAppraisal( rs.getInt(3) );
				}
				
				return returnMA;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return null; // error
		
	}
	
	public int newMenuappraisal(int menuNumber,String id, int menuAppraisal) {
		
		String SQL = "INSERT INTO MENUAPPRAISAL VALUES(?,?,?)";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuNumber);
			pstmt.setString(2, id);
			pstmt.setInt(3, menuAppraisal);
			
		 	return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // db error 
	}
	
	public int updateMenuappraisal(int menuAppraisal,int menuNumber,String id ) {
		
		String SQL = "UPDATE MENUAPPRAISAL SET menuappraisal=? where menuNumber=? AND ID=?";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuAppraisal);
			pstmt.setInt(2, menuNumber);
			pstmt.setString(3, id);
			
		 	return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // db error 
	}
	
	public int deleteMenuappraisal(int menuNumber ) {
		
		String SQL = "DELETE FROM MENUAPPRAISAL WHERE menuNumber=? ";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuNumber);
			
		 	return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // db error 
	}
	
	public int deleteMenuappraisal(int menuNumber,String id ) {
		
		String SQL = "DELETE FROM MENUAPPRAISAL WHERE menuNumber=? AND ID=?";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuNumber);
			pstmt.setString(2, id);
			
		 	return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // db error 
	}
	
	public int readCntUpdate(int menuNumber ) {
		
		String SQL = "UPDATE MENU SET readCnt=readCnt+1 where menuNumber=?";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuNumber);
			
		 	return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // db error 
	}
	
}
