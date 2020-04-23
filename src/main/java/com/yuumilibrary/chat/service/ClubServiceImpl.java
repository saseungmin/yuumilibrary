package com.yuumilibrary.chat.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuumilibrary.chat.dao.IChatDAO;
import com.yuumilibrary.chat.vo.ChatMessageVO;
import com.yuumilibrary.club.vo.ClubMemberListVO;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;

@Service
public class ClubServiceImpl implements IClubChatService{

	@Autowired
	private IChatDAO chatDao;
	
	@Override
	public void insertMessage(ChatMessageVO messageVO) throws BizException {
		
		try {
			chatDao.insertMessage(messageVO);
		} catch (BizException e) {
			throw new BizException(e);
		}
		
	}

	@Override
	public ClubMemberListVO getMember(Map<String, Object> map) throws BizException {
		
		ClubMemberListVO member = chatDao.getChatMember(map);
		if(member ==null) {
			throw new BizNotFoundException();
		}
		return member;
	}

	@Override
	public List<ChatMessageVO> getMessage(int clubNum) throws BizException {
		
		return chatDao.getMessage(clubNum);
	}

	@Override
	public ClubMemberListVO getClubCheckMember(ClubMemberListVO memberVO) throws BizException {
		
		ClubMemberListVO member =chatDao.getClubCheckMember(memberVO);
		if(member == null) {
			throw new BizNotFoundException();
		}
		
		return member;
	}

	
	
}
