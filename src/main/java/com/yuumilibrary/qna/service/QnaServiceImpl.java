package com.yuumilibrary.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuumilibrary.common.exception.BizAccessFailException;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;
import com.yuumilibrary.qna.dao.IQnaBoardDao;
import com.yuumilibrary.qna.vo.QnaBoardVO;
import com.yuumilibrary.qna.vo.QnaSearchVO;

@Service
public class QnaServiceImpl implements IQnaService {

@Autowired
private IQnaBoardDao qnaDao;

@Override
public List<QnaBoardVO> getQnaBoardList(QnaSearchVO searchVO) throws BizException {
    try {
        int rowCount = qnaDao.getQnaBoardCount(searchVO);
        searchVO.setTotalRowCount(rowCount);
        searchVO.setting();
        return qnaDao.getQnaBoardList(searchVO);
    } catch (Exception e) {
        throw new BizException(e);
    }
}

@Override
public void increaseHitCount(int qbNum) throws BizException {
    try {
        qnaDao.increaseHitCount(qbNum);
    } catch (Exception e) {
        throw new BizException(e);
    }
}

@Override
public QnaBoardVO getQnaBoardView(int qbNum) throws BizException {
    QnaBoardVO qna;
    try {
        qna = qnaDao.getQnaBoardView(qbNum);
        if (qna == null) {
            throw new BizNotFoundException("글번호 : " + qbNum + "번을 조회하지 못했습니다.");
        }
        return qna;
    } catch (Exception e) {
        throw new BizException(e);
    }
}

@Override
public void registQnaBoard(QnaBoardVO board) throws BizException {
    try {
        int res = qnaDao.registQnaBoard(board);
        if (res < 1) {
            throw new BizAccessFailException();
        }
    } catch (Exception e) {
        throw new BizException(e);
    }
}

@Override
public void deleteQnaBoard(QnaBoardVO board) throws BizException {
    try {
        int res = qnaDao.deleteQnaBoard(board);
        if (res < 1) {
            throw new BizNotFoundException();
        }
    } catch (Exception e) {
        throw new BizException(e);
    }
}

@Override
public void modifyQnaBoard(QnaBoardVO board) throws BizException {
    try {
        int res = qnaDao.modifyQnaBoard(board);
        if (res < 1) {
            throw new BizAccessFailException();
        }
    } catch (Exception e) {
        throw new BizException(e);
    }
}
}