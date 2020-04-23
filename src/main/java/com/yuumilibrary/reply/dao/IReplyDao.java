package com.yuumilibrary.reply.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.yuumilibrary.reply.vo.ReplyVO;

@Mapper
public interface IReplyDao {

	public List<ReplyVO> getReplyList(ReplyVO reply);
	
	public ReplyVO getReply(ReplyVO reply);

	public int insertReply(ReplyVO reply);
	
	public int insertReplyDeeper(ReplyVO reply);
	
	public int updateOrder(ReplyVO reply); 

	public int modifyReply(ReplyVO reply);

	public int deleteReply(ReplyVO reply);
	
}
