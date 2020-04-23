package com.yuumilibrary.reply.service;

import java.util.List;

import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.reply.vo.ReplyVO;


public interface IReplyService {

	/**
	 * <pre>
	 * 댓글 목록 조회 
	 *  <b>필수 : reCategory, reParentNo </b>
	 * </pre> 
	 * @param searchVO
	 * @return List<ReplyVO>
	 * @throws BizException
	 */
	public List<ReplyVO> getReplyList(ReplyVO reply) throws BizException;
	
	/**
	 * 댓글등록 <br>	     
	 * @param ReplyVO
	 * @throws BizException 
	 */
	public void registReply(ReplyVO reply) throws BizException ;
	
	/**
	 * 댓글 수정 <br>
	 * 해당글의 존재하지 않으면 BizNotException
	 * 해당글의 작성자 ID 와 현재 사용자 ID가 다른 경우 BizAccessFailException 
	 * @param ReplyVO
	 * @throws BizException 
	 *   
	 */
	public void modifyReply(ReplyVO reply) throws BizException;
	
	/** <pre>
	 * 댓글 삭제 <br>
	 * 해당글의 존재하지 않으면 BizNotException
	 * 해당글의 작성자 ID 와 현재 사용자 ID가 다른 경우 BizAccessFailException 
	 * </pre>
	 * @param ReplyVO
	 * @throws BizException
	 */
	public void removeReply(ReplyVO reply) throws BizException;
	
}
