package com.yuumilibrary.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.fasterxml.jackson.annotation.JsonSubTypes.Type;

class WebConnection {
	
	
	final static String serviceKey = "db6ada1743d81494989b483d48d9c418f4fef4964e259503cfeaa17be955005b";

	String json;
	WebConnection(int i) throws Exception{
		String address ="http://data4library.kr/api/itemSrch?type=ALL&libCode=125004&authKey="+serviceKey+"&pageNo="+i+"&pageSize=10&startDt=1900-01-01&endDt=2020-03-20&format=json";
		BufferedReader br;
		URL url;
		HttpURLConnection conn;
		String protocol = "GET";

		url = new URL(address);
		conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod(protocol);
		br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

		json = br.readLine();
		//System.out.println(json);

	}
	
}

public class JsonParsing{
	
	public static void main(String[] args) throws Exception {
		//for(int num=1;num<57;num++) {
						
			WebConnection wc = new WebConnection(1);
			//JsonDataVO dataVO=new JsonDataVO();
			String json = wc.json;
			
			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject)parser.parse(json);
			JSONObject response = (JSONObject)obj.get("response");
			JSONArray docs = (JSONArray)response.get("docs");

//			ConnectDB connectDB = new ConnectDB();
//			Connection conn = ConnectDB.getConnection();
			
			
			
			
			
			
//			String sql = "insert into book_temp values(?,?,?,?,?,?,?,?,?,?,sysdate)";
//
//			
//			PreparedStatement stmt = conn.prepareStatement(sql);
			for(int i=0;i<docs.size();i++){
//				String publication_year=null;
				int idx=1;
				JSONObject tmp = (JSONObject)docs.get(i);
				JSONObject doc = (JSONObject)tmp.get("doc");

				
				
				String isbn13 = (String)doc.get("isbn13");
				String bookname = (String)doc.get("bookname");			
				String authors = (String)doc.get("authors");
				String publisher = (String)doc.get("publisher");
				String publication_year = "" + doc.get("publication_year");

				String bookImageURL = (String)doc.get("bookImageURL");
				String class_no = (String)doc.get("class_no");
				String book_count = (String)doc.get("book_count");
				String loan_count = (String)doc.get("loan_count");
				String reg_date = (String)doc.get("reg_date");
//
//					stmt.setString(idx++, isbn13);
//					stmt.setString(idx++, bookname);
//					stmt.setString(idx++, authors);
//					stmt.setString(idx++, publisher);
//					stmt.setString(idx++, publication_year);
//					stmt.setString(idx++, bookImageURL);
//					stmt.setString(idx++, class_no);
//					stmt.setString(idx++, book_count);
//					stmt.setString(idx++, loan_count);
//					stmt.setString(idx++, reg_date);
//					stmt.executeUpdate();
					



			}
			
//			stmt.close();
			
			
			
		//}
		


		
	}
	
}


