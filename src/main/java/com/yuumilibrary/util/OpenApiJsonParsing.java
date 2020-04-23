package com.yuumilibrary.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.yuumilibrary.fileupload.web.UploadController;

public class OpenApiJsonParsing {
	
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
		
	public String WebConnection(String address) throws Exception{	
		/*
		 * String address
		 * ="http://data4library.kr/api/itemSrch?type=ALL&libCode=125004&authKey="+
		 * serviceKey+"&pageNo="+i+
		 * "&pageSize=3000&startDt=1900-01-01&endDt=2020-03-20&format=json";
		 */
		String protocol = "GET";

		URL url = new URL(address);
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod(protocol);
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

		String json = br.readLine();
		
		logger.info("JSON PARSING DATA ======================{}",json);
		return json;
		
	}
	
	
}
