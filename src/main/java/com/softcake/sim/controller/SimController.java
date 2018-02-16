package com.softcake.sim.controller;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.softcake.sim.beans.LoginValidator;
import com.softcake.sim.beans.Sim;
import com.softcake.sim.beans.User;
import com.softcake.sim.common.SoftcakeException;
import com.softcake.sim.utils.AppUtils;


@Controller
public class SimController {

	private static final Logger logger = Logger.getLogger(SimController.class);
	
	@Autowired
	private AppUtils app;
	
	/*@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView initAccount() throws SofcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.setViewName("sim/simContent");
		} catch(Exception ex){
			throw new SofcakeException(ex);
		}
		return model;
	}*/
	
	@RequestMapping(value = "/SelectNumber", method = RequestMethod.GET)
	public ModelAndView selectNumber() throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			User s = app.getUserLogin();
			model.addObject("login", new LoginValidator());
			model.setViewName("sim/selectNumber");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
	
	@RequestMapping(value = "/Predict", method = RequestMethod.GET)
	public ModelAndView predict() throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.addObject("login", new LoginValidator());
			model.setViewName("sim/predict");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
	
	@RequestMapping(value = "/Sim/SearchSim", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String searchSim(@RequestBody String obj,
			final HttpServletResponse response) throws SoftcakeException {
		String str = "";
		try {
			str = app.postWithoutAuthen("/sim/searchSim", obj);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return str;
	}
}
