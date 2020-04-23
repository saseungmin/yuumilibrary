package com.yuumilibrary.library.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class LibraryListVO {

	private int libCode; // 도서관 고유코드
	private String libName; // 도서관 이름
	private String libAdd; // 도서관 주소
	private String libTel; // 도서관 전화번호 ( '-' 포함하고있어서 String)
	private double libLatitude; // 도서관 위도
	private double libLongitude;// 경도 (카카오지도 API 활용하기위해서 필요)
	private String libUrl; // 도서관 홈페이지 주소
	private String libTime; // 도서관 운영시

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	public int getLibCode() {
		return libCode;
	}

	public void setLibCode(int libCode) {
		this.libCode = libCode;
	}

	public String getLibName() {
		return libName;
	}

	public void setLibName(String libName) {
		this.libName = libName;
	}

	public String getLibAdd() {
		return libAdd;
	}

	public void setLibAdd(String libAdd) {
		this.libAdd = libAdd;
	}

	public String getLibTel() {
		return libTel;
	}

	public void setLibTel(String libTel) {
		this.libTel = libTel;
	}

	public double getLibLatitude() {
		return libLatitude;
	}

	public void setLibLatitude(double libLatitude) {
		this.libLatitude = libLatitude;
	}

	public double getLibLongitude() {
		return libLongitude;
	}

	public void setLibLongitude(double libLongitude) {
		this.libLongitude = libLongitude;
	}

	public String getLibUrl() {
		return libUrl;
	}

	public void setLibUrl(String libUrl) {
		this.libUrl = libUrl;
	}

	public String getLibTime() {
		return libTime;
	}

	public void setLibTime(String libTime) {
		this.libTime = libTime;
	}

}
