package com.yuumilibrary.chat.web;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yuumilibrary.chat.service.IClubChatService;
import com.yuumilibrary.chat.vo.ChatMessageVO;
import com.yuumilibrary.club.service.IClubMemberService;
import com.yuumilibrary.club.vo.ClubMemberListVO;
import com.yuumilibrary.club.vo.ClubVO;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;

@Controller
public class ClubChatController {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private IClubChatService chatService;
	
	@Autowired
	private IClubMemberService clubMemberService;
	
	@RequestMapping(value = "/club/clubChat.lol")
	public void clubForm(ModelMap model, int bkNum, String bkClubName, RedirectAttributes redirectAttributes) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		logger.info("bkNum==={} , bkClubName======{}",bkNum,bkClubName);
		try {
			
			List<ClubMemberListVO> list=clubMemberService.getClubChatMember(bkNum);
			
			List<ChatMessageVO> messageList=chatService.getMessage(bkNum);
			
			ClubVO club=clubMemberService.getClub(bkNum);
			if(messageList != null) {
				
				logger.info("message======={}",messageList);
				model.addAttribute("message",messageList);
			}
			
			logger.info("List======={}",list);
			logger.info("club======={}",club);
			model.addAttribute("club",club);
			model.addAttribute("list", list);
			
		} catch (BizNotFoundException e) {
			map.put("result", false);
			map.put("error", "clubnotFound");
			redirectAttributes.addFlashAttribute("message", map);
		}
		
	}
	
	@RequestMapping(value = "/club/chatCheck.lol" ,produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> chatCheck(ModelMap model,ClubMemberListVO member) throws Exception {
		
		Map<String, Object> map =new HashMap<String, Object>();
		logger.info("clubmemberVO=========={}",member);
		try {
			member= chatService.getClubCheckMember(member);
			
			map.put("result", true);
			return map;
			
		} catch (BizNotFoundException e) {
			map.put("result", false);
			map.put("error", "해당 클럽에 회원이 가입되지 않았거나, 가입 승인이 되지 않았습니다. 가입 후 이용해주세요.");
			return map;
		}

	}
	
	@RequestMapping(value = "/club/userStatus.lol", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> userStatus(String status, String userId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("status",status);
		
		logger.info("map==========status{}",map);
		
		return map;
	}

}
