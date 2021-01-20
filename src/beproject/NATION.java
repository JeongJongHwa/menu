package beproject;

public class NATION {
	private String ENG_NAME;
	private String KOREA_NAME;

	public NATION() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getENG_NAME() {
		return ENG_NAME;
	}

	public void setENG_NAME(String eNG_NAME) {
		ENG_NAME = eNG_NAME;
	}

	public String getKOREA_NAME() {
		return KOREA_NAME;
	}

	public void setKOREA_NAME(String kOREA_NAME) {
		KOREA_NAME = kOREA_NAME;
	}

	@Override
	public String toString() {
		return "NATION [ENG_NAME=" + ENG_NAME + ", KOREA_NAME=" + KOREA_NAME + "]";
	}

}
