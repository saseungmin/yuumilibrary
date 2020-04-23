package com.yuumilibrary.login.vo;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class UserVO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String userID;
	private String userPass;
	private String userName;
	private String userRole;
	
	/* 사용자가 가입한 클럽의 key 를 저장 : "key1|key2|key6"  */
	private String userRegistClubs;
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserPass() {
		return userPass;
	}

	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	


	public String getUserRegistClubs() {
		return userRegistClubs;
	}

	public void setUserRegistClubs(String userRegistClubs) {
		this.userRegistClubs = userRegistClubs;
	}
	
}
