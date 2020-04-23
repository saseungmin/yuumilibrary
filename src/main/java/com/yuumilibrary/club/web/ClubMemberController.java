package com.yuumilibrary.club.web;

import java.io.File;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yuumilibrary.club.service.IClubMemberService;
import com.yuumilibrary.club.vo.ClubMemberListVO;
import com.yuumilibrary.club.vo.ClubSearchVO;
import com.yuumilibrary.club.vo.ClubVO;
import com.yuumilibrary.common.exception.BizDuplicateException;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.vo.ResultMessageVO;
import com.yuumilibrary.login.vo.UserVO;

@Controller
public class ClubMemberController {
	
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	@Resource(name = "clubImgPath")
	private String uploadPath;
	

	@Autowired
	private IClubMemberService clubMemberService;

	@RequestMapping("/club/clubList.lol")
	public void clubList(ClubVO clubVO, ClubSearchVO searchVO, ModelMap model) throws Exception {
		logger.info("clubVo=========={}",clubVO);
		List<ClubVO> list = clubMemberService.getClubList(searchVO);
		
		logger.info("list==============={}",list);
		model.addAttribute("list", list);
		model.addAttribute("searchVO", searchVO);
	}

	@RequestMapping(value = "/club/clubView.lol", method = RequestMethod.GET, params = "bkClubName")
	public String clubView(ModelMap model, int bkNum, ClubMemberListVO vo)
			throws Exception {
		ClubVO clubVO = clubMemberService.getClub(bkNum);
		model.addAttribute("clubVO", clubVO);
		return "club/clubView";
	}

	@RequestMapping(value = "/club/clubForm.lol")
	public String clubForm(ModelMap model) throws Exception {

		return "club/clubForm";
	}

	@RequestMapping(value = "/club/clubRegist.lol", method = {RequestMethod.POST, RequestMethod.GET})
	public String clubRegist(@RequestParam(name="clubImage",required=false)MultipartFile file, ClubVO clubVO, ModelMap model) throws Exception {
		
		try {
			logger.info("clubVO=============={}",clubVO);
			
			logger.info("file=============={}",file);
			String savedName=uploadFile(file.getOriginalFilename(), file.getBytes());
			clubVO.setBkImageurl(savedName);
			clubMemberService.registClub(clubVO);
			return "redirect:/club/clubMain.lol";
		} catch (BizException e) {			
			 ResultMessageVO message = new ResultMessageVO();
			 message.setResult(false).setTitle("클럽 등록 실패").setMessage(e.toString()).setUrl
			 ("/club/clubForm") .setUrlTitle("목록으로"); model.addAttribute("resultMessage",
			 message); return "common/message";
			 
		}
	}

	@RequestMapping(value = "/club/clubEdit.lol")
	public String clubEdit(int bkNum, ClubVO clubVO, ModelMap model,
			HttpSession session) throws Exception {
		ClubVO vo = clubMemberService.getClub(bkNum);
		model.addAttribute("vo", vo);
		ResultMessageVO message = null;
		UserVO user = (UserVO) session.getAttribute("USER_INFO");
		if (vo != null) {
			if (vo.getBkMemId().equals(user.getUserID()) || user.getUserRole().equals("관리자")) {
				return "club/clubEdit";
			} else {
				message = new ResultMessageVO().setResult(false).setTitle("권한없음")
						.setMessage("클럽 회장만 클럽 내용 수정 및 삭제가 가능합니다.");
			}
		}
		model.addAttribute("resultMessage", message);
		return "common/message";
	}

	@RequestMapping(value = "/club/clubModify.lol", method = RequestMethod.POST)
	public String clubModify(ClubVO clubVO, ModelMap model) throws Exception {
		ResultMessageVO message = null;
		System.out.println(";;;;;;;;;;;;;;;;;;;;;;"+clubVO);
		try {
			clubMemberService.modifyClub(clubVO);
			return "redirect:/club/clubMain.lol";
		} catch (BizException e) {
			message = new ResultMessageVO().setResult(false).setTitle("수정 실패").setMessage("클럽이 존재하지 않습니다")
					.setUrl("redirect:/").setUrlTitle("메인화면");
		}
		model.addAttribute("resultMessage", message);
		return "common/message";
	}

	@RequestMapping(value = "/club/clubDelete.lol", method = RequestMethod.POST)
	public String clubDelete(ClubVO clubVO, ModelMap model) throws Exception {
		ResultMessageVO message = null;
		try {
			clubMemberService.removeClub(clubVO);
			return "redirect:/club/clubMain.lol";
		} catch (BizException e) {
			message = new ResultMessageVO().setResult(false).setTitle("삭제 실패").setMessage("클럽 삭제 실패했습니다.")
					.setUrl("redirect:/").setUrlTitle("메인화면");
		}
		model.addAttribute("resultMessage", message);
		return "common/message";
	}

	@RequestMapping(value = "/club/clubMemberList.lol", method = RequestMethod.POST)
	public void clubMemberList(ClubMemberListVO clubListVO, ModelMap model) throws Exception {
		logger.info("clublist==========={}",clubListVO);
		List<ClubMemberListVO> list = clubMemberService.getClubMemberList(clubListVO);
		logger.info("list==========={}",list);

		model.addAttribute("count", list.size());
		model.addAttribute("list", list);
	}

	@RequestMapping(value = "/club/clubMemberRegist.lol", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> clubMemberRegist(ClubVO clubVO, RedirectAttributes redirectAttributes, ModelMap model)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			ClubMemberListVO clubListVO = new ClubMemberListVO();
			clubListVO.setCmNum(clubVO.getBkNum());
			clubListVO.setCmClubName(clubVO.getBkClubName());
			clubListVO.setCmMemId(clubVO.getBkMemId());
			clubMemberService.registMember(clubListVO);
			map.put("message", "가입 성공! 클럽장의 승인이 필요합니다.");
			map.put("result", true);
			redirectAttributes.addFlashAttribute("message", map);
			return map;
		} catch (BizDuplicateException e) {
			map.put("message", "다른 클럽에 가입되거나 가입신청되었습니다. 혹은 다른 클럽의 클럽장입니다.");
			map.put("result", false);
			return map;
		}
	}

	@RequestMapping(value = "/club/clubMemberConfirm.lol", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> clubMemberConfirm(ClubMemberListVO clubListVO, ModelMap model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("cmClubName", clubListVO.getCmClubName());
			map.put("cmMemId", clubListVO.getCmMemId());
			map.put("cmNum", clubListVO.getCmNum());

			clubMemberService.registMemberConfirm(map);
			
			map.put("message", "승인 성공");
			map.put("result", true);
			return map;
		} catch (BizException e) {
			map.put("message", "승인 실패");
			map.put("result", false);
			return map;
		}
	}

	@RequestMapping(value = "/club/clubMemberDelete.lol", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> clubMemberDelete(ClubMemberListVO clubListVO, RedirectAttributes redirectAttributes, ModelMap model) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("cmClubName", clubListVO.getCmClubName());
			map.put("cmMemId", clubListVO.getCmMemId());
			map.put("cmNum", clubListVO.getCmNum());

			clubMemberService.withdrawMember(map);
			map.put("message", "탈퇴 성공");
			map.put("result", true);
			redirectAttributes.addFlashAttribute("message", map);
			return map;
		} catch (BizException e) {
			map.put("message", "탈퇴 실패");
			map.put("result", false);
			return map;
		}
	}
	
	
	
	public String uploadFile(String originalName, byte [] fileData) throws Exception{
		
		
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString()+ "-" + originalName;
		File target = new File(uploadPath, savedName);
		FileCopyUtils.copy(fileData, target);
		
		return savedName;
	}

}
