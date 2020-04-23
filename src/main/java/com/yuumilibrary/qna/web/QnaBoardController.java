package com.yuumilibrary.qna.web;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;
import com.yuumilibrary.common.valid.ModifyValid;
import com.yuumilibrary.common.valid.RegistValid;
import com.yuumilibrary.common.vo.ResultMessageVO;
import com.yuumilibrary.login.vo.UserVO;
import com.yuumilibrary.member.service.IMemberService;
import com.yuumilibrary.member.vo.MemberSearchVO;
import com.yuumilibrary.member.vo.MemberVO;
import com.yuumilibrary.qna.service.IQnaService;
import com.yuumilibrary.qna.vo.QnaBoardVO;
import com.yuumilibrary.qna.vo.QnaSearchVO;
import com.yuumilibrary.rsa.RSAsss;
import com.yuumilibrary.rsa.SHA256Util;
import com.yuumilibrary.util.CookieBox;

@Controller
public class QnaBoardController {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private IQnaService qnaService;

	@Autowired
	private IMemberService memberService;

	@RequestMapping(value = "/qna/qnaList.lol")
	public String qnaList(ModelMap model, QnaSearchVO searchVO, HttpSession session) throws BizException {
		List<QnaBoardVO> list = qnaService.getQnaBoardList(searchVO);
		searchVO.setting();

		model.addAttribute("list", list);
		model.addAttribute("searchVO", searchVO);

		return "qna/qnaList";

	}

	@RequestMapping(value = "/qna/qnaView.lol", method = RequestMethod.GET, params = "qbNum")
	public String qnaView(HttpServletRequest req, HttpServletResponse resp, @RequestParam("qbNum") int qbNum) throws BizException {
		try {
			QnaBoardVO qna = qnaService.getQnaBoardView(qbNum);
			
			//조회수
			CookieBox box = new CookieBox(req);
			String readBoard = box.getValue("qna");
			if (readBoard == null)
				readBoard = "";
			String pat = "\\b" + qbNum + "\\b";
			if (!Pattern.compile(pat).matcher(readBoard).find()) {
				qnaService.increaseHitCount(qna.getQbNum());
				Cookie cookie = CookieBox.createCookie("qna", readBoard + qbNum + "|");
				resp.addCookie(cookie);
			}
			//조회수 끝
			
			req.setAttribute("qna", qna);	// 본문내용 설정
			
						
			
			return "/qna/qnaView";

		} catch (Exception e) {
			throw new BizException(e);
		}

	}

	@RequestMapping("/qna/qnaEdit.lol")
	public String qnaEdit(ModelMap model, int qbNum) {
		QnaBoardVO qna = qnaService.getQnaBoardView(qbNum);
		model.addAttribute("qna", qna);
		return "qna/qnaEdit";
	}

	@RequestMapping(value = "qna/qnaModify.lol", method = RequestMethod.POST)
	public String qnaModify(
			@ModelAttribute("qna") @Validated(value = { ModifyValid.class, Default.class }) QnaBoardVO board,
			BindingResult errors, HttpServletRequest req, HttpServletResponse resp) {

		logger.info("QnA : {}", board);
		try {

			if (errors.hasErrors()) {
				logger.debug(errors.getFieldError().toString());
			} // 물어보기

			qnaService.modifyQnaBoard(board);
			return "redirect:/qna/qnaList.lol";
		} catch (BizException e) {
			ResultMessageVO message = new ResultMessageVO();
			message.setResult(false).setTitle("수정실패").setMessage("문의게시판 수정에 실패했습니다!").setUrl("/qna/qnaList.lol")
					.setUrlTitle("목록으로");
			req.setAttribute("resultMessage", message);
			return "common/message";
		}
	}

	@RequestMapping("qna/qnaForm")
	public String qnaForm(ModelMap model, HttpSession session, MemberSearchVO memberVO) {

		String dup_key = UUID.randomUUID().toString();
		session.setAttribute("DUP_SUBMIT_PREVENT", dup_key);

		model.addAttribute("dup_key", dup_key);
		model.addAttribute("qna", new QnaBoardVO());

		return "qna/qnaForm";
	}

	@RequestMapping(value = "qna/qnaRegist.lol", method = RequestMethod.POST)
	public String qnaRegist(HttpSession session, @RequestParam("dup_key") String p_dup_key,
			@ModelAttribute("free") @Validated(value = { RegistValid.class, Default.class }) QnaBoardVO board,
			BindingResult errors, HttpServletRequest req, ModelMap model) throws Exception {

		if (errors.hasErrors()) {
			model.addAttribute("dup_key", p_dup_key);
			System.out.println("*******************************hasError*******************************");
			return "qna/qnaForm";
		}

		String s_dup_key = (String) session.getAttribute("DUP_SUBMIT_PREVENT");
		if (p_dup_key == null || p_dup_key.isEmpty()) {
			return "redirect:/";
		} else {
			if (s_dup_key == null || !s_dup_key.equals(p_dup_key)) {
				ResultMessageVO message = new ResultMessageVO();
				message.setResult(false).setTitle("중복등록").setMessage("새롭게 작성해 주세요").setUrl("/qna/qnaForm.lol")
						.setUrlTitle("새글등록");
				model.addAttribute("resultMessage", message);
				return "common/message";
			}
		}

		try {
			qnaService.registQnaBoard(board);
			session.removeAttribute("DUP_SUBMIT_PREVENT");
			return "redirect:/qna/qnaList.lol";
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}

	}

	@RequestMapping(value = "qna/qnaDelete.lol")
	public String qnaDelete(ModelMap model, HttpServletRequest req, QnaBoardVO board) {
		System.out.println("***************************" + board);
		qnaService.deleteQnaBoard(board);
		return "redirect:/qna/qnaList.lol";
	}

	@RequestMapping(value = "/qna/qnaCheck.lol" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> qnaCheck(ModelMap model, QnaBoardVO board ,HttpSession session) {
		logger.info("board=========={}",board);
		Map<String, Object> map =new HashMap<String, Object>();
		MemberVO member;
		try {
			UserVO vo= (UserVO)session.getAttribute("USER_INFO");
			member = memberService.getMember(vo.getUserID());
			
			if(member.getMemRank().equals("관리자")){
				map.put("result",true);
				return map;
			} else {
				logger.info("member================{}",member);
				String salt=member.getMemSalt();
				String myPrivateKey=member.getMemPrivateKey();
				String decodeSalt=RSAsss.decode(salt, myPrivateKey);
				String userSalt=SHA256Util.getEncrypt(board.getQbPass(), decodeSalt);
				
				if (member.getMemPass().equals(userSalt)) {
					map.put("result",true);
					logger.info("ddddddddddddddd======={}",map);
					
					return map;
				} else {
					map.put("result", false);
					map.put("message","비밀번호가 일치하지 않습니다.");
					
					return map;
					
				}
			}
			
		} catch (BizNotFoundException e) {
			map.put("result", false);
			map.put("message", "회원정보를 찾을 수 없습니다.");
			
			return map;
		}

	}

}