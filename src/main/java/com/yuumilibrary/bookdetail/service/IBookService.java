
package com.yuumilibrary.bookdetail.service;

import java.util.HashMap;
import java.util.List;

import com.yuumilibrary.bookdetail.vo.BookSearchVO;
import com.yuumilibrary.bookdetail.vo.BookVO;
import com.yuumilibrary.common.exception.BizException;



public interface IBookService {

	public List<BookVO> getBookList(BookSearchVO searchVO) throws BizException;

	public BookVO getBook(HashMap<String, Object> map) throws BizException ;
	
	public List<BookVO> getLoanList(BookSearchVO searchVO) throws BizException;
	
	public List<BookVO> getAllLoanList(BookSearchVO searchVO) throws BizException;
	
	public void loanBook(BookVO book) throws BizException;
	
	public void returnBook(HashMap<String, Object> map) throws BizException;
	
	public List<BookVO> getAllLoanListForExcel(BookSearchVO searchVO) throws BizException;
}
