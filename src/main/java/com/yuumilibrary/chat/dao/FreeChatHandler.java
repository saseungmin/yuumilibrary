package com.yuumilibrary.chat.dao;
 
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.yuumilibrary.chat.vo.ChatMessageVO;
import com.yuumilibrary.chat.vo.ChatUserVO;
import com.yuumilibrary.common.exception.BizNotFoundException;
import com.yuumilibrary.login.vo.UserVO;
import com.yuumilibrary.member.service.IMemberService;
import com.yuumilibrary.member.vo.MemberVO;

@Component
public class FreeChatHandler extends TextWebSocketHandler {
    
	//private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Autowired
	private IMemberService memberService;
	
    private static Logger logger = LoggerFactory.getLogger(FreeChatHandler.class);
	private List<WebSocketSession> connectedUsers;

	public FreeChatHandler() {
	      connectedUsers = new ArrayList<WebSocketSession>();
	   }

	private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	
      // 클라이언트와 연결 이후에 실행되는 메서드
      @Override
      public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	  
    	  logger.info(session.getId() + " 연결 됨!!");
  		  		
  		  users.put(session.getId(), session);
  		  
  		  connectedUsers.add(session);
      }
     
      // 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
      @Override
      protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	  MemberVO member =new MemberVO();
		  Map<String, Object> map = null;
		  ChatMessageVO messageVO = ChatMessageVO.convertMessage(message.getPayload());
        
        
        
        
        for (WebSocketSession websocketSession : connectedUsers) {
        	
        	map = websocketSession.getAttributes();
        	UserVO user = (UserVO)map.get("USER_INFO");
      	  	logger.info("session ============ {}",user);
      	  	
      	  	try {
      	  		member=memberService.getMember(user.getUserID());
      	  		logger.info("member==========={}",member);
			} catch (BizNotFoundException e) {
				
				  websocketSession.sendMessage(new TextMessage("membernull"));
				  websocketSession.close(CloseStatus.NORMAL);
				  
			}
			if(messageVO.getClubUserId().equals(member.getMemId())) {
				
					messageVO.setClubUserImg(member.getMemImg());
					
			}
      	  	
    		Gson gson = new Gson();
            String msgJson = gson.toJson(messageVO);
            websocketSession.sendMessage(new TextMessage(msgJson));
        		
        }
      }
     
      // 클라이언트와 연결을 끊었을 때 실행되는 메소드
      @Override
      public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

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