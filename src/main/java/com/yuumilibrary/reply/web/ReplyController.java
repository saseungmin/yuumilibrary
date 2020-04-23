package com.yuumilibrary.reply.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.reply.service.IReplyService;
import com.yuumilibrary.reply.vo.ReplyVO;

@Controller
public class ReplyController {
	private final Logger logger = LoggerFactory.getLogger(getClass());

	/*
	 * 경고!! 대댓글이 아닌 새 댓글을 쓸 때에는 reGroupNum을 VO에 담아주면 안되요!!
	 */

	@Autowired
	private IReplyService replyService;

	@RequestMapping(value = "/reply/replyList.lol", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getReplyList(ReplyVO reply, ModelMap model) throws BizException {
		List<ReplyVO> list = replyService.getReplyList(reply);
		
		logger.debug("ReplyVO CASE( GET LIST ) = {}", reply);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("result", true);
		map.put("list", list);

		model.addAttribute(list);

		return map;
	}

	@RequestMapping("/reply/replyRegist.lol")
	@ResponseBody
	public Map<String, Object> registReply(ReplyVO reply) throws BizException {
		System.out.println("ENTER registReply!!");
		replyService.registReply(reply);
		logger.debug("ReplyVO CASE( REGIST ) = {}", reply);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		
		return map;

	}

	@RequestMapping("/reply/replyModify.lol")
	@ResponseBody
	public Map<String, Object> ModifyReply(ReplyVO reply) throws BizException {
		replyService.modifyReply(reply);
		logger.debug("ReplyVO CASE( MODIFY ) = {}", reply);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		return map;
	}

	@RequestMapping("/reply/replyDelete.lol")
	@ResponseBody
	public Map<String, Object> deleteReply(ReplyVO reply) throws BizException {
		logger.debug("ReplyVO CASE( DELETE ) = {}", reply);
		reply.setReContent("<p style='color:red;'>삭제된 댓글입니다.</p>");
		replyService.removeReply(reply);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		
		return map;
	}
}
