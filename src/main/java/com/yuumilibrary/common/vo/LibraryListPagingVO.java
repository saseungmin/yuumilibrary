package com.yuumilibrary.common.vo;

import java.io.Serializable;

public class LibraryListPagingVO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	int curPage; 						// 현재 페이지 
	int totalRowCount; 					// 전체게시글 수
	int pageSize; 						// 페이지 넘기는 단위의 크기
	int rowSizePerPage; 				// 한 페이지에 보이는 게시물 개수
	int totalPageCount; 				// 전체페이지 수
	int firstRow; 						// 페이징 SQL의 조건절에 사용되는 시작 rownum ex) 11~20번 개시물의 11번=firstRow
	int lastRow; 						// 페이징 SQL의 조건절에 사용되는 마지막 rownum

	int firstPage; // 페이지리스트의 첫번째 페이지 버튼
	int lastPage; // 페이지리스트의 마지막 페이지 버튼

	public void setting() {
		if (curPage < 1) {
			curPage = 1;
		}
		if (rowSizePerPage < 1) {
			rowSizePerPage = 5;
		}
		if (pageSize < 1) {
			pageSize = 5;
		}

		firstRow = ((curPage - 1) * rowSizePerPage) + 1;
		lastRow = firstRow + rowSizePerPage - 1; 					// 또는 curPage * rowSizePerPage
		totalPageCount = (totalRowCount - 1) / rowSizePerPage + 1;

		// firstPage, lastPage 계산
		firstPage = ((curPage - 1) / pageSize) * pageSize + 1;
		lastPage = firstPage + pageSize - 1;
		if (lastPage > totalPageCount) {
			lastPage = totalPageCount;
		}

	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getFirstPage() {
		return firstPage;
	}

	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getRowSizePerPage() {
		return rowSizePerPage;
	}

	public void setRowSizePerPage(int rowSizePerPage) {
		this.rowSizePerPage = rowSizePerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public void setFirstRow(int firstRow) {
		this.firstRow = firstRow;
	}

	public int getLastRow() {
		return lastRow;
	}

	public void setLastRow(int lastRow) {
		this.lastRow = lastRow;
	}

	public int getTotalRowCount() {
		return totalRowCount;
	}

	public void setTotalRowCount(int totalRowCount) {
		this.totalRowCount = totalRowCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

}
