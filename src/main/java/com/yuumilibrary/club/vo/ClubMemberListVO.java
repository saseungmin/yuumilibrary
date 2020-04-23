package com.yuumilibrary.club.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class ClubMemberListVO {
	private int cmNum;
	private String cmClubName;
	private String cmMemId;
	private String cmMemName;
	private String cmMemBir;
	private String cmConfirmYn;
	private int cbBoClubNum;

	
	private String cmMemImg;
	private String cmMemMail;
	private String cmCommNm;
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	
	public int getCmNum() {
		return cmNum;
	}

	public void setCmNum(int cmNum) {
		this.cmNum = cmNum;
	}

	public String getCmClubName() {
		return cmClubName;
	}

	public void setCmClubName(String cmClubName) {
		this.cmClubName = cmClubName;
	}

	public String getCmMemId() {
		return cmMemId;
	}

	public void setCmMemId(String cmMemId) {
		this.cmMemId = cmMemId;
	}

	public String getCmMemName() {
		return cmMemName;
	}

	public void setCmMemName(String cmMemName) {
		this.cmMemName = cmMemName;
	}

	public String getCmMemBir() {
		return cmMemBir;
	}

	public void setCmMemBir(String cmMemBir) {
		this.cmMemBir = cmMemBir;
	}

	public String getCmConfirmYn() {
		return cmConfirmYn;
	}

	public void setCmConfirmYn(String cmConfirmYn) {
		this.cmConfirmYn = cmConfirmYn;
	}

	public int getCbBoClubNum() {
		return cbBoClubNum;
	}

	public void setCbBoClubNum(int cbBoClubNum) {
		this.cbBoClubNum = cbBoClubNum;
	}


	public String getCmMemImg() {
		return cmMemImg;
	}


	public void setCmMemImg(String cmMemImg) {
		this.cmMemImg = cmMemImg;
	}


	public String getCmMemMail() {
		return cmMemMail;
	}


	public void setCmMemMail(String cmMemMail) {
		this.cmMemMail = cmMemMail;
	}


	public String getCmCommNm() {
		return cmCommNm;
	}


	public void setCmCommNm(String cmCommNm) {
		this.cmCommNm = cmCommNm;
	}
	
	
}
