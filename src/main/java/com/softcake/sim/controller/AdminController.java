package com.softcake.sim.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.softcake.sim.beans.LoginValidator;
import com.softcake.sim.beans.ProgramMst;
import com.softcake.sim.beans.RoleMst;
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
	private static final String ROLEMODE_KEY = "roleMode";
	
	@Autowired
	private AppUtils app;
	
	@RequestMapping(value = "ManageData", method = RequestMethod.GET)
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
	
	@PostMapping("/UploadExcelFile")
	public String uploadFilea(/*@RequestParam("file") MultipartFile file*/) throws IOException {
	    InputStream in = null;
	    File currDir = new File(".");
	    String path = currDir.getAbsolutePath();
	    //String fileLocation = path.substring(0, path.length() - 1) + file.getOriginalFilename();
	    //FileOutputStream f = new FileOutputStream(fileLocation);
	    int ch = 0;
	    /*while ((ch = in.read()) != -1) {
	        f.write(ch);
	    }
	    f.flush();
	    f.close();*/
	    //model.addAttribute("message", "File: " + file.getOriginalFilename() 
	     // + " has been uploaded successfully!");
	    return "excel";
	}
	
	@GetMapping("RoleAndPrivilege")
	public ModelAndView RoleAndPrivilege() throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.addObject("role", "Maker");
			model.setViewName("admin/rolePrivilegeMaster");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}

	@RequestMapping(value = "RolePrivilege/AddRolePrivilege", method = RequestMethod.GET)
	public ModelAndView addRolePrivilegeDetail() throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			//model.addObject("role", app.getRoleUserLogin());
			model.addObject("role", "Maker");
			model.addObject(ROLEMODE_KEY, "ADD"); 
			model.setViewName("admin/rolePrivilegeDetail");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}

	@RequestMapping(value = "RolePrivilege/EditRolePrivilegeDetail", method = RequestMethod.POST)
	public ModelAndView editRolePrivilegeDetail(@RequestParam(value = "roleId") String roleId,
			@RequestParam(value = "roleName") String roleName
			) throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.addObject("role", app.getRoleUserLogin());
			model.addObject("roleId", roleId); 
			model.addObject("roleName", roleName); 
			model.addObject(ROLEMODE_KEY, "EDIT"); 
			model.setViewName("userManagement/rolePrivilegeDetail");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
	
	@RequestMapping(value = "RolePrivilege/SaveRoleAndPrivilege", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String saveRoleAndPrivilege(@RequestBody String str,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.post("/apis/rolePrivilege/saveRoleAndPrivilege", str);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response); 
		}
		return result;
	}
	
	@RequestMapping(value = "RolePrivilege/ViewRolePrivilegeDetail", method = RequestMethod.POST)
	public ModelAndView viewRolePrivilegeDetail(@RequestParam(value = "roleId") String roleId,
			@RequestParam(value = "roleName") String roleName
			) throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.addObject("role", app.getRoleUserLogin());
			model.addObject("roleId", roleId); 
			model.addObject("roleName", roleName); 
			model.addObject(ROLEMODE_KEY, "VIEW"); 
			model.setViewName("userManagement/rolePrivilegeDetail");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
	
	
	@RequestMapping(value = "RolePrivilege/SearchRoleAndPrivilege", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public DataTable<RoleMst> searchRoleAndPrivilege(@RequestBody SearchDataTable<RoleMst> searchDataTable,
			final HttpServletResponse response) throws SoftcakeException {
		DataTable<RoleMst> result = new DataTable<>();
		try {
			result = app.postDataTable("/apis/rolePrivilege/searchRoleAndPrivilege", searchDataTable, RoleMst.class);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
	
	@RequestMapping(value = "RolePrivilege/DeleteKbankRoleByRoleName/{roleName}", method = RequestMethod.GET)
	@ResponseBody
	public String deleteKbankRoleByRoleName(@PathVariable String  roleName,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.get("/apis/rolePrivilege/deleteRoleByRoleName/" + roleName);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
	
	@RequestMapping(value = "RolePrivilege/SearchUserByUserRole", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public DataTable<User> searchUserByUserRole(@RequestBody SearchDataTable<User> searchDataTable,
			final HttpServletResponse response) throws SoftcakeException {
		DataTable<User> result = new DataTable<>();
		try {
			result = app.postDataTable("/apis/rolePrivilege/searchUserByUserRole", searchDataTable, User.class);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
	
	@RequestMapping(value = "RolePrivilege/SearchProgramMaster", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public DataTable<ProgramMst> searchProgramMaster(@RequestBody SearchDataTable<ProgramMst> searchDataTable,
			final HttpServletResponse response) throws SoftcakeException {
		DataTable<ProgramMst> result = new DataTable<>();
		try {
			result = app.postDataTable("/apis/rolePrivilege/searchProgramMaster", searchDataTable, ProgramMst.class);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
}
