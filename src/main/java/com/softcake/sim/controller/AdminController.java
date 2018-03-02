package com.softcake.sim.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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

import com.google.gson.Gson;
import com.softcake.sim.beans.LoginValidator;
import com.softcake.sim.beans.Predict;
import com.softcake.sim.beans.ProgramMst;
import com.softcake.sim.beans.RoleMst;
import com.softcake.sim.beans.Sim;
import com.softcake.sim.beans.User;
import com.softcake.sim.common.SoftcakeException;
import com.softcake.sim.datatable.DataTable;
import com.softcake.sim.datatable.SearchDataTable;
import com.softcake.sim.utils.AppUtils;
import com.softcake.sim.utils.Constants;

import java.io.FileInputStream; 

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
	
	@RequestMapping(value = "ManageData/SearchSim", method = RequestMethod.POST, produces="application/json;charset=UTF-8" ,headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public DataTable<Sim> searchCorporationPending(@RequestBody SearchDataTable<Sim> searchDataTable,
			final HttpServletResponse response) throws SoftcakeException {
		DataTable<Sim> result = null;
		try {
			result = app.postDataTable("/apis/admin/searchSim", searchDataTable, Sim.class);
		} catch (Exception e) {
    		logger.error(e);
    		throw new SoftcakeException(e, response);
        }
		return result;
	}

	@RequestMapping(value = "ManageData/UploadExcelFile", method = RequestMethod.POST)
	@ResponseBody
	public String uploadFilea(@RequestParam("file") MultipartFile file) throws Exception {
	    String result = "";
		InputStream inputStream= file.getInputStream();
	    XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
        XSSFSheet sheet = workbook.getSheetAt(0);
        Iterator<Row> rowIterator = sheet.iterator();
        int i = 0;
        List<Sim> listSim = new ArrayList<Sim>();
        while (rowIterator.hasNext()) 
        {
        	Row row = rowIterator.next();
        	if(i == 0){
        		i = 1;
        		continue;
        	}
        	Sim sim = new Sim();
        	if(row.getCell(0) != null){
        		Cell cell_0 = row.getCell(1);
        		if(cell_0.getCellType() == Cell.CELL_TYPE_NUMERIC) { 
        			int simNumber = (int) row.getCell(0).getNumericCellValue();
                    sim.setSimNumber(Integer.toString(simNumber));
        		}else{
	        		sim.setSimNumber((String) row.getCell(1).getStringCellValue());
        		}
            }
        	if(row.getCell(1) != null){
        		Cell cell_1 = row.getCell(1);
        		if(cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC) { 
        			double price = (double) row.getCell(1).getNumericCellValue();
                    sim.setPrice(BigDecimal.valueOf(price));
        		}else{
	        		String price = (String) row.getCell(1).getStringCellValue();
	                sim.setPrice(new BigDecimal(price));
        		}
        	}
        	if(row.getCell(2) != null){
                String periodType = (String) row.getCell(2).getStringCellValue();
                sim.setPeriodType(periodType);;
            }
        	listSim.add(sim);
        }   
        Map<String, List<Sim>> map = new HashMap<String, List<Sim>>();
        map.put("list", listSim);
        result = app.post("/apis/admin/saveSim", new Gson().toJson(map));
	    return result;
	}
	
	@GetMapping("RolePrivilege")
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
			model.setViewName("admin/rolePrivilegeDetail");
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
			model.setViewName("admin/rolePrivilegeDetail");
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
	
	@GetMapping("ManagePredict")
	public ModelAndView GetPredict() throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.setViewName("admin/predict");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
	
	@RequestMapping(value = "ManagePredict/GetPredictById/{id}", method = RequestMethod.GET, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String GetPredictById(@PathVariable int id,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.get("/apis/admin/getPredictById/" + id);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response); 
		}
		return result;
	}
	
	@RequestMapping(value = "ManagePredict/UpdatePredict", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String saveRoleAndPrivilege(@RequestBody Predict str,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.post("/apis/admin/updatePredict", str);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response); 
		}
		return result;
	}
}
