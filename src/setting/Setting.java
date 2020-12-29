package setting;

public class Setting {

	private static String dbURL = "jdbc:mysql://localhost:3306/menu";
	private static String dbID = "root";
	private static String dbPassword = "root";

	public static String getDbURL() {
		return dbURL;
	}

	public static void setDbURL(String dbURL) {
		Setting.dbURL = dbURL;
	}

	public static String getDbID() {
		return dbID;
	}

	public static void setDbID(String dbID) {
		Setting.dbID = dbID;
	}

	public static String getDbPassword() {
		return dbPassword;
	}

	public static void setDbPassword(String dbPassword) {
		Setting.dbPassword = dbPassword;
	}

}
