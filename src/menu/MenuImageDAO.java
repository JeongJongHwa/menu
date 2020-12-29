package menu;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.eclipse.jdt.internal.compiler.batch.FileFinder;

import setting.Setting;

public class MenuImageDAO {

	private Connection conn;
	private ResultSet rs;

	public MenuImageDAO() {

		try {

			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(Setting.getDbURL(), Setting.getDbID(), Setting.getDbPassword());

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public int getNext() {

		String SQL = "SELECT MENUIMAGENUMBER FROM MENUIMAGE ORDER BY MENUIMAGENUMBER DESC LIMIT 1";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}

			return 1;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;

	}

	public int write(String imageName1, int menuImageNumber) {

		String SQL = "INSERT INTO MENUIMAGE VALUES( ?,?,?,?)";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuImageNumber);
			pstmt.setString(2, imageName1);
			pstmt.setString(3, "");
			pstmt.setString(4, "");

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1; // db error
	}

	public int write(String imageName1, String imageName2, int menuImageNumber) {

		String SQL = "INSERT INTO MENUIMAGE VALUES( ?,?,?,?)";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuImageNumber);
			pstmt.setString(2, imageName1);
			pstmt.setString(3, imageName2);
			pstmt.setString(4, "");

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1; // db error
	}

	public int write(String imageName1, String imageName2, String imageName3, int menuImageNumber) {

		String SQL = "INSERT INTO MENUIMAGE VALUES( ?,?,?,?)";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuImageNumber);
			pstmt.setString(2, imageName1);
			pstmt.setString(3, imageName2);
			pstmt.setString(4, imageName3);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1; // db error
	}

	public String getImage(int menuImageNumber) {

		String SQL = "SELECT * FROM MENUIMAGE WHERE MENUIMAGENUMBER = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuImageNumber);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				return rs.getString(2);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null; // db error

	}

	public boolean isImage(int menuNumber) {

		String SQL = "SELECT MENUIMAGE.MENUIMAGENUMBER FROM MENUIMAGE JOIN MENU ON MENUIMAGE.MENUIMAGENUMBER=MENU.MENUIMAGENUMBER WHERE MENU.MENUNUMBER = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuNumber);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				return true;

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false; // db error

	}

	public ArrayList<MenuImage> getImages(int menuImageNumber) {

		String SQL = "SELECT * FROM MENUIMAGE WHERE MENUIMAGENUMBER = ?";
		ArrayList<MenuImage> returnMenuImage = new ArrayList<MenuImage>();

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuImageNumber);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MenuImage menuImage = new MenuImage();
				menuImage.setMenuImageNumber(rs.getInt(1));
				menuImage.setImageName1(rs.getString(2));
				menuImage.setImageName2(rs.getString(2));
				menuImage.setImageName3(rs.getString(3));
				returnMenuImage.add(menuImage);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnMenuImage; // db error

	}

	public boolean deleteImage(int menuNumber) {

		String SQL = "SELECT MENUIMAGE.IMAGENAME1,MENUIMAGE.MENUIMAGENUMBER FROM MENUIMAGE JOIN MENU ON MENUIMAGE.MENUIMAGENUMBER=MENU.MENUIMAGENUMBER WHERE MENU.MENUNUMBER = ?";
		System.out.println(SQL);

		String menuImageName = "";
		int menuImageNumber = 0;
		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuNumber);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				menuImageName = rs.getString(1);
				menuImageNumber = rs.getInt(2);
			} else {
				return false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		String fileURL = "E:\\eclipseWorkspace\\menuproject\\WebContent\\upload\\" + menuImageName;

		File file = new File(fileURL);

		if (file.delete()) {

			if (deleteImageNumber(menuImageNumber) != 1) {
				return false;
			}

			return true;
		}

		return false;

	}

	public int deleteImageNumber(int menuImageNumber) {

		String SQL = "DELETE FROM MENUIMAGE WHERE MENUIMAGENUMBER = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, menuImageNumber);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1; // db error

	}

}
