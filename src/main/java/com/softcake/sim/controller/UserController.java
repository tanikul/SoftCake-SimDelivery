package com.softcake.sim.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.softcake.sim.beans.LoginValidator;
import com.softcake.sim.common.SoftcakeException;

@Controller
@PreAuthorize("isAuthenticated()")
public class UserController {

	private static final Logger logger = Logger.getLogger(UserController.class);
	
	 @RequestMapping(value = "/Profile", method = RequestMethod.GET)
	 public ModelAndView profile(HttpServletRequest request) throws SoftcakeException {
		 ModelAndView model = new ModelAndView();
		 try{
			 model.addObject("login", new LoginValidator());
			 model.setViewName("member/profile");
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
        return model;
    }
}
