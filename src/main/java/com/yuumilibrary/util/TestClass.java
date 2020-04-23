package com.yuumilibrary.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class TestClass {

	final static String serviceKey = "db6ada1743d81494989b483d48d9c418f4fef4964e259503cfeaa17be955005b";
	static String json;

	public static void main(String[] args) {
		String isbn = "9788992351744";
		String address = "http://data4library.kr/api/srchDtlList?authKey=" + serviceKey + "&isbn13=" + isbn
				+ "&loaninfoYN=Y&displayInfo=age&format=json";
		BufferedReader br;
		URL url;
		HttpURLConnection conn;
		String protocol = "GET";

		try {
			url = new URL(address);
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod(protocol);
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			json = br.readLine();
			
//			System.out.println(json);
			
			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject) parser.parse(json);
			System.out.println(obj);
			
			JSONObject resp = (JSONObject) obj.get("response");
			System.out.println(resp);
			
			JSONArray info = (JSONArray) resp.get("detail");
			System.out.println(info);
			
			JSONObject arr= (JSONObject) info.get(0);
			System.out.println(arr);
			
			JSONObject res = (JSONObject) arr.get("book");
			System.out.println(res);
			
			String des = (String)res.get("description");
			System.out.println(des);
			
			
			
		} catch (Exception e) {
			System.out.println("ERRORR!!@!!@#!");
		}
	

	}
}
