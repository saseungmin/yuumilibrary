package com.yuumilibrary.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JsonSelect {
	
	String sql = "select book_name from book_detail where book_isbn=?";
	
	ConnectDB connectDB = new ConnectDB();
	Connection conn = ConnectDB.getConnection();
	
	public String JsonSelectResult(String isbn) throws Exception{
		if(isbn==null) {
			return null;
		}
		ResultSet rs=null;
		PreparedStatement stmt = conn.prepareStatement(sql);
		String BookName=null;
		stmt.setString(1, isbn);
		rs=stmt.executeQuery();
		if (rs.next()) {
			BookName=rs.getString("book_name");
			
		}
		stmt.close();
		return BookName;
	}
}
