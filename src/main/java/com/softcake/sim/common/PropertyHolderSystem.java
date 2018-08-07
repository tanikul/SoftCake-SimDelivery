package com.softcake.sim.common;

import org.springframework.beans.factory.annotation.Value;

public class PropertyHolderSystem {

	@Value("${role.checker}") 
	private String checker;	

	@Value("${role.maker}") 
	private String maker;	

	@Value("${role.viewer}") 
	private String viewer;
	
	@Value("${web.default.url}") 
	private String defaultUrl;
	
	public String getChecker() {
		return checker;
	}

	public void setChecker(String checker) {
		this.checker = checker;
	}

	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	public String getViewer() {
		return viewer;
	}

	public void setViewer(String viewer) {
		this.viewer = viewer;
	}

	public String getDefaultUrl() {
		return defaultUrl;
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}	
	
}
