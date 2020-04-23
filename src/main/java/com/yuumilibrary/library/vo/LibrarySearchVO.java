package com.yuumilibrary.library.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.yuumilibrary.common.vo.LibraryListPagingVO;

public class LibrarySearchVO extends LibraryListPagingVO{

	private static final long serialVersionUID = 1L;

	private String searchWord;

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
