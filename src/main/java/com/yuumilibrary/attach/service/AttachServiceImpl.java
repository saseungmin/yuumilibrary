package com.yuumilibrary.attach.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuumilibrary.attach.dao.IAttachDao;
import com.yuumilibrary.attach.vo.AttachVO;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;

@Service
public class AttachServiceImpl implements IAttachService {
	@Autowired
	private IAttachDao attachDao;

	@Override
	public AttachVO selectAttach(int atchNo) throws BizException {
		AttachVO vo = attachDao.selectAttach(atchNo);
		if (vo == null) {
			throw new BizNotFoundException("첨부파일 [" + atchNo + "]에 대한 조회 실패");
		}
		return vo;
	}

	@Override
	public void increaseDownloadCount(int atchNo) throws BizException {
		attachDao.increaseDownloadCount(atchNo);
	}
}
