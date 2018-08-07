package com.softcake.sim.common;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import com.softcake.sim.utils.AppUtils;

public class UrlFormatTag extends SimpleTagSupport {

	private String value;
	
	@Override
	public void doTag() throws JspException, IOException {
		try {
			AppUtils menu = (AppUtils) ApplicationContextHolder.getContext().getBean("app");
			getJspContext().getOut().write(menu.getWebUrl() + this.getValue());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
}
