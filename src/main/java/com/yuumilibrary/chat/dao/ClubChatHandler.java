package com.yuumilibrary.chat.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.yuumilibrary.chat.service.IClubChatService;
import com.yuumilibrary.chat.vo.ChatMessageVO;
import com.yuumilibrary.club.service.IClubMemberService;
import com.yuumilibrary.club.vo.ClubMemberListVO;
import com.yuumilibrary.club.vo.ClubVO;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;
import com.yuumilibrary.login.vo.UserVO;
import com.yuumilibrary.member.service.IMemberService;
import com.yuumilibrary.member.vo.MemberVO;

@Component
public class ClubChatHandler extends TextWebSocketHandler {

    
	@Autowired
	private IClubChatService chatService;
	
	@Autowired
	private IClubMemberService clubMemberService;
	
	
	//private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
    private static Logger logger = LoggerFactory.getLogger(FreeChatHandler.class);
	private List<WebSocketSession> connectedUsers;

	public ClubChatHandler() {
	      connectedUsers = new ArrayList<WebSocketSession>();
	   }

	private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	
      // 클라이언트와 연결 이후에 실행되는 메서드
      @Override
      public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	  
    	  logger.info(session.getId() + " 연결 됨!!");
  		  		
  		  users.put(session.getId(), session);
  		  
  		  logger.info("users========={}",users);
  		  connectedUsers.add(session);
  		  logger.info("connnnn====={}",connectedUsers);
      }
     
      // 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
      @Override
      protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	  
    	  ClubMemberListVO member= new ClubMemberListVO();

    	  ClubVO club = new ClubVO();
		  Map<String, Object> map;
		  Map<String, Object> getuserMap;
		  ChatMessageVO messageVO = ChatMessageVO.convertMessage(message.getPayload());
		  
		  
		  logger.info("message======{}",messageVO);

		  
		try {
			
			club = clubMemberService.getClub(messageVO.getClubRoomNum());
			messageVO.setClubRoomName(club.getBkClubName());
			chatService.insertMessage(messageVO);
			member = clubMemberService.getClubMessage(messageVO);
			
			messageVO.setClubUserImg(member.getCmMemImg());
			
		} catch (BizException e) {
			logger.error("insertException : ========={}",e);
		}

          for (WebSocketSession websocketSession : connectedUsers) {
        	  map = new HashMap<String, Object>();
        	  getuserMap = new HashMap<String, Object>();
        	  member = new ClubMemberListVO();
        	  map = websocketSession.getAttributes();
        	  UserVO user = (UserVO)map.get("USER_INFO");
        	  logger.info("session ============ {}",user);
        	
        	  
			try {
	        	  if(user ==null) {
					  websocketSession.sendMessage(new TextMessage("login"));
					  websocketSession.close(CloseStatus.NORMAL);
					  break;
	        	  }else {
	        		  getuserMap.put("memId", user.getUserID());
	        		  getuserMap.put("cmNum",club.getBkNum());
	        		  
					  member = chatService.getMember(getuserMap);
		        	  logger.info("member==========={}",member);
		        	  
		        		  
		        		  if(member.getCmNum() == club.getBkNum()) {
		        			  
		        			  Gson gson = new Gson();
		        			  String msgJson = gson.toJson(messageVO);
		        			  logger.info("sendmessage============{}",msgJson);
		        			  websocketSession.sendMessage(new TextMessage(msgJson));
		        			  
		        			  
		        		  }
	        		  
	        	  }
				
				
			} catch (BizNotFoundException e) {
				websocketSession.sendMessage(new TextMessage("membernull"));
			    websocketSession.close(CloseStatus.NORMAL);
				break;

			}	
        	  //websocketSession.sendMessage(new TextMessage(session.getId() + " : " + message.getPayload()));
          }
      }
     
      // 클라이언트와 연결을 끊었을 때 실행되는 메소드
      @Override
      public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//        sessionList.remove(session);
//        System.out.println(("{} 연결 끊김"+ session.getId()));
  		logger.info(session.getId() + " 연결 종료됨");
  		connectedUsers.remove(session);
  		users.remove(session.getId());
  		
  		
      }
      
  	@Override
  	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
  		log(session.getId() + " 익셉션 발생: " + exception.getMessage());
  	}
  	private void log(String logmsg) {
  		logger.error(new Date() + " : " + logmsg);
  	}

      
      
}
