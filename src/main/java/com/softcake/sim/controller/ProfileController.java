package com.softcake.sim.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.softcake.sim.beans.JsonMapper;
import com.softcake.sim.beans.LoginValidator;
import com.softcake.sim.beans.User;
import com.softcake.sim.common.SoftcakeException;
import com.softcake.sim.utils.AppUtils;

@Controller
@PreAuthorize("isAuthenticated()")
public class ProfileController {

	private static final Logger logger = Logger.getLogger(ProfileController.class);
	
	@Autowired
	private AppUtils app;
	
	 @RequestMapping(value = "/Profile", method = RequestMethod.GET)
	 public ModelAndView profile(HttpServletRequest request) throws SoftcakeException {
		 ModelAndView model = new ModelAndView();
		 try{
			 String str = app.get("/apis/user/loadUserById/" + app.getUserLogin().getUserId());
			 model.addObject("data", str);
			 model.addObject("login", new LoginValidator());
			 model.setViewName("member/profile");
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
        return model;
    }
}
