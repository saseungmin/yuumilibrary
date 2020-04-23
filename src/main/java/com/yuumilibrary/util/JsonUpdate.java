package com.yuumilibrary.util;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class JsonUpdate {
	
	String sql = "update book_detail set BOOK_COUNT = ? where BOOK_ISBN = ?";
	
	
	Connection conn = ConnectDB.getConnection();
	public void JsonUpdateResult(String isbn, String BookCount) throws Exception{

		PreparedStatement stmt = conn.prepareStatement("update book_detail set BOOK_COUNT = ? where BOOK_ISBN = ?");
		int BC=Integer.parseInt(BookCount);
		BC=BC+1;
		String BCString=Integer.toString(BC);
		stmt.setString(1, isbn);
		stmt.setString(2, BCString);
		stmt.executeUpdate();
		System.out.println("update 완료");
		stmt.close();
		
	}

}
