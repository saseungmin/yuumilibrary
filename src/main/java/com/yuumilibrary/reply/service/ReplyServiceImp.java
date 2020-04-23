package com.yuumilibrary.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.reply.dao.IReplyDao;
import com.yuumilibrary.reply.vo.ReplyVO;

@Service
public class ReplyServiceImp implements IReplyService {

	@Autowired
	private IReplyDao replyDao;

	@Override
	public List<ReplyVO> getReplyList(ReplyVO reply) throws BizException {
		try {
			List<ReplyVO> list = replyDao.getReplyList(reply);
			return list;
		} catch (Exception e) {
			throw new BizException(e);
		}
	}
	
	@Override
	public void registReply(ReplyVO reply) throws BizException {
		try {
			if (reply.getReGroupNum() > 0) {
				replyDao.updateOrder(reply);
				replyDao.insertReplyDeeper(reply);
			} else {
				replyDao.insertReply(reply);
			}
		} catch (Exception e) {
			throw new BizException(e);
		}
	}

	@Override
	public void modifyReply(ReplyVO reply) throws BizException {
		try {
			replyDao.modifyReply(reply);
		} catch (Exception e) {
			throw new BizException(e);
		}

	}

	@Override
	public void removeReply(ReplyVO reply) throws BizException {
		try {
			replyDao.deleteReply(reply);
		} catch (Exception e) {
			throw new BizException(e);
		}
	}

	

}