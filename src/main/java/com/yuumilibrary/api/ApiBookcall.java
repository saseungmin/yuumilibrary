package com.yuumilibrary.api;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.yuumilibrary.bookdetail.vo.BookVO;
import com.yuumilibrary.util.OpenApiJsonParsing;


@Service
public class ApiBookcall implements IApiBookDao{
	
	
	private final Logger logger = LoggerFactory.getLogger(getClass());
	private final static String serviceKey = "db6ada1743d81494989b483d48d9c418f4fef4964e259503cfeaa17be955005b";
	
	@Override
	public List<BookVO> novel() throws Exception{		
		
		String address= "http://data4library.kr/api/loanItemSrch?authKey="+serviceKey+"&startDt=2020-04-13&endDt=2020-04-20&region=25&kdc=8&pageNo=1&pageSize=12&format=json";
		
		OpenApiJsonParsing apiJsonParsing = new OpenApiJsonParsing();
		String json = apiJsonParsing.WebConnection(address);
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject) parser.parse(json);
		JSONObject resp = (JSONObject) obj.get("response");
		JSONArray docs = (JSONArray)resp.get("docs");
		
		List<BookVO> bookRank=new ArrayList<BookVO>();
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
			bookRank.add(book);
			
		}
		return  bookRank;
	}
	
	@Override
	public List<BookVO> history() throws Exception {
		
		
		
		String address= "http://data4library.kr/api/loanItemSrch?authKey="+serviceKey+"&startDt=2020-04-13&endDt=2020-04-20&region=25&kdc=9&pageNo=1&pageSize=12&format=json";
		
		OpenApiJsonParsing apiJsonParsing = new OpenApiJsonParsing();
		String json = apiJsonParsing.WebConnection(address);
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject) parser.parse(json);
		JSONObject resp = (JSONObject) obj.get("response");
		JSONArray docs = (JSONArray)resp.get("docs");
		
		logger.info("docs ========history{}",docs);
		List<BookVO> bookRank=new ArrayList<BookVO>();
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
			bookRank.add(book);
			
		}
		return  bookRank;
	}
	
	@Override
	public List<BookVO> art() throws Exception {
		
		
		String address= "http://data4library.kr/api/loanItemSrch?authKey="+serviceKey+"&startDt=2020-04-13&endDt=2020-04-20&region=25&kdc=6&pageNo=1&pageSize=12&format=json";
		
		OpenApiJsonParsing apiJsonParsing = new OpenApiJsonParsing();
		String json = apiJsonParsing.WebConnection(address);
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject) parser.parse(json);
		JSONObject resp = (JSONObject) obj.get("response");
		JSONArray docs = (JSONArray)resp.get("docs");
		logger.info("docs ========art{}",docs);

		List<BookVO> bookRank=new ArrayList<BookVO>();
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
			bookRank.add(book);
			
		}
		return  bookRank;
		
	}
	
	
	@Override
	public List<BookVO> total() throws Exception {
		
		String address= "http://data4library.kr/api/loanItemSrch?authKey="+serviceKey+"&startDt=2020-04-13&endDt=2020-04-20&region=25&kdc=0&pageNo=1&pageSize=12&format=json";
		
		OpenApiJsonParsing apiJsonParsing = new OpenApiJsonParsing();
		String json = apiJsonParsing.WebConnection(address);
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject) parser.parse(json);
		JSONObject resp = (JSONObject) obj.get("response");
		JSONArray docs = (JSONArray)resp.get("docs");
		logger.info("docs ========art{}",docs);

		List<BookVO> bookRank=new ArrayList<BookVO>();
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
			bookRank.add(book);
			
		}
		return  bookRank;
		
	}

	
	@Override
	public List<BookVO> recommend(String isbn) throws Exception {
		
		String address= "http://data4library.kr/api/recommandList?authKey="+serviceKey+"&isbn13="+isbn+"&&format=json";
		
		OpenApiJsonParsing apiJsonParsing = new OpenApiJsonParsing();
		String json = apiJsonParsing.WebConnection(address);
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject) parser.parse(json);
		JSONObject resp = (JSONObject) obj.get("response");
		JSONArray docs = (JSONArray)resp.get("docs");
		logger.info("docs ========recommend{}",docs);

		List<BookVO> bookRank=new ArrayList<BookVO>();
		BookVO book= null;
		for(int i=0;i<12;i++){
			
			book=new BookVO();
			
			JSONObject tmp = (JSONObject)docs.get(i);
			JSONObject doc = (JSONObject)tmp.get("book");				
			book.setBookNo(""+doc.get("no"));
			book.setBookPublicationYear((String)doc.get("publication_year"));
			book.setBookName((String)doc.get("bookname"));
			book.setBookImageUrl((String)doc.get("bookImageURL"));
			book.setBookIsbn((String)doc.get("isbn13"));
			book.setBookPublisher((String)doc.get("publisher"));
			book.setBookAuthors((String)doc.get("authors"));
			bookRank.add(book);
		}
		return  bookRank;
		
	}
		
}
