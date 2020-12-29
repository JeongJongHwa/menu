package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import setting.Setting;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	
	public UserDAO() {
		
try {
			
			Class.forName("com.mysql.jdbc.Driver");
			conn= DriverManager.getConnection(Setting.getDbURL(), Setting.getDbID(), Setting.getDbPassword());
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public int login( String id, String password) {
		
		String SQL = "SELECT password FROM USER WHERE ID=? ";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				if( rs.getString(1).equals(password) ) {
					return 1; // 로그인 성공
				} else return 0;  // 비밀번호 불일치
			}
			return -1; // ID 없음
			
		} catch( Exception e) {
			e.printStackTrace();
		}
		
		return -2; // db error
		
	}
	
	public int userJoin(User user) {
		
		String SQL = "INSERT INTO USER VALUES(?,?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getMemberdate());
			pstmt.setString(5, user.getGender());
			pstmt.setString(6, user.getEmail());
			
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;  // db error
	}
	
	public String findId( String name, String memberdate, String email) {
		
		String SQL = "SELECT id FROM USER WHERE name=? AND memberdate=? AND email=? ";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, name);
			pstmt.setString(2, memberdate);
			pstmt.setString(3, email);
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				return rs.getString(1);
			}
			
			
		} catch( Exception e) {
			e.printStackTrace();
		}
		
		return null; // db error
		
	}
	
	public String findPassword( String name, String memberdate, String email,String id) {
		
		String SQL = "SELECT password FROM USER WHERE name=? AND memberdate=? AND email=? AND id=? ";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, name);
			pstmt.setString(2, memberdate);
			pstmt.setString(3, email);
			pstmt.setString(4, id);
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				return rs.getString(1);
			}
			
			
		} catch( Exception e) {
			e.printStackTrace();
		}
		
		return null; // db error
		
	}
	
	
	
	
	
}
