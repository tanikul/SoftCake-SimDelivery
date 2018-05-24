package com.softcake.sim.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.softcake.sim.common.SoftcakeException;
import com.softcake.sim.utils.AppUtils;

@Controller
public class ContentController {

	private static final Logger logger = Logger.getLogger(ContentController.class);
	
	@Autowired
	private AppUtils app;
	
	@RequestMapping(value = "/Condition", method = RequestMethod.GET)
	public ModelAndView uploadSmsContent() throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.setViewName("content/condition");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
}
