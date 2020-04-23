package com.yuumilibrary.bookdetail.vo;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.yuumilibrary.common.vo.PagingVO;

public class BookSearchVO extends PagingVO implements Serializable{

	
	private static final long serialVersionUID = 1L;
	
	private String searchType; //작가
	private String searchWord; //검색어(책 제목)
	private String memId;
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.DEFAULT_STYLE);
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

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

		
}
