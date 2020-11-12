package com.study.web.vo;

public class Member {
	private String id;
	private String pwd;
	private String cls;
    private String name;
    private String email;
    private String phone;
    
    public String getname() {
        return name;
    }
 
    public void setname(String name) {
        this.name = name;
    }
 
    public String getemail() {
        return email;
    }
 
    public void setemail(String email) {
        this.email = email;
    }
 
    public String getphone() {
        return phone;
    }
 
    public void setphone(String phone) {
        this.phone = phone;
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getCls() {
		return cls;
	}

	public void setCls(String cls) {
		this.cls = cls;
	}
 
}// end of class

