package com.yuumilibrary.qna.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class QnaBoardVO {

	private int qbNum;
	private String qbMemId;
	private String qbTitle;
	private String qbWriter;
	private String qbContent;
	private int qbHit;
	private String qbRegDate;
	private String qbModDate;
	private String qbDelYn;
	private String qbPass;

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	
	

	public String getQbPass() {
		return qbPass;
	}

	public void setQbPass(String qbPass) {
		this.qbPass = qbPass;
	}

	public int getQbNum() {
		return qbNum;
	}

	public void setQbNum(int qbNum) {
		this.qbNum = qbNum;
	}

	public String getQbMemId() {
		return qbMemId;
	}

	public void setQbMemId(String qbMemId) {
		this.qbMemId = qbMemId;
	}

	public String getQbTitle() {
		return qbTitle;
	}

	public void setQbTitle(String qbTitle) {
		this.qbTitle = qbTitle;
	}

	public String getQbWriter() {
		return qbWriter;
	}

	public void setQbWriter(String qbWriter) {
		this.qbWriter = qbWriter;
	}

	public String getQbContent() {
		return qbContent;
	}

	public void setQbContent(String qbContent) {
		this.qbContent = qbContent;
	}

	public int getQbHit() {
		return qbHit;
	}

	public void setQbHit(int qbHit) {
		this.qbHit = qbHit;
	}

	public String getQbRegDate() {
		return qbRegDate;
	}

	public void setQbRegDate(String qbRegDate) {
		this.qbRegDate = qbRegDate;
	}

	public String getQbModDate() {
		return qbModDate;
	}

	public void setQbModDate(String qbModDate) {
		this.qbModDate = qbModDate;
	}

	public String getQbDelYn() {
		return qbDelYn;
	}

	public void setQbDelYn(String qbDelYn) {
		this.qbDelYn = qbDelYn;
	}
	
	
}
