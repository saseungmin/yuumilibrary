package com.yuumilibrary.club.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.groups.Default;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yuumilibrary.attach.vo.AttachVO;
import com.yuumilibrary.club.service.IClubBoardService;
import com.yuumilibrary.club.service.IClubMemberService;
import com.yuumilibrary.club.vo.ClubBoardVO;
import com.yuumilibrary.club.vo.ClubMemberListVO;
import com.yuumilibrary.club.vo.ClubSearchVO;
import com.yuumilibrary.club.vo.ClubVO;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.valid.RegistValid;
import com.yuumilibrary.login.vo.UserVO;
import com.yuumilibrary.util.CookieBox;
import com.yuumilibrary.util.StudyAttachUtils;

@Controller
public class ClubBoardController {
	@SuppressWarnings("unused")
	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private IClubBoardService clubBoardService;

	@Autowired
	private StudyAttachUtils attachUtils;
	
	@Autowired
	private IClubMemberService clubService;

	@RequestMapping(value = {"/club/clubMainView.lol", "club/clubBoardList.lol"})
	public String clubBoardList(ModelMap model, ClubSearchVO searchVO, ClubMemberListVO listVO, HttpSession session, ClubBoardVO board, ClubVO clubVO) throws Exception {
		// 클럽리스트로 가기전에 cbBoClubNum 파라미터로 받기
		Map<Object, Object> map =new HashMap<Object, Object>();
		// 게시판 보기전에 권한체크(비로그인 또는 비클럽원은 게시판 접근 불가)
		clubVO = (ClubVO) model.get("clubVO");
		logger.info("club==============={}",clubVO);
		logger.info("list==============={}",listVO);
		map.put("cmNum", clubVO.getBkNum());
		map.put("cmMemId", listVO.getCmMemId());
		
		ClubVO club = clubService.getClub(clubVO.getBkNum());
		List<ClubMemberListVO> mem = clubService.getClubMember(map); 
		logger.info("mem===============",mem);
		
		searchVO.setCbBoClubNum(clubVO.getBkNum());
		List<ClubBoardVO> list = clubBoardService.getBoardList(searchVO);
		model.addAttribute("list", list);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("clubNum", board.getCbBoClubNum());
		model.addAttribute("club", club);
		model.addAttribute("mem", mem.size());

		return "club/clubMainView";

	}

	@RequestMapping(value = "/club/clubBoardView.lol", params = { "cbBoNum", "cbBoClubNum", "notice" })
	public String clubBoardView(ModelMap model, HttpServletRequest req, HttpServletResponse resp,
			@RequestParam("cbBoNum") int cbBoNum, @RequestParam("cbBoClubNum") int cbBoClubNum,
			@RequestParam("notice") int notice) throws Exception {
		try {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("boNum", cbBoNum);
			map.put("cbBoClubNum", cbBoClubNum);
			map.put("boNotice", notice);
			map.put("atchCategory", "ClubBoard" + cbBoClubNum);

			ClubBoardVO board = clubBoardService.getBoard(map);

			// 쿠키설정 시작 (조회수 중복방지)
			CookieBox box = new CookieBox(req);
			String readBoard = box.getValue("clubview");
			if (readBoard == null)
				readBoard = "";
			String pat = "\\b" + cbBoNum + "\\b";
			if (!Pattern.compile(pat).matcher(readBoard).find()) {
				clubBoardService.increaseHit(cbBoNum, cbBoClubNum);
				Cookie cookie = CookieBox.createCookie("clubview", readBoard + cbBoNum + "|");
				resp.addCookie(cookie);
			}
			// 쿠키설정 끝

			model.addAttribute("board", board);
		} catch (Exception e) {
			throw new BizException(e);
		}
		return "club/clubBoardView";
	}

	@RequestMapping(value = "/club/clubBoardRegist.lol", method = RequestMethod.POST)
	public String clubBoardRegist(
			@ModelAttribute("boardVO") @Validated(value = { RegistValid.class, Default.class }) ClubBoardVO boardVO,
			BindingResult errors, HttpServletRequest req, ModelMap model, @RequestParam("dup_key") String p_dup_key,
			HttpSession session, @RequestParam(name = "cbBoFiles", required = false) MultipartFile[] boFiles, RedirectAttributes redirectAttributes)
			throws Exception {

		if (errors.hasErrors()) {
			model.addAttribute("dup_key", p_dup_key);
		}

		String s_dup_key = (String) session.getAttribute("DUP_PREVENT");
		if (p_dup_key == null || p_dup_key.isEmpty()) {
			return "redirect:/";
		} else {
			if (s_dup_key == null || !s_dup_key.equals(p_dup_key)) {
				System.out.println("**********중복등록*********");
				throw new DuplicateKeyException("중복등록중");
			}
		}

		try {
			if (boFiles != null) {
				List<AttachVO> attaches = attachUtils.getAttachListByMultiparts(boFiles,
						"ClubBoard" + boardVO.getCbBoClubNum(), "clubboard");
				boardVO.setAttaches(attaches);
			}

			clubBoardService.registBoard(boardVO);
			session.removeAttribute("DUP_PREVENT");
			ClubVO clubVO = new ClubVO();
			clubVO.setBkNum(boardVO.getCbBoClubNum());
			redirectAttributes.addFlashAttribute("clubVO", clubVO);
			redirectAttributes.addFlashAttribute("board", boardVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/club/clubMainView.lol";
	}

	@RequestMapping(value = "/club/clubBoardForm.lol", method = RequestMethod.POST)
	public String clubBoardForm(ModelMap model, HttpSession session, ClubBoardVO board) throws Exception {
		String dup_key = UUID.randomUUID().toString();
		session.setAttribute("DUP_PREVENT", dup_key);

		System.out.println("Club Number is " + board.getCbBoClubNum());

		UserVO user = (UserVO) session.getAttribute("USER_INFO");

		board.setCbBoWriter(user.getUserName());
		board.setCbBoMemId(user.getUserID());
		model.addAttribute("dup_key", dup_key);
		model.addAttribute("board", board);
		
		return "club/clubBoardForm";
	}

	@RequestMapping("/club/clubBoardEdit.lol")
	public String clubBoardEdit(ModelMap model, HttpSession session, int cbBoClubNum, int cbBoNum, int cbBoNotice)
			throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("boNum", cbBoNum);
		map.put("cbBoClubNum", cbBoClubNum);
		map.put("boNotice", cbBoNotice);
		map.put("atchCategory", "ClubBoard" + cbBoClubNum);
		ClubBoardVO board = clubBoardService.getBoard(map);

		String dup_key = UUID.randomUUID().toString();
		session.setAttribute("DUP_PREVENT", dup_key);

		model.addAttribute("dup_key", dup_key);
		model.addAttribute("board", board);

		return "club/clubBoardEdit";
	}

	@RequestMapping("/club/clubBoardModify.lol")
	public String clubBoardModify(ClubBoardVO board, ModelMap model, RedirectAttributes redirectAttributes) throws Exception {
		try {
			clubBoardService.modifyBoard(board);
			
			ClubVO clubVO = new ClubVO();
			clubVO.setBkNum(board.getCbBoClubNum());
			redirectAttributes.addFlashAttribute("clubVO", clubVO);
			redirectAttributes.addFlashAttribute("board", board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/club/clubMainView.lol";
	}

	@RequestMapping("/club/clubBoardDelete.lol")
	public String clubBoardDelete(ClubBoardVO board, RedirectAttributes redirectAttributes) throws Exception {
		try {
			clubBoardService.removeBoard(board);
			
			ClubVO clubVO = new ClubVO();
			clubVO.setBkNum(board.getCbBoClubNum());
			redirectAttributes.addFlashAttribute("clubVO", clubVO);
			redirectAttributes.addFlashAttribute("board", board);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/club/clubMainView.lol";
	}
	
	@RequestMapping("/club/clubSmallMain")
	public void clubSmallMain() throws Exception{
		
	}
	
	
	

}
