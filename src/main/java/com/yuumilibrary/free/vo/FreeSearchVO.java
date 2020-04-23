package com.yuumilibrary.free.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.yuumilibrary.common.vo.PagingVO;

public class FreeSearchVO extends PagingVO{

private static final long serialVersionUID = 1L;
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	private String searchCategory;			// 분류
	private String searchType;				// 검색구분
	private String searchWord;				// 검색어
	
	
	public String getSearchCategory() {
		return searchCategory;
	}
	public void setSearchCategory(String searchCategory) {
		this.searchCategory = searchCategory;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	
}
