package com.yuumilibrary.api.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuumilibrary.bookdetail.vo.BookVO;
import com.yuumilibrary.fileupload.web.UploadController;
import com.yuumilibrary.util.OpenApiJsonParsing;


@Controller
public class ApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);

	private final static String serviceKey = "db6ada1743d81494989b483d48d9c418f4fef4964e259503cfeaa17be955005b";
	
	
	@RequestMapping(value="/index/bestbook",method=RequestMethod.POST)
	@ResponseBody
	public List<BookVO> bestbook(ModelMap model) throws Exception {
		
		String address = "http://data4library.kr/api/loanItemSrch?authKey="+serviceKey
						+ "&startDt=2020-03-01&endDt=2020-03-31&pageNo=1&pageSize=5&format=json";
		
		OpenApiJsonParsing apiJsonParsing =new OpenApiJsonParsing();
		String json = apiJsonParsing.WebConnection(address);
		
		
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject)parser.parse(json);
		JSONObject response = (JSONObject)obj.get("response");
		JSONArray docs = (JSONArray)response.get("docs");
		
		List<BookVO> list=new ArrayList<BookVO>();
		BookVO book= null;
		for(int i=0;i<docs.size();i++){
			
			book=new BookVO();
			
			JSONObject tmp = (JSONObject)docs.get(i);
			JSONObject doc = (JSONObject)tmp.get("doc");				
			book.setBookNo(""+doc.get("no"));
			book.setBookPublicationYear((String)doc.get("publication_year"));
			book.setBookName((String)doc.get("bookname"));
			book.setBookImageUrl((String)doc.get("bookImageURL"));
			book.setBookIsbn((String)doc.get("isbn13"));
			book.setBookPublisher((String)doc.get("publisher"));
			book.setBookRanking((String)doc.get("ranking"));
			book.setBookAuthors((String)doc.get("authors"));
			list.add(book);
			
		}
		return list;
	}
	
	
	
	@RequestMapping(value="/index/upbook",method=RequestMethod.POST)
	@ResponseBody
	public List<BookVO> upbook(ModelMap model) throws Exception {
		
		Calendar cal = Calendar.getInstance();
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		cal.add(cal.DATE, -2); // 7일(일주일)을 뺀다
		String dateStr = format.format(cal.getTime());
		
		logger.info("오늘 날짜 2일전=========={}",dateStr);
		
		
		String address = "http://data4library.kr/api/hotTrend?authKey="+serviceKey+"&searchDt="+dateStr+"&format=json";
		
		
		
		
		OpenApiJsonParsing apiJsonParsing =new OpenApiJsonParsing();
		String json = apiJsonParsing.WebConnection(address);
		
		
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject)parser.parse(json);
		JSONObject response = (JSONObject)obj.get("response");
		JSONArray results = (JSONArray)response.get("results");
		JSONObject result = (JSONObject)results.get(0);
		JSONObject resultF = (JSONObject)result.get("result");
		JSONArray docs = (JSONArray)resultF.get("docs");
		List<BookVO> list=new ArrayList<BookVO>();
		BookVO book= null;
		for(int i=0;i<docs.size();i++){
			
			book=new BookVO();
			
			JSONObject tmp = (JSONObject)docs.get(i);
			JSONObject doc = (JSONObject)tmp.get("doc");	
			
			book.setBookNo(""+doc.get("no"));
			book.setBookDifference(""+doc.get("difference"));
			book.setBookBaseWeekRank(""+doc.get("baseWeekRank"));
			book.setBookPastWeekRank(""+doc.get("pastWeekRank"));
			book.setBookPublicationYear((String)doc.get("publication_year"));
			book.setBookName((String)doc.get("bookname"));
			book.setBookImageUrl((String)doc.get("bookImageURL"));
			book.setBookIsbn((String)doc.get("isbn13"));
			book.setBookPublisher((String)doc.get("publisher"));
			book.setBookAuthors((String)doc.get("authors"));
			list.add(book);
			
		}
		return list;
	}
	
	
}
