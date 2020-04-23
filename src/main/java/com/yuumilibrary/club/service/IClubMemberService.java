package com.yuumilibrary.club.service;

import java.util.List;
import java.util.Map;

import org.eclipse.osgi.internal.messages.Msg;

import com.yuumilibrary.chat.vo.ChatMessageVO;
import com.yuumilibrary.club.vo.ClubMemberListVO;
import com.yuumilibrary.club.vo.ClubSearchVO;
import com.yuumilibrary.club.vo.ClubVO;

public interface IClubMemberService {

	public List<ClubVO> getClubList(ClubSearchVO searchVO) throws Exception;
	
	public ClubVO getClub(int bkNum) throws Exception;
	
	// 클럽을 만듬
	public void registClub(ClubVO clubVO) throws Exception;

	// 클럽 정보수정
	public void modifyClub(ClubVO clubVO) throws Exception;

	// 클럽 지움
	public void removeClub(ClubVO clubVO) throws Exception;

	
	public List<ClubMemberListVO> getClubMemberList(ClubMemberListVO clubListVO) throws Exception;
	
	public List<ClubMemberListVO> getClubMember(Map<Object, Object> map) throws Exception;
	
	public ClubMemberListVO getClubMessage(ChatMessageVO message) throws Exception;
	
	public void registMember(ClubMemberListVO clubListVO) throws Exception;
	  
	public void registMemberConfirm(Map<String, Object> map) throws Exception;
	
	public void withdrawMember(Map<String, Object> map) throws Exception;
	
	public List<ClubMemberListVO> getClubChatMember(int clubNum) throws Exception;

}
