package com.yuumilibrary.util;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XmlParsing{
	
	//db6ada1743d81494989b483d48d9c418f4fef4964e259503cfeaa17be955005b
	
	public static String getTagValue(String tag, Element eElement) {
		
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}
	
	public static void main(String[] args) {
		try{

				ConnectDB connectDB = new ConnectDB();
				Connection conn = ConnectDB.getConnection();
				String sql = "insert into library values(?,?,?,?,?,?,?,?)";
			
				
				String url = "http://data4library.kr/api/itemSrch?type=ALL&libCode=125010&authKey=db6ada1743d81494989b483d48d9c418f4fef4964e259503cfeaa17be955005b&pageNo=1&pageSize=200";
				DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
				Document doc = dBuilder.parse(url);
				
				// root tag 
				doc.getDocumentElement().normalize();
				System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
				// 파싱할 tag
				NodeList nList = doc.getElementsByTagName("lib");
				System.out.println("파싱할 리스트 수 : "+ nList.getLength());
				
				for(int temp = 0; temp < nList.getLength(); temp++){
					Node nNode = nList.item(temp);
					if(nNode.getNodeType() == Node.ELEMENT_NODE){
						
						Element eElement = (Element) nNode;
					    PreparedStatement stmt = conn.prepareStatement(sql);
					    stmt.setInt(1, Integer.parseInt(getTagValue("libCode", eElement)));
					    stmt.setString(2, getTagValue("libName", eElement));
					    stmt.setString(3, getTagValue("address", eElement));
					    stmt.setString(4, getTagValue("tel", eElement));
					    stmt.setDouble(5, Double.parseDouble(getTagValue("latitude", eElement)));
					    stmt.setDouble(6, Double.parseDouble(getTagValue("longitude", eElement)));
					    stmt.setString(7, getTagValue("homepage", eElement));
					    stmt.setString(8, getTagValue("operatingTime", eElement));
					    stmt.executeUpdate();
					    System.out.println("sucess to save");

					}	
					
				}

		
		}catch (Exception e) {
			e.printStackTrace();
		}
	
	}	
}
