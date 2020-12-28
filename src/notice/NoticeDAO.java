package notice;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class NoticeDAO {

	private Connection conn;
	private ResultSet rs;
	
	public NoticeDAO() {
		
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
			
			if(  rs.next()) {
				return rs.getString(1);
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";  // db error
		
	}
	
	public int getNext() {
		String SQL = "SELECT noticeNumber FROM notice order by noticeNumber desc";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(  rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫번쨰 게시글 인경우
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;  // db error
		
	}
	
	public int write(String noticeTitle,String noticeId, String noticeContent) {
		
		String SQL = "INSERT INTO NOTICE VALUES(?,?,?,?,?,?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, noticeTitle);
			pstmt.setString(3, noticeContent);
			pstmt.setString(4, getDate());
			pstmt.setString(5, noticeId);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate(); 
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // db error
		
	}
	
	public ArrayList<Notice> getList (int pageNumber){
		
		String SQL = "SELECT * FROM NOTICE WHERE NOTICENUMBER < ? AND NOTICEAVAILABLE = 1 ORDER BY NOTICENUMBER DESC LIMIT 10";
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs= pstmt.executeQuery();
			
			while( rs.next() ) {
				Notice notice = new Notice();
				notice.setNoticeNumber(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setNoticeContent(rs.getString(3));
				notice.setNoticeDate(rs.getDate(4));
				notice.setNoticeId(rs.getString(5));
				notice.setNoticeAvailable(rs.getInt(6));
				
				list.add(notice);
			}
			
		} catch( Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		
		String SQL = "SELECT * FROM NOTICE WHERE NOTICENUMBER < ? AND NOTICEAVAILABLE = 1 ";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs= pstmt.executeQuery();
		    
			if( rs.next() ) {
				return true;
			}
			
			
		} catch( Exception e) {
			e.printStackTrace();
		}
		
		return false;
		
	}
	
	public Notice getNotice(int noticeNumber) {
		
		String SQL = "SELECT * FROM NOTICE WHERE NOTICENUMBER = ?";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, noticeNumber);
			
			rs = pstmt.executeQuery();
			
			if ( rs.next() ) {
				
				Notice notice = new Notice();
				notice.setNoticeNumber(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setNoticeContent(rs.getString(3));
				notice.setNoticeDate(rs.getDate(4));
				notice.setNoticeId(rs.getString(5));
				notice.setNoticeAvailable(rs.getInt(6));
				
				return notice;
			} 
			
		} catch( Exception e ) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
public int update(String noticeTitle,String noticeContent,int noticeNumber) {
		
		String SQL = "UPDATE NOTICE SET noticeTitle=?,noticeContent=? where noticeNumber=?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, noticeTitle);
			pstmt.setString(2, noticeContent);
			pstmt.setInt(3, noticeNumber);
			
			return pstmt.executeUpdate(); 
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // db error
		
	}
	
	public int delete(int noticeNumber) {
		
		String SQL = "UPDATE NOTICE SET NOTICEAVAILABLE = ? WHERE NOTICENUMBER = ?";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, 0);
			pstmt.setInt(2, noticeNumber);
			
			return pstmt.executeUpdate();
			
		} catch( Exception e) {
			
		}
		
		return -1;
		
	}
	
	
}
