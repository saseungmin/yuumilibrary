package com.yuumilibrary.qna.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.qna.vo.QnaBoardVO;
import com.yuumilibrary.qna.vo.QnaSearchVO;

@Mapper
public interface IQnaBoardDao {
	
	public int getQnaBoardCount(QnaSearchVO searchVO) throws BizException;

	public int increaseHitCount(int qbNum) throws BizException;

	public List<QnaBoardVO> getQnaBoardList(QnaSearchVO searchVO) throws BizException;

	public QnaBoardVO getQnaBoardView(int qbNum) throws BizException;

	public int registQnaBoard(QnaBoardVO board) throws BizException;

	public int deleteQnaBoard(QnaBoardVO board) throws BizException;

	public int modifyQnaBoard(QnaBoardVO board) throws BizException;
}
