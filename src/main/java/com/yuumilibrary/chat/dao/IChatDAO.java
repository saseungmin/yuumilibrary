package com.yuumilibrary.chat.dao;


import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.yuumilibrary.chat.vo.ChatMessageVO;
import com.yuumilibrary.chat.vo.ChatRoomVO;
import com.yuumilibrary.club.vo.ClubMemberListVO;

@Mapper
public interface IChatDAO {
	
	
	public void insertMessage(ChatMessageVO messageVO);
	
	public ClubMemberListVO getChatMember(Map<String, Object> map);
	
	public List<ChatMessageVO> getMessage(int clubNum);

	public ClubMemberListVO getClubCheckMember(ClubMemberListVO memberVO);

//	public void createRoom(ChatRoomVO vo)throws SQLException;
//	public ChatRoomVO isRoom(ChatRoomVO vo)throws SQLException;
//	public void insertMessage(ChatMessageVO vo)throws SQLException;
//	public String getPartner(ChatRoomVO vo)throws SQLException;
//	public String getProfile(String str)throws SQLException;
//	public String getName(String str)throws SQLException;
//	public List<ChatMessageVO> getMessageList(String str)throws SQLException;
//	public List<ChatRoomVO> getRoomList(String str)throws SQLException;
//	public List<ChatRoomVO> getRoomList2(String str)throws SQLException;
//	public ChatMessageVO getRecentMessage(String str)throws SQLException;
//	public String isGetMessageList(String str)throws Exception;
//	
//	public String getTutorId(String str)throws SQLException;
//	public List<ChatRoomVO> getRoomListTutor(String str)throws SQLException;
//	public void updateReadTime(int class_id , String user_id , String TUTOR_USER_user_id)throws SQLException;
//	public void updateReadTimeTutor(int class_id , String user_id , String TUTOR_USER_user_id)throws SQLException;
//	
//	public int getUnReadCount(String TUTOR_USER_user_id, int class_id, String user_id)throws SQLException;
//	public int getUnReadCountTutor(String TUTOR_USER_user_id, int class_id, String user_id)throws SQLException;
//	
//	public int getAllCount(String str) throws SQLException;
	
}