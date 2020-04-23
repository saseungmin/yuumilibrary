package com.yuumilibrary.chat.service;

import java.util.List;
import java.util.Map;

import com.yuumilibrary.chat.vo.ChatMessageVO;
import com.yuumilibrary.club.vo.ClubMemberListVO;
import com.yuumilibrary.common.exception.BizException;

public interface IClubChatService {
	
	public void insertMessage(ChatMessageVO messageVO) throws BizException;
	
	public ClubMemberListVO getMember(Map<String, Object> map) throws BizException;
	
	public List<ChatMessageVO> getMessage(int clubNum) throws BizException;
	
	public ClubMemberListVO getClubCheckMember(ClubMemberListVO memberVO) throws BizException;
	
}
