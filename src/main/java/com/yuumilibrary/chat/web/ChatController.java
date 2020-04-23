package com.yuumilibrary.chat.web;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ibm.cloud.sdk.core.security.IamAuthenticator;
import com.ibm.watson.assistant.v2.Assistant;
import com.ibm.watson.assistant.v2.model.CreateSessionOptions;
import com.ibm.watson.assistant.v2.model.DeleteSessionOptions;
import com.ibm.watson.assistant.v2.model.MessageInput;
import com.ibm.watson.assistant.v2.model.MessageOptions;
import com.ibm.watson.assistant.v2.model.MessageResponse;
import com.ibm.watson.assistant.v2.model.SessionResponse;
import com.yuumilibrary.chat.vo.ChatBotVO;


@Controller
public class ChatController {
	
	
	private final Logger logger=LoggerFactory.getLogger(getClass());

	
	String assistantId = "5e052876-2ab0-40de-9967-2bb2a8dd8677";
	SessionResponse responseSession;
	
	Assistant assistant;
	
	@RequestMapping(value = "chat/chatForm" ,produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> chatForm(ChatBotVO chatbot,ModelMap model) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		IamAuthenticator authenticator = new IamAuthenticator("kE-4GtAzf5EdKCXbpdgOKZGZvWHsQEIdum_KZT_j0tAa");
		assistant = new Assistant("2020-03-27", authenticator);
		assistant.setServiceUrl("https://api.kr-seo.assistant.watson.cloud.ibm.com/instances/39281d1d-6833-4321-8573-bbd921728761");
		
		CreateSessionOptions creatOptions = new CreateSessionOptions.Builder(assistantId).build();

		responseSession = assistant.createSession(creatOptions).execute().getResult();

		logger.info("session id: "+responseSession);
		
		MessageInput input = new MessageInput.Builder()
				  .messageType("text")
				  .text(chatbot.getMessage())
				  .build();
		chatbot.setSessionId(responseSession.getSessionId());
		MessageOptions options = new MessageOptions.Builder(assistantId, responseSession.getSessionId())
				  .input(input)
				  .build();
		
		MessageResponse response = assistant.message(options).execute().getResult();


		String json;
		json = response.getOutput().getGeneric().toString();
		JSONParser parser = new JSONParser();
		JSONArray arr = (JSONArray)parser.parse(json);
		JSONObject text = (JSONObject)arr.get(0);
		map.put("result", true);
		map.put("msg", text);
		map.put("input",chatbot.getMessage());
		return map;
			
	}
	
	
	@RequestMapping(value = "chat/chatText" ,produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> chatText(ChatBotVO chatbot,ModelMap model) throws Exception {

		
		Map<String, Object> map=new HashMap<String, Object>();
		
		MessageInput input = new MessageInput.Builder()
				  .messageType("text")
				  .text(chatbot.getMessage())
				  .build();
		MessageOptions options = new MessageOptions.Builder(assistantId, responseSession.getSessionId())
				  .input(input)
				  .build();		
		MessageResponse response = assistant.message(options).execute().getResult();

		String jsonIntents=response.getOutput().getIntents().toString();
		String jsonGener = response.getOutput().getGeneric().toString();

		JSONParser parser = new JSONParser();
		JSONArray arrGener = (JSONArray)parser.parse(jsonGener);
		JSONObject text = (JSONObject)arrGener.get(0);
		if(jsonIntents!="[]") {
			JSONArray arrInt = (JSONArray)parser.parse(jsonIntents);
			JSONObject textIntents = (JSONObject)arrInt.get(0);
			map.put("msgCata",textIntents);
		}else {
			map.put("msgCata","");
		}
		map.put("result", true);
		map.put("msg", text);
		map.put("input",chatbot.getMessage());
		return map;
			
	}
	
	@RequestMapping(value = "chat/chatClose" ,produces="application/json; charset=UTF-8")
	@ResponseBody
	public void chatClose(ChatBotVO chatbot,ModelMap model) throws Exception {
		
		
		logger.info("close session"+responseSession.getSessionId());
		DeleteSessionOptions options = new DeleteSessionOptions
				.Builder(assistantId, responseSession.getSessionId())
				.build();

		assistant.deleteSession(options).execute();

		
	}
	
	
	
	
}
