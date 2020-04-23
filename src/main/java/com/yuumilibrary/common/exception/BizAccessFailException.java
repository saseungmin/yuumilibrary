package com.yuumilibrary.common.exception;

//중복키 에러
public class BizAccessFailException extends BizException{

	private static final long serialVersionUID = 5535662152314240104L;


	public BizAccessFailException() {
		super();
	}

	public BizAccessFailException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public BizAccessFailException(String message, Throwable cause) {
		super(message, cause);
	}

	public BizAccessFailException(String message) {
		super(message);
	}

	public BizAccessFailException(Throwable cause) {
		super(cause);
	}

}
