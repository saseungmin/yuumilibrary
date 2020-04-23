package com.yuumilibrary.common.exception;

//중복키 에러
public class BizRegistFailException extends BizException{

	private static final long serialVersionUID = 5535662152314240104L;

	private String key;
	
	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}
	public BizRegistFailException(String message, String key) {
		super(message+",key"+key);
		this.key=key;
	}

	public BizRegistFailException() {
		super();
	}

	public BizRegistFailException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public BizRegistFailException(String message, Throwable cause) {
		super(message, cause);
	}

	public BizRegistFailException(String message) {
		super(message);
	}

	public BizRegistFailException(Throwable cause) {
		super(cause);
	}

}
