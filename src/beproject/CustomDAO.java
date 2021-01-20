package beproject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import setting.Setting;

public class CustomDAO {

	private Connection conn;
	private ResultSet rs;

	public CustomDAO() {

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(Setting.getDbURL(), Setting.getDbID(), Setting.getDbPassword());

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public ArrayList<CUSTOM> getList(String BUSI_NUM, String CUSTOM) {

		String SQL = "SELECT BUSI_NUM,CUSTOM FROM CUSTOM WHERE BUSI_NUM LIKE ? OR CUSTOM LIKE ? ";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, BUSI_NUM + "%");
			pstmt.setString(2, CUSTOM + "%");
			rs = pstmt.executeQuery();

			ArrayList<CUSTOM> list = new ArrayList<CUSTOM>();

			while (rs.next()) {
				CUSTOM custom = new CUSTOM();
				custom.setBUSI_NUM(rs.getString(1));
				custom.setCUSTOM(rs.getString(2));
				list.add(custom);

			}
			return list;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;

	}

	public CUSTOM getCUSTOM(String BUSI_NUM) {

		String SQL = "SELECT C.BUSI_NUM,C.CUSTOM,C.SHORT,C.CEO,C.CHARGE_PERSON,C.BUSI_CONDITION,C.ITEM,C.POST_NUM,"
				+ "C.ADDR1,C.ADDR2,C.TEL,C.FAX,C.HOMEPAGE,	C.CO_YN,C.FOREIGN_YN,C.TAX_YN,C.COUNTRY_ENG,"
				+ "C.COUNTRY_KOR,C.SPECIAL_RELATION,C.TRADE_STOP,  C.CONTRACT_PERIOD_S, C.CONTRACT_PERIOD_E, C.REGI_INFO_MAN,"
				+ "C.REGI_INFO_DATE, C.MODI_INFO_MAN, C.MODI_INFO_DATE "
				+ "FROM CUSTOM C LEFT JOIN ACCOUNT A ON C.BUSI_NUM=A.BUSI_NUM WHERE C.BUSI_NUM=?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, BUSI_NUM);
			rs = pstmt.executeQuery();

			CUSTOM custom = new CUSTOM();

			if (rs.next()) {
				custom.setBUSI_NUM(rs.getString(1));
				custom.setCUSTOM(rs.getString(2));
				custom.setSHORT(rs.getString(3));
				custom.setCEO(rs.getString(4));
				custom.setCHARGE_PERSON(rs.getString(5));
				custom.setBUSI_CONDITION(rs.getString(6));
				custom.setITEM(rs.getString(7));
				custom.setPOST_NUM(rs.getString(8));
				custom.setADDR1(rs.getString(9));
				custom.setADDR2(rs.getString(10));
				custom.setTEL(rs.getString(11));
				custom.setFAX(rs.getString(12));
				custom.setHOMEPAGE(rs.getString(13));
				custom.setCO_YN(rs.getBoolean(14));
				custom.setFOREIGN_YN(rs.getBoolean(15));
				custom.setTAX_YN(rs.getBoolean(16));
				custom.setCOUNTRY_ENG(rs.getString(17));
				custom.setCOUNTRY_KOR(rs.getString(18));
				custom.setSPECIAL_RELATION(rs.getBoolean(19));
				custom.setTRADE_STOP(rs.getBoolean(20));
				custom.setCONTRACT_PERIOD_S(rs.getString(21));
				custom.setCONTRACT_PERIOD_E(rs.getString(22));
				custom.setREGI_INFO_MAN(rs.getString(23));
				custom.setREGI_INFO_DATE(rs.getString(24));
				custom.setMODI_INFO_MAN(rs.getString(25));
				custom.setMODI_INFO_DATE(rs.getString(26));
			}

			return custom;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;

	}

	public void write(CUSTOM custom) throws Exception {

		String SQL = "INSERT INTO CUSTOM VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, custom.getBUSI_NUM());
			pstmt.setString(2, custom.getCUSTOM());
			pstmt.setString(3, custom.getSHORT());
			pstmt.setString(4, custom.getCEO());
			pstmt.setString(5, custom.getCHARGE_PERSON());
			pstmt.setString(6, custom.getBUSI_CONDITION());
			pstmt.setString(7, custom.getITEM());
			pstmt.setString(8, custom.getPOST_NUM());
			pstmt.setString(9, custom.getADDR1());
			pstmt.setString(10, custom.getADDR2());
			pstmt.setString(11, custom.getTEL());
			pstmt.setString(12, custom.getFAX());
			pstmt.setString(13, custom.getHOMEPAGE());
			pstmt.setBoolean(14, custom.isCO_YN());
			pstmt.setBoolean(15, custom.isFOREIGN_YN());
			pstmt.setBoolean(16, custom.isTAX_YN());
			pstmt.setString(17, custom.getCOUNTRY_ENG());
			pstmt.setString(18, custom.getCOUNTRY_KOR());
			pstmt.setBoolean(19, custom.isSPECIAL_RELATION());
			pstmt.setBoolean(20, custom.isTRADE_STOP());
			pstmt.setString(21, custom.getCONTRACT_PERIOD_S());
			pstmt.setString(22, custom.getCONTRACT_PERIOD_E());
			pstmt.setString(23, custom.getREGI_INFO_MAN());
			pstmt.setString(24, getDate());
			pstmt.setString(25, custom.getMODI_INFO_MAN());
			pstmt.setString(26, custom.getMODI_INFO_DATE());

			pstmt.executeUpdate();

		} catch (Exception e) {
			throw new Exception("error");
		}

	}

	public int write(CUSTOM custom, ACCOUNT account) throws SQLException {

		try {

			conn.setAutoCommit(false);

			String customSQL = "INSERT INTO CUSTOM VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

			PreparedStatement pstmt = conn.prepareStatement(customSQL);

			pstmt.setString(1, custom.getBUSI_NUM());
			pstmt.setString(2, custom.getCUSTOM());
			pstmt.setString(3, custom.getSHORT());
			pstmt.setString(4, custom.getCEO());
			pstmt.setString(5, custom.getCHARGE_PERSON());
			pstmt.setString(6, custom.getBUSI_CONDITION());
			pstmt.setString(7, custom.getITEM());
			pstmt.setString(8, custom.getPOST_NUM());
			pstmt.setString(9, custom.getADDR1());
			pstmt.setString(10, custom.getADDR2());
			pstmt.setString(11, custom.getTEL());
			pstmt.setString(12, custom.getFAX());
			pstmt.setString(13, custom.getHOMEPAGE());
			pstmt.setBoolean(14, custom.isCO_YN());
			pstmt.setBoolean(15, custom.isFOREIGN_YN());
			pstmt.setBoolean(16, custom.isTAX_YN());
			pstmt.setString(17, custom.getCOUNTRY_ENG());
			pstmt.setString(18, custom.getCOUNTRY_KOR());
			pstmt.setBoolean(19, custom.isSPECIAL_RELATION());
			pstmt.setBoolean(20, custom.isTRADE_STOP());
			pstmt.setString(21, custom.getCONTRACT_PERIOD_S());
			pstmt.setString(22, custom.getCONTRACT_PERIOD_E());
			pstmt.setString(23, custom.getREGI_INFO_MAN());
			pstmt.setString(24, getDate());
			pstmt.setString(25, custom.getMODI_INFO_MAN());
			pstmt.setString(26, custom.getMODI_INFO_DATE());

			if (pstmt.executeUpdate() != 1) {
				throw new Exception("error");
			}

			String accountSQL = "INSERT INTO ACCOUNT VALUES(?,?,?,?)";

			PreparedStatement pstmtAccount = conn.prepareStatement(accountSQL);

			pstmtAccount.setString(1, account.getBUSI_NUM());
			pstmtAccount.setString(2, account.getFACTORY());
			pstmtAccount.setString(3, account.getTRADE_BANK());
			pstmtAccount.setString(4, account.getACCOUNT_NUM());

			if (pstmtAccount.executeUpdate() != 1) {
				throw new Exception("error");
			}

			conn.commit();
			
			return 1;

		} catch (Exception e) {
			conn.rollback();
			return 0;
		}

	}
	
	public int updateWrite(CUSTOM custom, ACCOUNT account) throws SQLException {

		try {

			conn.setAutoCommit(false);

			String customSQL = "UPDATE CUSTOM SET SHORT=?,CEO=?,CHARGE_PERSON=?"
					+ ",BUSI_CONDITION=?,ITEM=?,POST_NUM=?,ADDR1=?,ADDR2=?,TEL=?,FAX=?"
					+ ",HOMEPAGE=?,CO_YN=?,FOREIGN_YN=?,TAX_YN=?,COUNTRY_ENG=?,	COUNTRY_KOR=?"
					+ ",SPECIAL_RELATION=?,TRADE_STOP=?,CONTRACT_PERIOD_S=?,CONTRACT_PERIOD_E=?"
					+ ",REGI_INFO_MAN=?,REGI_INFO_DATE=?,MODI_INFO_MAN=?,MODI_INFO_DATE=? WHERE BUSI_NUM=? AND CUSTOM=?";

			PreparedStatement custompstmt = conn.prepareStatement(customSQL);

			custompstmt.setString(1, custom.getSHORT());
			custompstmt.setString(2, custom.getCEO());
			custompstmt.setString(3, custom.getCHARGE_PERSON());
			custompstmt.setString(4, custom.getBUSI_CONDITION());
			custompstmt.setString(5, custom.getITEM());
			custompstmt.setString(6, custom.getPOST_NUM());
			custompstmt.setString(7, custom.getADDR1());
			custompstmt.setString(8, custom.getADDR2());
			custompstmt.setString(9, custom.getTEL());
			custompstmt.setString(10, custom.getFAX());
			custompstmt.setString(11, custom.getHOMEPAGE());
			custompstmt.setBoolean(12, custom.isCO_YN());
			custompstmt.setBoolean(13, custom.isFOREIGN_YN());
			custompstmt.setBoolean(14, custom.isTAX_YN());
			custompstmt.setString(15, custom.getCOUNTRY_ENG());
			custompstmt.setString(16, custom.getCOUNTRY_KOR());
			custompstmt.setBoolean(17, custom.isSPECIAL_RELATION());
			custompstmt.setBoolean(18, custom.isTRADE_STOP());
			custompstmt.setString(19, custom.getCONTRACT_PERIOD_S());
			custompstmt.setString(20, custom.getCONTRACT_PERIOD_E());
			custompstmt.setString(21, custom.getREGI_INFO_MAN());
			custompstmt.setString(22, custom.getREGI_INFO_DATE());
			custompstmt.setString(23, custom.getMODI_INFO_MAN());
			custompstmt.setString(24, getDate());
			custompstmt.setString(25, custom.getBUSI_NUM());
			custompstmt.setString(26, custom.getCUSTOM());

			if (custompstmt.executeUpdate() != 1) {
				throw new Exception();
			}

			String accountSQL = "INSERT INTO ACCOUNT VALUES(?,?,?,?)";

			PreparedStatement pstmtAccount = conn.prepareStatement(accountSQL);

			pstmtAccount.setString(1, account.getBUSI_NUM());
			pstmtAccount.setString(2, account.getFACTORY());
			pstmtAccount.setString(3, account.getTRADE_BANK());
			pstmtAccount.setString(4, account.getACCOUNT_NUM());

			if (pstmtAccount.executeUpdate() != 1) {
				throw new Exception("error");
			}
			conn.commit();
			
			return 1;
		} catch (Exception e) {
			conn.rollback();
			return 0;
		}

	}
	
	
	public int updateDelete(CUSTOM custom, ACCOUNT account) throws SQLException {

		try {

			conn.setAutoCommit(false);

			String customSQL = "UPDATE CUSTOM SET SHORT=?,CEO=?,CHARGE_PERSON=?"
					+ ",BUSI_CONDITION=?,ITEM=?,POST_NUM=?,ADDR1=?,ADDR2=?,TEL=?,FAX=?"
					+ ",HOMEPAGE=?,CO_YN=?,FOREIGN_YN=?,TAX_YN=?,COUNTRY_ENG=?,	COUNTRY_KOR=?"
					+ ",SPECIAL_RELATION=?,TRADE_STOP=?,CONTRACT_PERIOD_S=?,CONTRACT_PERIOD_E=?"
					+ ",REGI_INFO_MAN=?,REGI_INFO_DATE=?,MODI_INFO_MAN=?,MODI_INFO_DATE=? WHERE BUSI_NUM=? AND CUSTOM=?";

			PreparedStatement custompstmt = conn.prepareStatement(customSQL);

			custompstmt.setString(1, custom.getSHORT());
			custompstmt.setString(2, custom.getCEO());
			custompstmt.setString(3, custom.getCHARGE_PERSON());
			custompstmt.setString(4, custom.getBUSI_CONDITION());
			custompstmt.setString(5, custom.getITEM());
			custompstmt.setString(6, custom.getPOST_NUM());
			custompstmt.setString(7, custom.getADDR1());
			custompstmt.setString(8, custom.getADDR2());
			custompstmt.setString(9, custom.getTEL());
			custompstmt.setString(10, custom.getFAX());
			custompstmt.setString(11, custom.getHOMEPAGE());
			custompstmt.setBoolean(12, custom.isCO_YN());
			custompstmt.setBoolean(13, custom.isFOREIGN_YN());
			custompstmt.setBoolean(14, custom.isTAX_YN());
			custompstmt.setString(15, custom.getCOUNTRY_ENG());
			custompstmt.setString(16, custom.getCOUNTRY_KOR());
			custompstmt.setBoolean(17, custom.isSPECIAL_RELATION());
			custompstmt.setBoolean(18, custom.isTRADE_STOP());
			custompstmt.setString(19, custom.getCONTRACT_PERIOD_S());
			custompstmt.setString(20, custom.getCONTRACT_PERIOD_E());
			custompstmt.setString(21, custom.getREGI_INFO_MAN());
			custompstmt.setString(22, custom.getREGI_INFO_DATE());
			custompstmt.setString(23, custom.getMODI_INFO_MAN());
			custompstmt.setString(24, getDate());
			custompstmt.setString(25, custom.getBUSI_NUM());
			custompstmt.setString(26, custom.getCUSTOM());

			if (custompstmt.executeUpdate() != 1) {
				throw new Exception();
			}

			String accountSelectSQL = "SELECT BUSI_NUM FROM ACCOUNT WHERE BUSI_NUM=?";
			
			PreparedStatement pstmtSelectAccount = conn.prepareStatement(accountSelectSQL);
			
			pstmtSelectAccount.setString(1, account.getBUSI_NUM());
			
			rs = pstmtSelectAccount.executeQuery();
			
			// account table에 data 가 존재한다면 제거
			if( rs.next() ) {
				String accountSQL = "DELETE FROM ACCOUNT WHERE BUSI_NUM=?";

				PreparedStatement pstmtAccount = conn.prepareStatement(accountSQL);

				pstmtAccount.setString(1, account.getBUSI_NUM());
				
				if (pstmtAccount.executeUpdate() != 1) {
					throw new Exception("error");
				}
			} 
			conn.commit();
			return 1;
		} catch (Exception e) {
			conn.rollback();
			return 0;
		}

	}

	public void update(CUSTOM custom) throws Exception{

		String SQL = "UPDATE CUSTOM SET SHORT=?,CEO=?,CHARGE_PERSON=?"
				+ ",BUSI_CONDITION=?,ITEM=?,POST_NUM=?,ADDR1=?,ADDR2=?,TEL=?,FAX=?"
				+ ",HOMEPAGE=?,CO_YN=?,FOREIGN_YN=?,TAX_YN=?,COUNTRY_ENG=?,	COUNTRY_KOR=?"
				+ ",SPECIAL_RELATION=?,TRADE_STOP=?,CONTRACT_PERIOD_S=?,CONTRACT_PERIOD_E=?"
				+ ",REGI_INFO_MAN=?,REGI_INFO_DATE=?,MODI_INFO_MAN=?,MODI_INFO_DATE=? WHERE BUSI_NUM=? AND CUSTOM=?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, custom.getSHORT());
			pstmt.setString(2, custom.getCEO());
			pstmt.setString(3, custom.getCHARGE_PERSON());
			pstmt.setString(4, custom.getBUSI_CONDITION());
			pstmt.setString(5, custom.getITEM());
			pstmt.setString(6, custom.getPOST_NUM());
			pstmt.setString(7, custom.getADDR1());
			pstmt.setString(8, custom.getADDR2());
			pstmt.setString(9, custom.getTEL());
			pstmt.setString(10, custom.getFAX());
			pstmt.setString(11, custom.getHOMEPAGE());
			pstmt.setBoolean(12, custom.isCO_YN());
			pstmt.setBoolean(13, custom.isFOREIGN_YN());
			pstmt.setBoolean(14, custom.isTAX_YN());
			pstmt.setString(15, custom.getCOUNTRY_ENG());
			pstmt.setString(16, custom.getCOUNTRY_KOR());
			pstmt.setBoolean(17, custom.isSPECIAL_RELATION());
			pstmt.setBoolean(18, custom.isTRADE_STOP());
			pstmt.setString(19, custom.getCONTRACT_PERIOD_S());
			pstmt.setString(20, custom.getCONTRACT_PERIOD_E());
			pstmt.setString(21, custom.getREGI_INFO_MAN());
			pstmt.setString(22, custom.getREGI_INFO_DATE());
			pstmt.setString(23, custom.getMODI_INFO_MAN());
			pstmt.setString(24, getDate());
			pstmt.setString(25, custom.getBUSI_NUM());
			pstmt.setString(26, custom.getCUSTOM());

			pstmt.executeUpdate();

		} catch (Exception e) {
			throw new Exception("error");
		}

	}

	public int update(CUSTOM custom, ACCOUNT account) throws SQLException {

		try {

			conn.setAutoCommit(false);

			String customSQL = "UPDATE CUSTOM SET SHORT=?,CEO=?,CHARGE_PERSON=?"
					+ ",BUSI_CONDITION=?,ITEM=?,POST_NUM=?,ADDR1=?,ADDR2=?,TEL=?,FAX=?"
					+ ",HOMEPAGE=?,CO_YN=?,FOREIGN_YN=?,TAX_YN=?,COUNTRY_ENG=?,	COUNTRY_KOR=?"
					+ ",SPECIAL_RELATION=?,TRADE_STOP=?,CONTRACT_PERIOD_S=?,CONTRACT_PERIOD_E=?"
					+ ",REGI_INFO_MAN=?,REGI_INFO_DATE=?,MODI_INFO_MAN=?,MODI_INFO_DATE=? WHERE BUSI_NUM=? AND CUSTOM=?";

			PreparedStatement custompstmt = conn.prepareStatement(customSQL);

			custompstmt.setString(1, custom.getSHORT());
			custompstmt.setString(2, custom.getCEO());
			custompstmt.setString(3, custom.getCHARGE_PERSON());
			custompstmt.setString(4, custom.getBUSI_CONDITION());
			custompstmt.setString(5, custom.getITEM());
			custompstmt.setString(6, custom.getPOST_NUM());
			custompstmt.setString(7, custom.getADDR1());
			custompstmt.setString(8, custom.getADDR2());
			custompstmt.setString(9, custom.getTEL());
			custompstmt.setString(10, custom.getFAX());
			custompstmt.setString(11, custom.getHOMEPAGE());
			custompstmt.setBoolean(12, custom.isCO_YN());
			custompstmt.setBoolean(13, custom.isFOREIGN_YN());
			custompstmt.setBoolean(14, custom.isTAX_YN());
			custompstmt.setString(15, custom.getCOUNTRY_ENG());
			custompstmt.setString(16, custom.getCOUNTRY_KOR());
			custompstmt.setBoolean(17, custom.isSPECIAL_RELATION());
			custompstmt.setBoolean(18, custom.isTRADE_STOP());
			custompstmt.setString(19, custom.getCONTRACT_PERIOD_S());
			custompstmt.setString(20, custom.getCONTRACT_PERIOD_E());
			custompstmt.setString(21, custom.getREGI_INFO_MAN());
			custompstmt.setString(22, custom.getREGI_INFO_DATE());
			custompstmt.setString(23, custom.getMODI_INFO_MAN());
			custompstmt.setString(24, getDate());
			custompstmt.setString(25, custom.getBUSI_NUM());
			custompstmt.setString(26, custom.getCUSTOM());

			if (custompstmt.executeUpdate() != 1) {
				throw new Exception();
			}

			String accountSQL = "UPDATE ACCOUNT SET FACTORY =?,TRADE_BANK=?,ACCOUNT_NUM=? WHERE BUSI_NUM=?";
			PreparedStatement accountpstmt = conn.prepareStatement(accountSQL);

			accountpstmt.setString(1, account.getFACTORY());
			accountpstmt.setString(2, account.getTRADE_BANK());
			accountpstmt.setString(3, account.getACCOUNT_NUM());
			accountpstmt.setString(4, account.getBUSI_NUM());

			if (accountpstmt.executeUpdate() != 1) {
				throw new Exception();
			}

			conn.commit();
			
			return 1;
		} catch (Exception e) {

			conn.rollback();
			return 0;

		}

	}

	public String getDate() {
		String SQL = "SELECT NOW()";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return ""; // db error

	}

	public int checkCustom(String BUSI_NUM, String CUSTOM) {

		String SQL = "SELECT BUSI_NUM FROM CUSTOM WHERE BUSI_NUM=? OR CUSTOM=?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, BUSI_NUM);
			pstmt.setString(2, CUSTOM);
			rs = pstmt.executeQuery();

			// 이미 작성된건이 있다면 1
			if (rs.next()) {

				return 1;

			}
			// 이미 작성된게 없다면 0
			return 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1; // db error

	}

	public int delete(String BUSI_NUM, String CUSTOM) throws Exception {

		try {
			
			conn.setAutoCommit(false);
			
			String SQL = "DELETE FROM CUSTOM WHERE BUSI_NUM=? AND CUSTOM=?";

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, BUSI_NUM);
			pstmt.setString(2, CUSTOM);

			if ( pstmt.executeUpdate() != 1 ) {
				throw new Exception();
			}
			
			String accountSelectSQL = "SELECT BUSI_NUM FROM ACCOUNT WHERE BUSI_NUM=?";
			
			PreparedStatement pstmtSelectAccount = conn.prepareStatement(accountSelectSQL);
			
			pstmtSelectAccount.setString(1, BUSI_NUM);
			
			rs = pstmtSelectAccount.executeQuery();
			
			// account table에 data 가 존재한다면 제거
			if( rs.next() ) {
				String accountSQL = "DELETE FROM ACCOUNT WHERE BUSI_NUM=?";

				PreparedStatement pstmtAccount = conn.prepareStatement(accountSQL);

				pstmtAccount.setString(1, BUSI_NUM);
				
				if (pstmtAccount.executeUpdate() != 1) {
					throw new Exception("error");
				}
			} 
			
			
			conn.commit();
			return 1;

		} catch (Exception e) {
			conn.rollback();
			return 0;
		}

	}

}
