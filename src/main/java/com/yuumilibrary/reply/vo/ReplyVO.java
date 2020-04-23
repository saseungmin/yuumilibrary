package com.yuumilibrary.reply.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class ReplyVO {
	private int reNum;			/* 댓글들의 고유번호 */
	private int reBoardNum;		/* 댓글이 달린 게시물의 번호 */
	private String reCategory;	/* 댓글이 달린 게시판의 종류(ex. QNA, FREE, CLUB+clubNum) */
	private int reGroupNum;		/* 댓글의 그룹번호(댓글들의 정렬 기준이 되며 자식생성 시에도 사용됨) */
	private int reDepth;		/* 댓글의 깊이 (최초댓글은 depth 설정X, 쿼리에서 자동으로 1부여 ) */
	private int reOrder;		/* 댓글들의 서열, 같은 그룹번호를 공유하는 댓글들끼리의 정렬기준이 됨*/
	private char reDelYn;
	
	/*
	 *	댓글 기능 구현	
	 * 	카테고리에 클럽구분시 CLUB + (클럽의 고유번호로 구분)
	 * 	모든 댓글은 ASC로 오래된 댓글이 최상단으로 - 대화형
	 * 	하나의 댓글과 그 댓글에 대한 대댓글들은 모두 하나의 그룹넘버를 공유함
	 *  대댓글이 하나 추가 될때 부모댓글보다 reOrder(서열)가 높은 댓글들은 + 1 
	 */

	private String reMemId;
	private String reWriter;
	private String reRegDate;
	private String reModDate;
	private String reContent;
	private String reImg;

	
	public String getReImg() {
		return reImg;
	}

	public void setReImg(String reImg) {
		this.reImg = reImg;
	}

	public int getReNum() {
		return reNum;
	}

	public void setReNum(int reNum) {
		this.reNum = reNum;
	}

	public int getReBoardNum() {
		return reBoardNum;
	}

	public void setReBoardNum(int reBoardNum) {
		this.reBoardNum = reBoardNum;
	}

	public int getReGroupNum() {
		return reGroupNum;
	}

	public void setReGroupNum(int reGroupNum) {
		this.reGroupNum = reGroupNum;
	}

	public int getReDepth() {
		return reDepth;
	}

	public void setReDepth(int reDepth) {
		this.reDepth = reDepth;
	}

	public int getReOrder() {
		return reOrder;
	}

	public void setReOrder(int reOrder) {
		this.reOrder = reOrder;
	}

	public String getReCategory() {
		return reCategory;
	}

	public void setReCategory(String reCategory) {
		this.reCategory = reCategory;
	}

	public String getReMemId() {
		return reMemId;
	}

	public void setReMemId(String reMemId) {
		this.reMemId = reMemId;
	}

	public String getReWriter() {
		return reWriter;
	}

	public void setReWriter(String reWriter) {
		this.reWriter = reWriter;
	}

	public String getReRegDate() {
		return reRegDate;
	}

	public void setReRegDate(String reRegDate) {
		this.reRegDate = reRegDate;
	}

	public String getReModDate() {
		return reModDate;
	}

	public void setReModDate(String reModDate) {
		this.reModDate = reModDate;
	}

	public String getReContent() {
		return reContent;
	}

	public void setReContent(String reContent) {
		this.reContent = reContent;
	}


	public char getReDelYn() {
		return reDelYn;
	}

	public void setReDelYn(char reDelYn) {
		this.reDelYn = reDelYn;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
