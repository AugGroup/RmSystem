package com.aug.controllers;

import java.io.Serializable;

@SuppressWarnings("serial")
public class ExceptionVO implements Serializable {
	private String code;
	private String message;

	public ExceptionVO(String message) {
		this.message = message;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}
