package com.yuumilibrary.club.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.web.multipart.MultipartFile;

import com.yuumilibrary.attach.vo.AttachVO;

@SuppressWarnings("serial")
public class ClubBoardVO implements Serializable{
	
	private int cbBoNum;
	private int cbBoClubNum;
	private String cbBoMemId;
	private String cbBoWriter;
	private String cbBoTitle;
	private String cbBoRegDate;
	private String cbBoModDate;
	private String cbBoContent;
	private int cbBoHit;
	private int cbBoNotice;

	private MultipartFile cbBoFiles;
	private List<AttachVO> attaches; /* 첨부파일 리스트 */
	private int[] delAtchNos; /* 삭제할 대상 첨부파일 번호 */

	public MultipartFile getCbBoFiles() {
		return cbBoFiles;
	}

	public void setCbBoFiles(MultipartFile cbBoFiles) {
		this.cbBoFiles = cbBoFiles;
	}

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

	public int getCbBoHit() {
		return cbBoHit;
	}

	public void setCbBoHit(int cbBoHit) {
		this.cbBoHit = cbBoHit;
	}

	public int getCbBoClubNum() {
		return cbBoClubNum;
	}

	public void setCbBoClubNum(int cbBoClubNum) {
		this.cbBoClubNum = cbBoClubNum;
	}

	public String getCbBoMemId() {
		return cbBoMemId;
	}

	public void setCbBoMemId(String cbBomemId) {
		this.cbBoMemId = cbBomemId;
	}

	public String getCbBoWriter() {
		return cbBoWriter;
	}

	public void setCbBoWriter(String cbBoWriter) {
		this.cbBoWriter = cbBoWriter;
	}

	public String getCbBoTitle() {
		return cbBoTitle;
	}

	public void setCbBoTitle(String cbBoTitle) {
		this.cbBoTitle = cbBoTitle;
	}

	public String getCbBoRegDate() {
		return cbBoRegDate;
	}

	public void setCbBoRegDate(String cbBoRegDate) {
		this.cbBoRegDate = cbBoRegDate;
	}

	public String getCbBoModDate() {
		return cbBoModDate;
	}

	public void setCbBoModDate(String cbBoModDate) {
		this.cbBoModDate = cbBoModDate;
	}

	public String getCbBoContent() {
		return cbBoContent;
	}

	public void setCbBoContent(String cbBoContent) {
		this.cbBoContent = cbBoContent;
	}

	public int getCbBoNum() {
		return cbBoNum;
	}

	public void setCbBoNum(int cbBoNum) {
		this.cbBoNum = cbBoNum;
	}


	public int getCbBoNotice() {
		return cbBoNotice;
	}

	public void setCbBoNotice(int cbBoNotice) {
		this.cbBoNotice = cbBoNotice;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

}
