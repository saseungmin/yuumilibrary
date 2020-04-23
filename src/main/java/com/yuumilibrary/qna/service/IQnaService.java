package com.yuumilibrary.qna.service;

import java.util.List;

import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.qna.vo.QnaBoardVO;
import com.yuumilibrary.qna.vo.QnaSearchVO;

public interface IQnaService {

	public void increaseHitCount(int qbNum) throws BizException;

	public List<QnaBoardVO> getQnaBoardList(QnaSearchVO searchVO) throws BizException;

	public QnaBoardVO getQnaBoardView(int qbNum) throws BizException;

	public void deleteQnaBoard(QnaBoardVO board) throws BizException;

	public void modifyQnaBoard(QnaBoardVO board) throws BizException;

	public void registQnaBoard(QnaBoardVO board) throws BizException;

}
