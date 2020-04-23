package com.yuumilibrary.free.web;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.yuumilibrary.attach.vo.AttachVO;
import com.yuumilibrary.common.dao.ICommonCodeDao;
import com.yuumilibrary.common.exception.BizDuplicateException;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;
import com.yuumilibrary.common.exception.BizRegistFailException;
import com.yuumilibrary.common.valid.RegistValid;
import com.yuumilibrary.common.vo.CodeVO;
import com.yuumilibrary.common.vo.ResultMessageVO;
import com.yuumilibrary.free.service.IFreeBoardService;
import com.yuumilibrary.free.vo.FreeBoardVO;
import com.yuumilibrary.free.vo.FreeSearchVO;
import com.yuumilibrary.member.service.IMemberService;
import com.yuumilibrary.util.CookieBox;
import com.yuumilibrary.util.StudyAttachUtils;


@Controller
public class FreeBoardController {

private final Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private IFreeBoardService freeBoardService;

	@Autowired
	private ICommonCodeDao codeService;
	
	@Autowired
	private IMemberService memberService;
	
	@Autowired
	private StudyAttachUtils attachUtils;
	
	@RequestMapping(value = {"/free/freeList.lol" ,"/main.lol"})
	public void freeList(ModelMap model, FreeSearchVO searchVO, FreeBoardVO free) throws Exception{
		logger.debug("debug searchVO : {}", searchVO);
		
		List<CodeVO> a = codeService.getCodeListByParent("BC00");
		List<FreeBoardVO> list = freeBoardService.getBoardList(searchVO);
		
		logger.info("list size = {}", list.size()); 
		
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("list", list);
		model.addAttribute("catList", a);
//		model.addAttribute("free", free);
//		model.addAttribute("free", list.get(0));
		
	}
	
	@RequestMapping(value = {"/free/freeView.lol", "/main.lol"}, method = RequestMethod.GET , params = {"boNum","boNotice"})
	public String freeView(ModelMap model, HttpServletRequest req, HttpServletResponse resp, @RequestParam("boNum") int num, @RequestParam("boNotice") int boNotice) throws Exception {

		try {

			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("boNum",num);
			map.put("boNotice",boNotice);
			map.put("atchCategory","FREE");

			FreeBoardVO free = freeBoardService.getBoard(map);
			CookieBox box = new CookieBox(req);
			String readBoard = box.getValue("free");
			if (readBoard == null)
				readBoard = "";
			String pat = "\\b" + num+boNotice + "\\b";
			if (!Pattern.compile(pat).matcher(readBoard).find()) {
				freeBoardService.increaseHit(free);
				Cookie cookie = CookieBox.createCookie("free", readBoard + num +boNotice+ "|");
				resp.addCookie(cookie);
			}
			System.out.println(free);
			model.addAttribute("free", free);
			
			return "free/freeView";
		} catch (BizNotFoundException e) {
			
			logger.error("조회 오류 boNum= {}", num, e);
			
			ResultMessageVO message = new ResultMessageVO();
			message.setResult(false)
				   .setTitle("조회 실패")
				   .setMessage("해당글이 삭제되었거나, 존재하지 않습니다.")
				   .setUrl("/free/freeList.lol")
				   .setUrlTitle("목록");
			req.setAttribute("resultMessage", message);
			return "common/message";
		}
	}
	
	@RequestMapping(value = "/free/freeEdit.lol")
	public String freeEdit(int boNum, ModelMap model,int boNotice) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("boNum",boNum);
		map.put("boNotice",boNotice);
		map.put("atchCategory","FREE");

		FreeBoardVO free = freeBoardService.getBoard(map);
		List<CodeVO> a = codeService.getCodeListByParent("BC00");
		
		model.addAttribute("free", free);
		model.addAttribute("catList", a);
		
		return "free/freeEdit";
	}
	
	@RequestMapping(value = "/free/freeModify.lol", method = RequestMethod.POST)
	public String freeModify(FreeBoardVO free, ModelMap model) throws Exception {
		ResultMessageVO message = null;
		logger.info("넘어오는 값----------"+free.toString());
		try {
			model.addAttribute("catList", codeService.getCodeListByParent("BC00"));			
			freeBoardService.modifyBoard(free);
			
			return "redirect:/free/freeList.lol?msg=" + URLDecoder.decode("success", "utf-8");
		} catch (BizRegistFailException e) {
			message = new ResultMessageVO().setResult(false)
			.setTitle("수정실패")
			.setMessage("자유게시판 수정에 실패했습니다!")
			.setUrl("/free/freeList.lol")
			.setUrlTitle("목록으로");
			model.addAttribute("resultMessage", message);
			return "common/message";
		}
	}
	
	@RequestMapping("/free/freeDelete.lol")
	public String freeDelete(int boNum, FreeBoardVO free, ModelMap model) throws Exception {
		try {
			
			logger.info("free--------del{}",free.toString());
			freeBoardService.removeBoard(free);
			
			return "redirect:/free/freeList.lol?msg=" + URLDecoder.decode("success", "utf-8");
		} catch (BizException e) {
			ResultMessageVO message = new ResultMessageVO();
			message.setResult(false)
			.setTitle("삭제실패")
			.setMessage("자유게시판 삭제에 실패했습니다!")
			.setUrl("/free/freeList.lol")
			.setUrlTitle("목록으로");
			model.addAttribute("resultMessage", message);
			return "common/message";
		}
	}
	
	@RequestMapping(value = "/free/freeForm.lol")
	public String freeForm(ModelMap model, HttpSession session) throws Exception {
		// 중복방지 토큰 생성
		String dup_key = UUID.randomUUID().toString();
		session.setAttribute("DUP_SUBMIT_PREVENT", dup_key);

		List<CodeVO> a = codeService.getCodeListByParent("BC00");
		model.addAttribute("catList", a);
		model.addAttribute("dup_key", dup_key);
		model.addAttribute("free", new FreeBoardVO());
		
		return "free/freeForm";
	}

	@RequestMapping(value = "/free/freeRegist.lol", method = RequestMethod.POST)
	public String freeRegist(@RequestParam(name="boFiles",required=false) MultipartFile[] boFile ,HttpSession session, @RequestParam("dup_key") String p_dup_key,
							@ModelAttribute("free") @Validated(value = {RegistValid.class, Default.class}) FreeBoardVO free,
							BindingResult errors, HttpServletRequest req, ModelMap model) throws Exception {
		logger.info(free.toString());
		if(errors.hasErrors()) {
			model.addAttribute("catList", codeService.getCodeListByParent("BC00"));
			model.addAttribute("dup_key", p_dup_key);
			return "free/freeForm";
		}
		// 중복제한 토근 확인
		String s_dup_key = (String) session.getAttribute("DUP_SUBMIT_PREVENT");
		if (p_dup_key == null || p_dup_key.isEmpty()) {
			return "redirect:/";
		} else {
			if (s_dup_key == null || !s_dup_key.equals(p_dup_key)) {
				ResultMessageVO message = new ResultMessageVO();
				message.setResult(false)
						.setTitle("중복등록")
						.setMessage("새롭게 작성해 주세요")
						.setUrl("/free/freeForm.lol")
						.setUrlTitle("새글등록");
				model.addAttribute("resultMessage", message);
				return "common/message";
			}
		}

		try {
			// 업로드파일이 존재하는 경우 저장후 해당 정보를 vo에 설정
			if(boFile!=null) {
				List<AttachVO> attaches = attachUtils.getAttachListByMultiparts(boFile, "FREE", "free");
				free.setAttaches(attaches);
			}
			// vo에 저장된 업로드정보는 서비스단에서 처리한다.
			freeBoardService.registBoard(free);
			session.removeAttribute("DUP_SUBMIT_PREVENT");
//			return "redirect:/free/freeView.lol?boNum=" + free.getBoNum();
			return "redirect:/free/freeList.lol?msg=" + URLDecoder.decode("success", "utf-8");
		} catch (BizDuplicateException e) {
			ResultMessageVO message = new ResultMessageVO();
			message.setResult(false)
					.setTitle("등록실패")
					.setMessage("해당 키가 중복되었습니다. 다른 키를 사용해주세요.");
			model.addAttribute("resultMessage", message);
			return "common/message";

		}
	}
}
