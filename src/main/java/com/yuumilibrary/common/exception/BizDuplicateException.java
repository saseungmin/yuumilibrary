package com.yuumilibrary.common.exception;

//중복키 에러
public class BizDuplicateException extends BizException{

	private static final long serialVersionUID = 5535662152314240104L;


	public BizDuplicateException() {
		super();
	}

	public BizDuplicateException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public BizDuplicateException(String message, Throwable cause) {
		super(message, cause);
	}

	public BizDuplicateException(String message) {
		super(message);
	}

	public BizDuplicateException(Throwable cause) {
		super(cause);
	}

}
