package com.yuumilibrary.free.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.web.multipart.MultipartFile;

import com.yuumilibrary.attach.vo.AttachVO;

public class FreeBoardVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	private int boNum;
	private String boTitle;
	private String boContent;
	private int boHit;
	private String boRegDate;
	private String boModDate;
	private String boDelYn;
	private String boMemId;
	private String boMemPass;
	private String boCategory;
	private String boCategoryNm;
	private String boLike;
	
	private int boNotice;
	private MultipartFile boFiles;
	private List<AttachVO> attaches ; /* 첨부파일 리스트 */
	private int[] delAtchNos; 	/* 삭제할 대상 첨부파일 번호 */


	
	
	public List<AttachVO> getAttaches() {
		return attaches;
	}
	public void setAttaches(List<AttachVO> attaches) {
		this.attaches = attaches;
	}
	public int[] getDelAtchNos() {
		return delAtchNos;
	}
	public void setDelAtchNos(int[] delAtchNos) {
		this.delAtchNos = delAtchNos;
	}
	public MultipartFile getBoFiles() {
		return boFiles;
	}
	public void setBoFiles(MultipartFile boFiles) {
		this.boFiles = boFiles;
	}
	public int getBoNotice() {
		return boNotice;
	}
	public void setBoNotice(int boNotice) {
		this.boNotice = boNotice;
	}
	public int getBoNum() {
		return boNum;
	}
	public void setBoNum(int boNum) {
		this.boNum = boNum;
	}
	public String getBoTitle() {
		return boTitle;
	}
	public void setBoTitle(String boTitle) {
		this.boTitle = boTitle;
	}
	public String getBoContent() {
		return boContent;
	}
	public void setBoContent(String boContent) {
		this.boContent = boContent;
	}
	public int getBoHit() {
		return boHit;
	}
	public void setBoHit(int boHit) {
		this.boHit = boHit;
	}
	public String getBoRegDate() {
		return boRegDate;
	}
	public void setBoRegDate(String boRegDate) {
		this.boRegDate = boRegDate;
	}
	public String getBoModDate() {
		return boModDate;
	}
	public void setBoModDate(String boModDate) {
		this.boModDate = boModDate;
	}
	public String getBoDelYn() {
		return boDelYn;
	}
	public void setBoDelYn(String boDelYn) {
		this.boDelYn = boDelYn;
	}
	public String getBoMemId() {
		return boMemId;
	}
	public void setBoMemId(String boMemId) {
		this.boMemId = boMemId;
	}
	public String getBoCategory() {
		return boCategory;
	}
	public void setBoCategory(String boCategory) {
		this.boCategory = boCategory;
	}
	public String getBoCategoryNm() {
		return boCategoryNm;
	}
	public void setBoCategoryNm(String boCategoryNm) {
		this.boCategoryNm = boCategoryNm;
	}
	public String getBoLike() {
		return boLike;
	}
	public void setBoLike(String boLike) {
		this.boLike = boLike;
	}
	public String getBoMemPass() {
		return boMemPass;
	}
	public void setBoMemPass(String boMemPass) {
		this.boMemPass = boMemPass;
	}

	

}
