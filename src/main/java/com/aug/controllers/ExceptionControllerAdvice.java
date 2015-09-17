package com.aug.controllers;

import java.io.IOException;
import java.sql.SQLException;

import javassist.tools.web.BadHttpRequest;

import javax.servlet.http.HttpServletResponse;

import org.hibernate.exception.ConstraintViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class ExceptionControllerAdvice {
	//BAD_REQUEST(400, "Bad Request")
	//NOT_FOUND(404, "Not Found")
	//UNSUPPORTED_MEDIA_TYPE(415, "Unsupported Media Type")
	//INTERNAL_SERVER_ERROR(500, "Internal Server Error")


	//BAD_REQUEST(400, "Bad Request")
	@ExceptionHandler(BadHttpRequest.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	@ResponseBody
	public ExceptionVO handleBadRequest(BadHttpRequest ex,
			HttpServletResponse response) throws IOException {
		System.out.println("Exception : BAD_REQUEST");
		System.out.println(ex.getMessage()+" "+ex.getClass().getSimpleName());
		ExceptionVO exceptionVO = new ExceptionVO("");
		return exceptionVO;
	}
	
	//NOT_FOUND(404, "Not Found")
	@ExceptionHandler(NotFoundException.class)
	@ResponseStatus(value=HttpStatus.NOT_FOUND)
	@ResponseBody
	public ExceptionVO handleNotFoundException(NotFoundException ex,
			HttpServletResponse response) throws IOException {
		System.out.println("Exception :  NOT FOUND");
		System.out.println(ex.getMessage()+" "+ex.getClass().getSimpleName());
		ExceptionVO exceptionVO = new ExceptionVO(" ");
		return exceptionVO;
	}
	
	//UNSUPPORTED_MEDIA_TYPE(415, "Unsupported Media Type")
		@ExceptionHandler(HttpMediaTypeNotSupportedException.class)
		@ResponseStatus(value=HttpStatus.UNSUPPORTED_MEDIA_TYPE)
		@ResponseBody
		public ExceptionVO handleHttpMediaTypeNotSupportedException(
				HttpMediaTypeNotSupportedException ex,
				HttpServletResponse response) throws IOException {
			ExceptionVO exceptionVO = new ExceptionVO("");
			System.out.println("Exception : UNSUPPORTED_MEDIA_TYPE");
			System.out.println(ex.getMessage()+" "+ex.getClass().getSimpleName());
			return exceptionVO;
		} 

	//INTERNAL_SERVER_ERROR(500, "Internal Server Error")
	//ConstraintViolationException
	@ExceptionHandler(ConstraintViolationException.class)
	@ResponseStatus(value=HttpStatus.INTERNAL_SERVER_ERROR)
	@ResponseBody
	public ExceptionVO handleViolationException(ConstraintViolationException ex,
			HttpServletResponse response) throws IOException {
		ExceptionVO exceptionVO = new ExceptionVO("");
		System.out.println("Exception : INTERNAL_SERVER_ERROR");
		System.out.println(ex.getMessage()+" "+ex.getClass().getSimpleName());
		return exceptionVO;
	}

	
	//INTERNAL_SERVER_ERROR(500, "Internal Server Error")
	//SQLException
	@ExceptionHandler(SQLException.class)
	@ResponseStatus(value=HttpStatus.INTERNAL_SERVER_ERROR)
	@ResponseBody
	public ExceptionVO handleSQLException(SQLException ex,
			HttpServletResponse response) throws IOException {
		ExceptionVO exceptionVO = new ExceptionVO("");
		System.out.println("Exception : INTERNAL_SERVER_ERROR");
		System.out.println(ex.getMessage()+" "+ex.getClass().getSimpleName());
		return exceptionVO;
	}

	// Custom
	// Exception
/*	@ExceptionHandler(Exception.class)
	@ResponseBody
	public ExceptionVO handleException(Exception ex,
			HttpServletResponse response) throws IOException {
		System.out.println("Exception :  EXCEPTION");
		System.out.println(ex.getMessage());
		ExceptionVO exceptionVO = new ExceptionVO(" ");
		return exceptionVO;
	}*/
	

}
