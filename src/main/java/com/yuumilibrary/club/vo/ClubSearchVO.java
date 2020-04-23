package com.yuumilibrary.club.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.yuumilibrary.common.vo.PagingVO;

public class ClubSearchVO extends PagingVO {

	private static final long serialVersionUID = 1L;

	private String searchClubName;
	private String searchWord;
	private String searchType;
	private int cbBoClubNum;

	public int getCbBoClubNum() {
		return cbBoClubNum;
	}

	public void setCbBoClubNum(int cbBoClubNum) {
		this.cbBoClubNum = cbBoClubNum;
	}

	public String getSearchClubName() {
		return searchClubName;
	}

	public void setSearchClubName(String searchClubName) {
		this.searchClubName = searchClubName;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

}
