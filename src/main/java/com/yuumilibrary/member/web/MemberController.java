package com.yuumilibrary.member.web;

import java.util.HashMap;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yuumilibrary.common.dao.ICommonCodeDao;
import com.yuumilibrary.common.exception.BizDuplicateException;
import com.yuumilibrary.common.exception.BizNotFoundException;
import com.yuumilibrary.common.exception.BizRegistFailException;
import com.yuumilibrary.common.service.ICommonCodeService;
import com.yuumilibrary.common.vo.CodeVO;
import com.yuumilibrary.common.vo.ResultMessageVO;
import com.yuumilibrary.login.vo.UserVO;
import com.yuumilibrary.member.service.IMemberService;
import com.yuumilibrary.member.vo.MemberSearchVO;
import com.yuumilibrary.member.vo.MemberVO;

// @Componemt, @Service, @controller, @mapper

@Controller
public class MemberController {

	@Autowired
	private ICommonCodeDao codeService;

	@Autowired
	private IMemberService memberService;

	@RequestMapping(value = "/member/memberList.lol")
	public void memberList(ModelMap model, MemberSearchVO searchVO) throws Exception {

		List<MemberVO> list = memberService.getMemberList(searchVO);
		List<CodeVO> codes = codeService.getCodeListByParent("CN00");
		List<CodeVO> rank = codeService.getCodeListByParent("RA00");
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("list", list);
		model.addAttribute("pref", codes);
		model.addAttribute("rank", rank);

	}

	// 회원목록을 엑셀로 뽑아낸다.
	@RequestMapping("/member/getExcelMemberList.lol")
	public String toExcel(HttpServletRequest req, HttpSession session, MemberSearchVO searchVO, ModelMap model) {
		List<MemberVO> list = memberService.getMemberListForExcel();
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("list", list);
		
		//ModelAndView result = new ModelAndView();
		//result.addObject(list);
		
		Calendar now = new GregorianCalendar();
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH) + 1;
		int day = now.get(Calendar.DAY_OF_MONTH);
		int hour = now.get(Calendar.HOUR_OF_DAY);

		StringBuffer str = new StringBuffer();
		str.append(year).append(month).append(day).append(hour);
		req.setAttribute("filename", str);
//		result.setViewName("member/getExcelMemberList");
		return "member/getExcelMemberList";
	}

	@RequestMapping(value = "/member/memberView.lol", method = RequestMethod.GET,params = "memId")
	public String memberView(ModelMap model, HttpServletResponse resp, @RequestParam("memId")String id) throws Exception{

		MemberVO member = memberService.getMember(id);
		System.out.println(member);
		model.addAttribute("mem", member);

		return "member/memberView";
	}
	@RequestMapping(value = "/member/memberIdCheck.lol", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> memberSelect(ModelMap model, HttpServletResponse resp , MemberVO member) throws Exception{
		Map<String, Object> map=new HashMap<String, Object>();
			member=memberService.getMemberId(member.getMemId());
			if(member == null) {
				map.put("result",true);
			}else {
				map.put("result",false);
			}
		return map;
	}
	

	@RequestMapping(value = "/chat/chating.lol")
	public String chatFrom(ModelMap model) throws Exception {

		return "chat/lastchat";
	}

	@RequestMapping(value = "/member/memberForm.lol")
	public String memberForm(ModelMap model) throws Exception {
		List<CodeVO> codes = codeService.getCodeListByParent("CN00");
		model.addAttribute("pref", codes);
		return "member/memberForm";
	}

	@RequestMapping(value = "/member/memberRegist.lol")
	public String memberRegist(MemberVO member, ModelMap model) throws Exception {
		try {
			memberService.registMember(member);
			return "redirect:/";
		} catch (BizDuplicateException e) {
			ResultMessageVO message = new ResultMessageVO();
			message.setResult(false).setTitle("회원 가입 실패").setMessage(e.toString()).setUrl("/member/memberForm.lol")
					.setUrlTitle("목록으로");
			model.addAttribute("resultMessage", message);
			return "common/message";

		}

	}

	@RequestMapping(value = "/member/memberEdit.lol")
	public String memberEdit(@RequestParam("memId") String memId, MemberVO member, ModelMap model, HttpSession session, RedirectAttributes redirectAttributes)
			throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		
		MemberVO mem = memberService.getMember(memId);
		model.addAttribute("mem", mem);

		UserVO user = (UserVO) session.getAttribute("USER_INFO");

		List<CodeVO> codes = codeService.getCodeListByParent("CN00");
		model.addAttribute("pref", codes);
		if (mem != null) {
			// 넘어오는 memId와 로그인 되어있는 session id 비교
			if (memId.equals(user.getUserID())) {

				return "member/memberEdit";
			} else {
				map.put("error", "diff");
				map.put("result", false);
				redirectAttributes.addFlashAttribute("message", map);
			}
		}
		return "redirect:/";
	}

	@RequestMapping(value = "/member/memberModify.lol", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> memberModify(MemberVO member, ModelMap model, HttpSession session, RedirectAttributes redirectAttributes) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		
		try {
			List<CodeVO> codes = codeService.getCodeListByParent("CN00");
			model.addAttribute("pref", codes);
			// 정보수정 성공
			map.put("message", "회원정보 수정 성공");
			map.put("user",member.getMemId());
			map.put("result",true);

			memberService.modifyMember(member);
			
			return map;
			
		} catch (BizRegistFailException e) {
			// 비밀번호가 다른경우
			map.put("message", "비밀번호가 다릅니다.");
			map.put("result",false);
			
			return map;			
		}
	}

	@RequestMapping(value = "/member/memberDelete.lol", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> memberDelete(MemberVO member, HttpSession session, ModelMap model,  RedirectAttributes redirectAttributes) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		//ResultMessageVO message = new ResultMessageVO();
		try {
			//회원탈퇴 성공
			memberService.removeMember(member);
			session.invalidate();
			map.put("message", "회원탈퇴 성공");
			map.put("user",member.getMemId());
			map.put("result",true);
			
			return map;
			
		} catch (BizRegistFailException e) {
			map.put("message", "비밀번호가 다릅니다.");
			map.put("result",false);
			
			return map;
		}

	}

}
