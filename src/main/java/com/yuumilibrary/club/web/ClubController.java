package com.yuumilibrary.club.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.executor.ReuseExecutor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yuumilibrary.club.service.IClubBoardService;
import com.yuumilibrary.club.service.IClubMemberService;
import com.yuumilibrary.club.vo.ClubMemberListVO;
import com.yuumilibrary.club.vo.ClubSearchVO;
import com.yuumilibrary.club.vo.ClubVO;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.login.vo.UserVO;
import com.yuumilibrary.util.StudyAttachUtils;

@Controller
public class ClubController {
	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private StudyAttachUtils attachUtils;

	@Autowired
	private IClubBoardService clubBoardService;

	@Autowired
	private IClubMemberService clubService;

	@RequestMapping("/club/clubMain.lol")
	public String clubMain(ModelMap model, ClubSearchVO searchVO) throws Exception {
		try {
			List<ClubVO> list = clubService.getClubList(searchVO);
			model.addAttribute("list", list);
			model.addAttribute("searchVO", searchVO);
			return "club/clubMain";

		} catch (Exception e) {
			throw new Exception(e);
		}
	}
	/*
	@RequestMapping(value = "/club/clubMainView.lol", method = RequestMethod.POST)
	public String clubMainView(ModelMap model, ClubVO clubVO, ClubMemberListVO clubListVO) throws Exception{
		ClubVO club = clubService.getClub(clubVO.getBkNum());
		
		//ClubMemberListVO mem = clubService.getClubMember(clubListVO.getCmMemId()); 
			
		model.addAttribute("club", club);
		//model.addAttribute("mem", mem); 
		return "club/clubMainView";

	}
	*/
}
