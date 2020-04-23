package com.yuumilibrary.member.vo;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class MemberVO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String memRank;
	private String memId; /*  */
	private String memPass; /*  */
	private String memName; /*  */
	private String memBir; /*  */
	private String memZip; /*  */
	private String memAdd1; /*  */
	private String memAdd2; /*  */
	private String memHp; /*  */
	private String memHpYn;
	private String memMail; /*  */
	private String memMailYn;
	private String memPref; /*  */
	private String memDelYn; /*  */

	private String memPrefNm;
	private String memSalt;
	private String memPrivateKey;
	private String memImg;
	
	

	public String getMemImg() {
		return memImg;
	}

	public void setMemImg(String memImg) {
		this.memImg = memImg;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);

	}

	public String getMemRank() {
		return memRank;
	}

	public void setMemRank(String memRank) {
		this.memRank = memRank;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemPass() {
		return memPass;
	}

	public void setMemPass(String memPass) {
		this.memPass = memPass;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getMemBir() {
		return memBir;
	}

	public void setMemBir(String memBir) {
		this.memBir = memBir;
	}

	public String getMemZip() {
		return memZip;
	}

	public void setMemZip(String memZip) {
		this.memZip = memZip;
	}

	public String getMemAdd1() {
		return memAdd1;
	}

	public void setMemAdd1(String memAdd1) {
		this.memAdd1 = memAdd1;
	}

	public String getMemAdd2() {
		return memAdd2;
	}

	public void setMemAdd2(String memAdd2) {
		this.memAdd2 = memAdd2;
	}

	public String getMemHp() {
		return memHp;
	}

	public void setMemHp(String memHp) {
		this.memHp = memHp;
	}

	public String getMemHpYn() {
		return memHpYn;
	}

	public void setMemHpYn(String memHpYn) {
		this.memHpYn = memHpYn;
	}

	public String getMemMail() {
		return memMail;
	}

	public void setMemMail(String memMail) {
		this.memMail = memMail;
	}

	public String getMemMailYn() {
		return memMailYn;
	}

	public void setMemMailYn(String memMailYn) {
		this.memMailYn = memMailYn;
	}

	public String getMemPref() {
		return memPref;
	}

	public void setMemPref(String memPref) {
		this.memPref = memPref;
	}

	public String getMemDelYn() {
		return memDelYn;
	}

	public void setMemDelYn(String memDelYn) {
		this.memDelYn = memDelYn;
	}

	public String getMemPrefNm() {
		return memPrefNm;
	}

	public void setMemPrefNm(String memPrefNm) {
		this.memPrefNm = memPrefNm;
	}

	public String getMemSalt() {
		return memSalt;
	}

	public void setMemSalt(String memSalt) {
		this.memSalt = memSalt;
	}

	public String getMemPrivateKey() {
		return memPrivateKey;
	}

	public void setMemPrivateKey(String memPrivateKey) {
		this.memPrivateKey = memPrivateKey;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
