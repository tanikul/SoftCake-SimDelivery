package com.softcake.sim.controller;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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
import com.softcake.sim.utils.Constants;

@Controller
@RequestMapping("/Admin")
@PreAuthorize("isAuthenticated()")
public class UserController {

	private static final Logger logger = Logger.getLogger(UserController.class);
	
	@Autowired
	private AppUtils app;
	
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
	
	@RequestMapping(value = "ManageUser/SearchUser", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public DataTable<User> SearchUser(@RequestBody SearchDataTable<User> searchDataTable,
			final HttpServletResponse response) throws SoftcakeException {
		DataTable<User> result = new DataTable<>();
		try {
			searchDataTable.getDataSearch().setUserType(Constants.USER_TYPE_ADMIN);
			result = app.postDataTable("/apis/admin/searchUser", searchDataTable, User.class);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
	
	@RequestMapping(value = "/ManageUser/LoadUserById/{userId}", method = RequestMethod.GET, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String LoadUserById(@PathVariable String userId, 
			final HttpServletResponse response) throws SoftcakeException  {
		String result = null;
		try {
			result = app.get("/apis/user/loadUserById/" + userId);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "/ManageUser/DeleteUserById/{userId}", method = RequestMethod.GET, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String DeleteUserById(@PathVariable String userId, 
			final HttpServletResponse response) throws SoftcakeException  {
		String result = null;
		try {
			result = app.get("/apis/user/deleteUserById/" + userId);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "/ManageUser/Register", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String Register(@RequestBody User user,
			final HttpServletResponse response) throws SoftcakeException {
		String str = "";
		try {
			str = app.post("/apis/user/register", user);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return str;
	}
	
	@RequestMapping(value = "/ManageUser/UpdateUser", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String UpdateUser(@RequestBody User user,
			final HttpServletResponse response) throws SoftcakeException {
		String str = "";
		try {
			str = app.post("/apis/user/updateUserAdmin", user);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return str;
	}
	
	@RequestMapping(value = "/ManageUser/EditUserCustomer", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String EditUserCustomer(@RequestBody User user,
			final HttpServletResponse response) throws SoftcakeException {
		String str = "";
		try {
			str = app.post("/apis/user/editUserCustomer", user);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return str;
	}
	
	@RequestMapping(value = "ManageCustomer", method = RequestMethod.GET)
	public ModelAndView ManageCustomer() throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.addObject("login", new LoginValidator());
			model.setViewName("admin/manageCustomer");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
	
	@RequestMapping(value = "ManageCustomer/SearchCustomer", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public DataTable<User> SearchCustomer(@RequestBody SearchDataTable<User> searchDataTable,
			final HttpServletResponse response) throws SoftcakeException {
		DataTable<User> result = new DataTable<>();
		try {
			searchDataTable.getDataSearch().setUserType(Constants.USER_TYPE_CUSTOMER);
			result = app.postDataTable("/apis/admin/searchUser", searchDataTable, User.class);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
}
