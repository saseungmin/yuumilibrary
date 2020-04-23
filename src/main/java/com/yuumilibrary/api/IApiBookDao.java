package com.yuumilibrary.api;

import java.util.List;

import com.yuumilibrary.bookdetail.vo.BookVO;

public interface IApiBookDao {
	
	public List<BookVO> total() throws Exception;
	
	public List<BookVO> novel() throws Exception;
	
	public List<BookVO> history() throws Exception;

	public List<BookVO> art() throws Exception;
	
	public List<BookVO> recommend(String isbn) throws Exception;

}
