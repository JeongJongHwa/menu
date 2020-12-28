package user;

public class User {

	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	private String id;
	private String password;
	private String name;
	private String memberdate;
	private String gender;

	@Override
	public String toString() {
		return "User [id=" + id + ", password=" + password + ", name=" + name + ", memberdate=" + memberdate
				+ ", gender=" + gender + ", email=" + email + "]";
	}

	private String email;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMemberdate() {
		return memberdate;
	}

	public void setMemberdate(String memberdate) {
		this.memberdate = memberdate;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
