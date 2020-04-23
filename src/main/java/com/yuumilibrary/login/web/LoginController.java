package com.yuumilibrary.login.web;


import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;
import com.yuumilibrary.common.exception.BizRegistFailException;
import com.yuumilibrary.common.vo.ResultMessageVO;
import com.yuumilibrary.login.vo.UserVO;
import com.yuumilibrary.member.service.IMemberService;
import com.yuumilibrary.member.vo.MemberVO;
import com.yuumilibrary.rsa.RSAsss;
import com.yuumilibrary.rsa.SHA256Util;
import com.yuumilibrary.util.CookieBox;


@Controller
public class LoginController {
	
	@Autowired
	private IMemberService memberservice;
	
	

	@RequestMapping(value = "/login/login.lol",method = RequestMethod.GET)
	public String login() throws Exception{
		return "login/login";
	}
	
	@RequestMapping(value = "/login/login.lol",method = RequestMethod.POST)
	public String loginPost(HttpSession session,HttpServletRequest req, ModelMap model, MemberVO member, RedirectAttributes redirectAttributes) throws Exception{
		
		Map<String, Object> map = new HashMap<String,Object>();

		
		try {
			
			MemberVO mem = memberservice.getMember(member.getMemId());
			// 암호화 return 값 가져오기	
			//return 값중 publicKey
			
			String salt=mem.getMemSalt();
			String myPrivateKey=mem.getMemPrivateKey();
			
			String decodeSalt=RSAsss.decode(salt, myPrivateKey);
			
			String userSalt=SHA256Util.getEncrypt(member.getMemPass(), decodeSalt);

			// 사용자 입력 비밀번호 = publicKey와 비교
			
			if (mem.getMemPass().equals(userSalt)) {		
				UserVO vo = new UserVO();
				vo.setUserID(mem.getMemId());
				vo.setUserName(mem.getMemName());
				vo.setUserPass(mem.getMemPass());
				// top-menu 권한부여 시 가져올 값
				if(mem.getMemRank().equals("관리자")) {
					vo.setUserRole("관리자"); // ADMIN,MANAGER,MEMBER
				} else {
					vo.setUserRole("회원");
				}
			
				session.setAttribute("USER_INFO", vo);
				// resp.sendRedirect(req.getContextPath()+"/");
				return "redirect:/";
			} else {
				// 비번 오류
				map.put("error", "pass");
				map.put("result",false);
				redirectAttributes.addFlashAttribute("message", map);
				
				return "redirect:/login/login.lol";
			}
		} catch (BizException e) {
			// 아이디가 없거나 회원이 아님.
			map.put("error", "membernull");
			map.put("result",false);
			redirectAttributes.addFlashAttribute("message", map);
			
			return "redirect:/login/login.lol";
		}

		
	}
	
	@RequestMapping("/login/logout.lol")
	public String logout(HttpSession session, ModelMap model) throws Exception{
		//loginservice.logout(user); 로그아웃관련 기록 등  
		session.invalidate();
		return "redirect:/";
		}
	}