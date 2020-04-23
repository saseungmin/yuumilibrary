package com.yuumilibrary.util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConnectDB {
    static Connection conn = null;
   
 public ConnectDB(){
     try {
      System.out.println("try : get connection");
      Class.forName("oracle.jdbc.driver.OracleDriver");
         conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "team", "team");
         System.out.println("success !");
     } catch (SQLException e) {} catch (ClassNotFoundException e) {
   e.printStackTrace();
  }
 }
 
 public static Connection getConnection(){
  return conn;
 }
} 
