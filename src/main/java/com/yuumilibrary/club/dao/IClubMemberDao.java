package com.yuumilibrary.club.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.yuumilibrary.chat.vo.ChatMessageVO;
import com.yuumilibrary.club.vo.ClubMemberListVO;
import com.yuumilibrary.club.vo.ClubSearchVO;
import com.yuumilibrary.club.vo.ClubVO;

@Mapper
public interface IClubMemberDao {

	// 아래 3개의 기능은 클럽마스터가 할수있따 ^^
	public int getClubCount(ClubSearchVO searchVO) throws Exception;
	
	public List<ClubVO> getClubList(ClubSearchVO searchVO) throws Exception;
	
	public ClubVO getClub(int bkNum) throws Exception;
	
	// 클럽을 만듬
	public int registClub(ClubVO clubVO) throws Exception;
	
	// 클럽 지움
	public int deleteClub(ClubVO clubVO) throws Exception;

	// 클럽 정보수정
	public int modifyClub(ClubVO clubVO) throws Exception;

	
	// 밑에는 회원이 클럽가입신청 등등...
	public List<ClubMemberListVO> getClubMemberList(ClubMemberListVO clubListVO) ;
	
	public List<ClubMemberListVO> getClubMember(Map<Object, Object> map) throws Exception;
	
	public int registMember(ClubMemberListVO clubListVO) throws Exception;
	
	public int registClubCap(ClubVO clubVO) throws Exception;
	  
	public int registMemberConfirm(Map<String, Object> map) throws Exception;
	  
	public int withdrawMember(Map<String, Object> map) throws Exception;	
	
	
	public List<ClubMemberListVO> getClubChatMember(int clubNum);	

	public ClubMemberListVO getChatMessage(ChatMessageVO messageVO) throws Exception;
	
	 
}
