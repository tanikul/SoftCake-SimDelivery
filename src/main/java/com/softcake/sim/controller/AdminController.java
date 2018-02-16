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
import com.softcake.sim.beans.User;
import com.softcake.sim.common.SoftcakeException;
import com.softcake.sim.datatable.DataTable;
import com.softcake.sim.datatable.SearchDataTable;
import com.softcake.sim.utils.AppUtils;

@Controller
@RequestMapping("/Admin")
@PreAuthorize("isAuthenticated()")
public class AdminController {

	private static final Logger logger = Logger.getLogger(AdminController.class);
	
	@Autowired
	private AppUtils app;
	
	
	
	@RequestMapping(value = "UploadSim", method = RequestMethod.GET)
	public ModelAndView uploadSmsContent() throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.addObject("login", new LoginValidator());
			model.setViewName("admin/uploadSim");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
	
	@RequestMapping(value = "ManageUser", method = RequestMethod.GET)
	public ModelAndView manageUser() throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.addObject("login", new LoginValidator());
			model.setViewName("admin/manageUser");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
	
	@RequestMapping(value = "SearchUser", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public DataTable<User> searchUserPending(@RequestBody SearchDataTable<User> searchDataTable,
			final HttpServletResponse response) throws SoftcakeException {
		DataTable<User> result = new DataTable<>();
		try {
			result = app.postDataTable("/apis/admin/searchUser", searchDataTable, User.class);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
}
