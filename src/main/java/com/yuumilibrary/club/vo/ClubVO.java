package com.yuumilibrary.club.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.web.multipart.MultipartFile;

public class ClubVO {
	private int bkNum;
	private String bkLocation;
	private String bkAge;
	private int bkLimit;
	private int bkMemCnt;
	private String bkTime;
	private String bkMemId;
	private String bkTheme;
	private String bkImageurl;
	private String bkClubName;
	
	
	public int getBkNum() {
		return bkNum;
	}
	public void setBkNum(int bkNum) {
		this.bkNum = bkNum;
	}
	public String getBkLocation() {
		return bkLocation;
	}
	public void setBkLocation(String bkLocation) {
		this.bkLocation = bkLocation;
	}
	public String getBkAge() {
		return bkAge;
	}
	public void setBkAge(String bkAge) {
		this.bkAge = bkAge;
	}
	public int getBkLimit() {
		return bkLimit;
	}
	public void setBkLimit(int bkLimit) {
		this.bkLimit = bkLimit;
	}
	public String getBkTime() {
		return bkTime;
	}
	public void setBkTime(String bkTime) {
		this.bkTime = bkTime;
	}
	public String getBkMemId() {
		return bkMemId;
	}
	public void setBkMemId(String bkMemId) {
		this.bkMemId = bkMemId;
	}
	public String getBkTheme() {
		return bkTheme;
	}
	public void setBkTheme(String bkTheme) {
		this.bkTheme = bkTheme;
	}
	public String getBkImageurl() {
		return bkImageurl;
	}
	public void setBkImageurl(String bkImageurl) {
		this.bkImageurl = bkImageurl;
	}
	public String getBkClubName() {
		return bkClubName;
	}
	public void setBkClubName(String bkClubName) {
		this.bkClubName = bkClubName;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public int getBkMemCnt() {
		return bkMemCnt;
	}
	public void setBkMemCnt(int bkMemCnt) {
		this.bkMemCnt = bkMemCnt;
	}
	
	
}
