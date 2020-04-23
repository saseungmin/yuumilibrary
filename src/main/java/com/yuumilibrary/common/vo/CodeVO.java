package com.yuumilibrary.common.vo;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

@SuppressWarnings("serial")
public class CodeVO implements Serializable{
	private String commCd;            
	private String commNm;            
	private String commParent;        
	private int commOrd;
	
	public String getCommCd() {
		return commCd;
	}
	public void setCommCd(String commCd) {
		this.commCd = commCd;
	}
	public String getCommNm() {
		return commNm;
	}
	public void setCommNm(String commNm) {
		this.commNm = commNm;
	}
	public String getCommParent() {
		return commParent;
	}
	public void setCommParent(String commParent) {
		this.commParent = commParent;
	}
	public int getCommOrd() {
		return commOrd;
	}
	public void setCommOrd(int commOrd) {
		this.commOrd = commOrd;
	}             
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
}
