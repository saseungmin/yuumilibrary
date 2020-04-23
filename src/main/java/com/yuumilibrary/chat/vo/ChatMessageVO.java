package com.yuumilibrary.chat.vo;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.google.gson.Gson;

public class ChatMessageVO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String clubUserId;
	private String clubMessageContent;
	private String clubMessageSendtime;
	private int clubRoomNum;
	private String clubRoomName;
	private String clubUserImg;
	private String clubMessageSenddate;

	
	

	
	public static ChatMessageVO convertMessage(String source) {
		ChatMessageVO message = new ChatMessageVO();
		Gson gson = new Gson();
		message = gson.fromJson(source,  ChatMessageVO.class);
		return message;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);

	}


	
	
	public String getClubUserId() {
		return clubUserId;
	}

	public void setClubUserId(String clubUserId) {
		this.clubUserId = clubUserId;
	}

	public String getClubMessageContent() {
		return clubMessageContent;
	}

	public void setClubMessageContent(String clubMessageContent) {
		this.clubMessageContent = clubMessageContent;
	}

	public String getClubMessageSendtime() {
		return clubMessageSendtime;
	}

	public void setClubMessageSendtime(String clubMessageSendtime) {
		this.clubMessageSendtime = clubMessageSendtime;
	}

	public int getClubRoomNum() {
		return clubRoomNum;
	}

	public void setClubRoomNum(int clubRoomNum) {
		this.clubRoomNum = clubRoomNum;
	}

	public String getClubRoomName() {
		return clubRoomName;
	}

	public void setClubRoomName(String clubRoomName) {
		this.clubRoomName = clubRoomName;
	}

	public String getClubUserImg() {
		return clubUserImg;
	}

	public void setClubUserImg(String clubUserImg) {
		this.clubUserImg = clubUserImg;
	}

	public String getClubMessageSenddate() {
		return clubMessageSenddate;
	}

	public void setClubMessageSenddate(String clubMessageSenddate) {
		this.clubMessageSenddate = clubMessageSenddate;
	}
	
}