package menu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MenuDAO {

	private Connection conn;
	private ResultSet rs;
	
	
	public MenuDAO() {

		try {
			
			String dbURL="jdbc:mysql://localhost:3306/menu";
			String dbID="root";
			String dbPassword="root";
			Class.forName("com.mysql.jdbc.Driver");
			conn= DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	
	}
	
	public String getDate() {
		
		String SQL = "SELECT NOW()";
				
		try {
			
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				rs = pstmt.executeQuery();
				if ( rs.next() ) {
					return rs.getString(1);
				}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	public int getNext() {
		
		String SQL = "SELECT MENUNUMBER FROM MENU ORDER BY MENUNUMBER DESC LIMIT 1";
				
		try {
			
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				rs = pstmt.executeQuery();
				if ( rs.next() ) {
					return rs.getInt(1) + 1;
				}
			
				return 1;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return 0;
		
	}
	
	public int write(String menuTitle, String menuContent,String id ) {
		
		String SQL = "INSERT INTO MENU VALUES( ?,?,?,?,?,?,?,?,?)";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, menuTitle);
			pstmt.setString(3, menuContent);
			pstmt.setString(4, getDate());
			pstmt.setString(5, id);
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 1);
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			
		 	return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // db error 
	}
	
public int write(String menuTitle, String menuContent,String id ,int menuImageNumber) {
		
		String SQL = "INSERT INTO MENU VALUES( ?,?,?,?,?,?,?,?,?)";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, menuTitle);
			pstmt.setString(3, menuContent);
			pstmt.setString(4, getDate());
			pstmt.setString(5, id);
			pstmt.setInt(6, menuImageNumber);
			pstmt.setInt(7, 1);
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			
		 	return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // db error 
	}
	
	public ArrayList<Menu> getList(int pageNumber){
		
		String SQL = "SELECT * FROM MENU WHERE MENUNUMBER < ? AND MENUAVAILABLE=1 ORDER BY MENUNUMBER DESC LIMIT 10 ";
		ArrayList<Menu> returnMenu = new ArrayList<Menu>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - ( pageNumber -1 ) * 10  );
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				
				Menu menu = new Menu();
				
				menu.setMenuNumber( rs.getInt(1) );
				menu.setMenuTitle( rs.getString(2) );
				menu.setMenuContent( rs.getString(3) );
				menu.setMenuDate( rs.getDate(4) );
				menu.setId(rs.getString(5) );
				menu.setMenuImageNumber( rs.getInt(6) );
				menu.setMenuAvailable( rs.getInt(7) );
				menu.setReadCnt( rs.getInt(8) );
				
				returnMenu.add(menu);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return returnMenu;
	}
	
	public ArrayList<Menu> mainList(){
		
		String SQL = "select menu.menunumber,menu.menutitle,menu.menucontent,menu.menudate,menu.id,menu.menuimagenumber,menu.menuavailable,menu.readcnt,sum(menuappraisal) "
				+ "from menu, menuappraisal where menu.menunumber=menuappraisal.menunumber "
				+ "group by menu.menunumber having sum(menuappraisal)>0 order by sum(menuappraisal) desc limit 3;";
		ArrayList<Menu> returnMenu = new ArrayList<Menu>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				
				Menu menu = new Menu();
				
				menu.setMenuNumber( rs.getInt(1) );
				menu.setMenuTitle( rs.getString(2) );
				menu.setMenuContent( rs.getString(3) );
				menu.setMenuDate( rs.getDate(4) );
				menu.setId(rs.getString(5) );
				menu.setMenuImageNumber( rs.getInt(6) );
				menu.setMenuAvailable( rs.getInt(7) );
				menu.setReadCnt( rs.getInt(8) );
				menu.setSumAppraisal( rs.getInt(9) );
				returnMenu.add(menu);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return returnMenu;
	}
	
	public boolean nextPage(int pageNumber) {
		
		String SQL = "SELECT * FROM MENU WHERE MENUNUMBER < ? AND MENUAVAILABLE = 1";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - ( pageNumber -1 ) * 10   );
			// 가장 마지막번호를 getnext 로 가져와서  15 번떄의 글   
			//기본페이지는 1 이며 다음페이지로 갈경우 2페이지 기준 true 가 완성된다
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				return true;
			}
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public Menu getMenu(int menuNumber) {
		
		String SQL = "SELECT * FROM MENU WHERE MENUNUMBER = ?";
		Menu menu = new Menu();
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuNumber);
			rs =  pstmt.executeQuery();
			
			
			if ( rs.next() ) {
				menu.setMenuNumber( rs.getInt(1) );
				menu.setMenuTitle( rs.getString(2) );
				menu.setMenuContent( rs.getString(3) );
				menu.setMenuDate( rs.getDate(4) );
				menu.setId( rs.getString(5) );
				menu.setMenuImageNumber( rs.getInt(6) );
				menu.setMenuAvailable( rs.getInt(7) );
				menu.setReadCnt( rs.getInt(8) );
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return menu;
		
	}
	
	public int update(String menuTitle, String menuContent,int menuNumber ) {
		
		String SQL = "UPDATE MENU SET menuTitle=?,menuContent=? where menuNumber=?";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, menuTitle);
			pstmt.setString(2, menuContent);
			pstmt.setInt(3, menuNumber);
			
		 	return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // db error 
	}
	
	public int updateImage(String menuTitle, String menuContent,int menuImageNumber,int menuNumber ) {
		
		String SQL = "UPDATE MENU SET menuTitle=?,menuContent=?,menuImageNumber=? where menuNumber=?";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, menuTitle);
			pstmt.setString(2, menuContent);
			pstmt.setInt(3, menuImageNumber);
			pstmt.setInt(4, menuNumber);
			
		 	return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // db error 
	}
	
	public int delete(int menuNumber ) {
		
		String SQL = "UPDATE MENU SET menuAvailable=? where menuNumber=?";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, 0);
			pstmt.setInt(2, menuNumber);
			
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
