package com.yuumilibrary.bookdetail.vo;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class BookVO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String bookNo;  			/*책 번호*/
	private String bookRanking; 		/*책 순위*/
	
	private String bookIsbn;
	private String bookName;
	private String bookAuthors;
	private String bookPublisher;
	private String bookPublicationYear;
	private String bookImageUrl;
	private String bookClassNo;
	private String bookCount;
	private String bookLoanCnt;
	private String bookRegDate;


	private String bookDifference;
	private String bookBaseWeekRank;
	private String bookPastWeekRank;
	
	private String loaMemId;
	private String loaIsbn;
	private String loaLoanDate;
	private String loaReturnDate;
	private String loaReturnYN;
	private String loaBookName;
	private String loaBookAuthors;
	


	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}



	public String getLoaBookAuthors() {
		return loaBookAuthors;
	}



	public void setLoaBookAuthors(String loaBookAuthors) {
		this.loaBookAuthors = loaBookAuthors;
	}



	public String getBookNo() {
		return bookNo;
	}



	public void setBookNo(String bookNo) {
		this.bookNo = bookNo;
	}



	public String getBookRanking() {
		return bookRanking;
	}



	public void setBookRanking(String bookRanking) {
		this.bookRanking = bookRanking;
	}



	public String getBookIsbn() {
		return bookIsbn;
	}



	public void setBookIsbn(String bookIsbn) {
		this.bookIsbn = bookIsbn;
	}



	public String getBookName() {
		return bookName;
	}



	public void setBookName(String bookName) {
		this.bookName = bookName;
	}



	public String getBookAuthors() {
		return bookAuthors;
	}



	public void setBookAuthors(String bookAuthors) {
		this.bookAuthors = bookAuthors;
	}



	public String getBookPublisher() {
		return bookPublisher;
	}



	public void setBookPublisher(String bookPublisher) {
		this.bookPublisher = bookPublisher;
	}



	public String getBookPublicationYear() {
		return bookPublicationYear;
	}



	public void setBookPublicationYear(String bookPublicationYear) {
		this.bookPublicationYear = bookPublicationYear;
	}



	public String getBookImageUrl() {
		return bookImageUrl;
	}



	public void setBookImageUrl(String bookImageUrl) {
		this.bookImageUrl = bookImageUrl;
	}



	public String getBookClassNo() {
		return bookClassNo;
	}



	public void setBookClassNo(String bookClassNo) {
		this.bookClassNo = bookClassNo;
	}



	public String getBookCount() {
		return bookCount;
	}



	public void setBookCount(String bookCount) {
		this.bookCount = bookCount;
	}



	public String getBookLoanCnt() {
		return bookLoanCnt;
	}



	public void setBookLoanCnt(String bookLoanCnt) {
		this.bookLoanCnt = bookLoanCnt;
	}



	public String getBookRegDate() {
		return bookRegDate;
	}



	public void setBookRegDate(String bookRegDate) {
		this.bookRegDate = bookRegDate;
	}



	public String getBookDifference() {
		return bookDifference;
	}



	public void setBookDifference(String bookDifference) {
		this.bookDifference = bookDifference;
	}



	public String getBookBaseWeekRank() {
		return bookBaseWeekRank;
	}



	public void setBookBaseWeekRank(String bookBaseWeekRank) {
		this.bookBaseWeekRank = bookBaseWeekRank;
	}



	public String getBookPastWeekRank() {
		return bookPastWeekRank;
	}



	public void setBookPastWeekRank(String bookPastWeekRank) {
		this.bookPastWeekRank = bookPastWeekRank;
	}



	public String getLoaMemId() {
		return loaMemId;
	}



	public void setLoaMemId(String loaMemId) {
		this.loaMemId = loaMemId;
	}



	public String getLoaIsbn() {
		return loaIsbn;
	}



	public void setLoaIsbn(String loaIsbn) {
		this.loaIsbn = loaIsbn;
	}



	public String getLoaLoanDate() {
		return loaLoanDate;
	}



	public void setLoaLoanDate(String loaLoanDate) {
		this.loaLoanDate = loaLoanDate;
	}



	public String getLoaReturnDate() {
		return loaReturnDate;
	}



	public void setLoaReturnDate(String loaReturnDate) {
		this.loaReturnDate = loaReturnDate;
	}



	public String getLoaReturnYN() {
		return loaReturnYN;
	}



	public void setLoaReturnYN(String loaReturnYN) {
		this.loaReturnYN = loaReturnYN;
	}



	public String getLoaBookName() {
		return loaBookName;
	}



	public void setLoaBookName(String loaBookName) {
		this.loaBookName = loaBookName;
	}



	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
