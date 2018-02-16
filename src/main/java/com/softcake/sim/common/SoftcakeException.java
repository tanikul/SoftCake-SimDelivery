package com.softcake.sim.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import com.fasterxml.jackson.databind.ObjectMapper;

public class SoftcakeException extends Exception {

	private static final long serialVersionUID = 2829144375410201875L;
	private Timestamp timestamp;
	private int status;
	private String error;
	private String exception;
	private String message;
	private String path;
	private String errorLevel;
	
	public SoftcakeException(){
		super();
	}
	
	public SoftcakeException(Exception ex){
		super(ex);
	}
	
	public SoftcakeException(SoftcakeException obj){
		this.timestamp = obj.getTimestamp();
		this.status = obj.getStatus();
		this.error = obj.getError();
		this.exception = obj.getException();
		this.message = obj.getMessage();
		this.path = obj.getPath();
	}
	
	public SoftcakeException(Exception ex, HttpServletResponse response){
		Map<String,String> errorMap = new HashMap<String,String>();
		errorMap.put("errorMessage",ex.getMessage());
		this.message = ex.getMessage();
		response.setCharacterEncoding("UTF-8");
		response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
		response.setContentType("application/json");
		Map<String, Object> obj = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		PrintWriter out;
		try {
			out = response.getWriter();
			obj.put("errorMessage", ex.getMessage());
			out.println(mapper.writeValueAsString(obj));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public Timestamp getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getException() {
		return exception;
	}

	public void setException(String exception) {
		this.exception = exception;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getErrorLevel() {
		return errorLevel;
	}

	public void setErrorLevel(String errorLevel) {
		this.errorLevel = errorLevel;
	}
	
}
