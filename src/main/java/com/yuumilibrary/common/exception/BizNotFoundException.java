package com.yuumilibrary.common.exception;

//중복키 에러
public class BizNotFoundException extends BizException{

	private static final long serialVersionUID = 5535662152314240104L;

	private String key;
	
	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}
	public BizNotFoundException(String message, String key) {
		super(message+",key"+key);
		this.key=key;
	}

	public BizNotFoundException() {
		super();
	}

	public BizNotFoundException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public BizNotFoundException(String message, Throwable cause) {
		super(message, cause);
	}

	public BizNotFoundException(String message) {
		super(message);
	}

	public BizNotFoundException(Throwable cause) {
		super(cause);
	}

}
