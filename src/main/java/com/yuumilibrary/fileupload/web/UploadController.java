package com.yuumilibrary.fileupload.web;

import java.io.File;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.yuumilibrary.login.vo.UserVO;
import com.yuumilibrary.member.service.IMemberService;
import com.yuumilibrary.member.vo.MemberVO;

@Controller
public class UploadController {
	
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
	
	@Autowired 
	private IMemberService memberService;
	
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@RequestMapping(value = "/uploadForm", method = RequestMethod.GET)
	public void uploadForm() throws Exception{
		
	}
	
	@RequestMapping(value = "/uploadForm", method = RequestMethod.POST)
	public ModelAndView uploadForm(MultipartFile file, ModelAndView mav, MemberVO member, HttpSession session) throws Exception{
		
		logger.info("originalName "+ file.getOriginalFilename());
		logger.info("size: "+file.getSize());
		logger.info("contentType: "+file.getContentType());
		UserVO user=(UserVO)session.getAttribute("USER_INFO");
		
		String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
		member.setMemId(user.getUserID());
		member.setMemImg(savedName);
		memberService.UpdateMemberImg(member);				
		logger.info("저장되는 이름 : "+savedName);
		mav.setViewName("member/memberView");
		mav.addObject("savedName", savedName);
		
		return mav;
		
	}
	
	
	private String uploadFile(String originalName, byte [] fileData) throws Exception{
		
		
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString()+ "-" + originalName;
		File target = new File(uploadPath, savedName);
		FileCopyUtils.copy(fileData, target);
		
		return savedName;
	}

}
