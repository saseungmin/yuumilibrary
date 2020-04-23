package com.yuumilibrary.util;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class CookieBox {

private Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
	
	public CookieBox(HttpServletRequest req) {
		Cookie[] cookies = req.getCookies();
		if(cookies != null) {
			for(Cookie c : cookies) {
				cookieMap.put(c.getName(), c);
			}
		}
	}
	public Cookie getCookie(String name) {
		return cookieMap.get(name);
	}
	public String getValue(String name) throws IOException {
		Cookie c = cookieMap.get(name);
		if(c == null) return null;
		return URLDecoder.decode(c.getValue(), "utf-8");
	}
	
	
	public static Cookie createCookie(String name, String value) throws IOException {
		return createCookie(name, value, "", "/", -1);
	}
	
	public static Cookie createCookie(String name, String value, String path, int maxAge) throws IOException {
		return createCookie(name, value, "", path, maxAge);
	}
	
	public static Cookie createCookie(String name, String value, String domain, String path, int maxAge) throws IOException {
		Cookie c = new Cookie(name, URLEncoder.encode(value, "utf-8"));
		c.setDomain(domain);
		c.setPath(path);
		c.setMaxAge(maxAge);
		return c;
	}
}
