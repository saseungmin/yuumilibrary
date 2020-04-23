package com.yuumilibrary.attach.service;


import com.yuumilibrary.attach.vo.AttachVO;
import com.yuumilibrary.common.exception.BizException;

public interface IAttachService {

	/** 첨부파일 상세 조회 */
	public AttachVO selectAttach(int atchNo) throws BizException;
	/** 다운로드 횟수 증가 */
	public void increaseDownloadCount(int atchNo) throws BizException;
	
}
