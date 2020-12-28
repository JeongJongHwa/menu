package menu;

import java.util.Date;

public class Menu {
	@Override
	public String toString() {
		return "Menu [menuNumber=" + menuNumber + ", menuTitle=" + menuTitle + ", menuContent=" + menuContent
				+ ", menuDate=" + menuDate + ", id=" + id + ", menuImageNumber=" + menuImageNumber + ", menuAvailable="
				+ menuAvailable + ", readCnt=" + readCnt + ", sumAppraisal=" + sumAppraisal + "]";
	}

	private int menuNumber;
	private String menuTitle;
	private String menuContent;
	private Date menuDate;
	private String id;
	private int menuImageNumber;
	private int menuAvailable;
	private int readCnt;
	private int sumAppraisal;

	public Menu() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getMenuNumber() {
		return menuNumber;
	}

	public void setMenuNumber(int menuNumber) {
		this.menuNumber = menuNumber;
	}

	public String getMenuTitle() {
		return menuTitle;
	}

	public void setMenuTitle(String menuTitle) {
		this.menuTitle = menuTitle;
	}

	public String getMenuContent() {
		return menuContent;
	}

	public void setMenuContent(String menuContent) {
		this.menuContent = menuContent;
	}

	public Date getMenuDate() {
		return menuDate;
	}

	public void setMenuDate(Date menuDate) {
		this.menuDate = menuDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getMenuImageNumber() {
		return menuImageNumber;
	}

	public void setMenuImageNumber(int menuImageNumber) {
		this.menuImageNumber = menuImageNumber;
	}

	public int getMenuAvailable() {
		return menuAvailable;
	}

	public void setMenuAvailable(int menuAvailable) {
		this.menuAvailable = menuAvailable;
	}

	public int getReadCnt() {
		return readCnt;
	}

	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}

	public int getSumAppraisal() {
		return sumAppraisal;
	}

	public void setSumAppraisal(int sumAppraisal) {
		this.sumAppraisal = sumAppraisal;
	}

}
