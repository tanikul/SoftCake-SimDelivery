package com.softcake.sim.controller;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.softcake.sim.beans.Booking;
import com.softcake.sim.beans.BookingDetail;
import com.softcake.sim.beans.JsonMapper;
import com.softcake.sim.beans.LoginValidator;
import com.softcake.sim.beans.Predict;
import com.softcake.sim.beans.ProgramMst;
import com.softcake.sim.beans.RequestSim;
import com.softcake.sim.beans.RoleMst;
import com.softcake.sim.beans.Sim;
import com.softcake.sim.beans.User;
import com.softcake.sim.common.SoftcakeException;
import com.softcake.sim.datatable.DataTable;
import com.softcake.sim.datatable.SearchDataTable;
import com.softcake.sim.utils.AppUtils;
import com.softcake.sim.utils.Constants;

import java.io.FileInputStream; 
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/Admin")
@PreAuthorize("isAuthenticated()")
public class AdminController {

	private static final Logger logger = Logger.getLogger(AdminController.class);
	private static final String ROLEMODE_KEY = "roleMode";
	
	@Autowired
	private AppUtils app;
	
	@Value("${web.slip.path}") 
	private String pathSlip;
	
	@Value("${web.idcard.path}") 
	private String pathIdcard;
	
	@RequestMapping(value = "ManageData", method = RequestMethod.GET)
	public ModelAndView uploadSmsContent() throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.addObject("role", app.getRoleUserLogin());
			model.addObject("login", new LoginValidator());
			model.setViewName("admin/uploadSim");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
	
	@RequestMapping(value = "ManageData/SearchSimActive", method = RequestMethod.POST, produces="application/json;charset=UTF-8" ,headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public DataTable<Sim> searchCorporationActive(@RequestBody SearchDataTable<Sim> searchDataTable,
			final HttpServletResponse response) throws SoftcakeException {
		DataTable<Sim> result = null;
		try {
			result = app.postDataTable("/apis/admin/searchSimActive", searchDataTable, Sim.class);
		} catch (Exception e) {
    		logger.error(e);
    		throw new SoftcakeException(e, response);
        }
		return result;
	}
	
	@RequestMapping(value = "ManageData/SearchSimPending", method = RequestMethod.POST, produces="application/json;charset=UTF-8" ,headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String searchCorporationPending(@RequestBody SearchDataTable<Sim> searchDataTable,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			DataTable<Sim> data = app.postDataTable("/apis/admin/searchSimPending", searchDataTable, Sim.class);
			result = new Gson().toJson(data);
		} catch (Exception e) {
    		logger.error(e);
    		throw new SoftcakeException(e, response);
        }
		return result;
	}

	@RequestMapping(value = "ManageData/ApproveAll", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String ApproveAll(@RequestBody List<Sim> list,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.post("/apis/admin/approveSimAll", list);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "ManageData/RejectAll", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String RejectAll(@RequestBody List<Sim> list,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.post("/apis/admin/rejectSimAll", list);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "ManageData/RejectSim", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String rejectInterest(@RequestBody String str,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.post("/apis/admin/rejectSim", str);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "ManageData/CancelSim/{simNumber}", method = RequestMethod.GET, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String cancelInterest(@PathVariable String simNumber,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.get("/apis/admin/cancelSim/" + simNumber);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "ManageData/DeleteSim/{simNumber}", method = RequestMethod.GET)
	@ResponseBody
	public String deleteInterest(@PathVariable String simNumber,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.get("/apis/admin/deleteSimMst/" + simNumber);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "ManageData/ApproveSim/{simNumber}/{operationFlag}", method = RequestMethod.GET)
	@ResponseBody
	public String approveInterest(@PathVariable String simNumber,
			@PathVariable String operationFlag,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.get("/apis/admin/approveSim/" + simNumber + "/" + operationFlag);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "ManageData/UpdateSim", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String approveInterest(@RequestBody Sim sim,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.post("/apis/admin/updateSim", sim);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "ManageData/UpdateSimMst", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String UpdateSimMst(@RequestBody Sim sim,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.post("/apis/admin/updateSimMst", sim);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "ManageData/SaveSim", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String SaveSim(@RequestBody Sim sim,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			List<Sim> sims = new ArrayList<Sim>();
			sims.add(sim);
			result = app.post("/apis/admin/saveSim", sims);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "ManageData/UploadExcelFile", method = RequestMethod.POST)
	@ResponseBody
	public String uploadFilea(@RequestParam("file") MultipartFile file,
			HttpServletResponse response) throws Exception {
	    String result = "";
	    try {
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
	        		Cell cell_0 = row.getCell(0);
	        		if(cell_0.getCellType() == Cell.CELL_TYPE_NUMERIC) { 
	        			int simNumber = (int) cell_0.getNumericCellValue();
	                    sim.setSimNumber(Integer.toString(simNumber));
	        		}else{
		        		sim.setSimNumber((String) cell_0.getStringCellValue());
	        		}
	            }
	        	if(row.getCell(1) != null){
	        		Cell cell_1 = row.getCell(1);
	        		if(cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC) { 
	        			int creditTerm = (int) cell_1.getNumericCellValue();
	                    sim.setCreditTerm(creditTerm + "");
	        		}else{
		        		String creditTerm = (String) cell_1.getStringCellValue();
		                sim.setCreditTerm(creditTerm);
	        		}
	        	}
	        	if(row.getCell(2) != null){
	        		Cell cell_2 = row.getCell(2);
	        		if(cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC) { 
	        			double price = (double) cell_2.getNumericCellValue();
	                    sim.setPrice(BigDecimal.valueOf(price));
	        		}else{
		        		String price = (String) cell_2.getStringCellValue();
		                sim.setPrice(new BigDecimal(price));
	        		}
	        	}
	        	if (DateUtil.isCellDateFormatted(row.getCell(3))){
	        		Cell cell_3 = row.getCell(3);
	        		sim.setRecievedDate(cell_3.getDateCellValue());
	        	}
	        	sim.setActiveStatus("Y");
	        	/*if(row.getCell(4) != null){
	                String activeStatus = (String) row.getCell(4).getStringCellValue();
	                sim.setActiveStatus(activeStatus);
	            }*/
	        	listSim.add(sim);
	        }   
	        Map<String, List<Sim>> map = new HashMap<String, List<Sim>>();
	        map.put("list", listSim);
	        result = app.post("/apis/admin/saveSim", listSim);
	    }catch(Exception ex){
	    	app.jsonResponse(response, false, ex.getMessage());
    		return null;
	    }
	    
	    return result;
	}
	
	@RequestMapping(value = "ManageData/OpenExample", method = RequestMethod.GET)
	@ResponseBody
	public String openExample(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	    String result = "";
	    try {
	    	String path = request.getServletContext().getRealPath("/resources/example/Sim.xlsx");
	    	File downloadFile = new File(path);
	        FileInputStream inStream = new FileInputStream(downloadFile); 
	        ServletContext context = request.getServletContext(); 
	        String mimeType = context.getMimeType(path);
	        if (mimeType == null) {        
	           mimeType = "application/octet-stream";
	        }
	        response.setContentType(mimeType);
	        response.setContentLength((int) downloadFile.length());
	        String headerKey = "Content-Disposition";
	        String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
	        response.setHeader(headerKey, headerValue);
	        OutputStream outStream = response.getOutputStream();
	         
	        byte[] buffer = new byte[4096];
	        int bytesRead = -1;
	         
	        while ((bytesRead = inStream.read(buffer)) != -1) {
	            outStream.write(buffer, 0, bytesRead);
	        }
	         
	        inStream.close();
	        outStream.close();  
	    }catch(Exception ex){
	    	throw new SoftcakeException(ex);
	    }
	    
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
	
	@RequestMapping(value = "ManageBooking", method = RequestMethod.GET)
	public ModelAndView ManageBooking() throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.addObject("role", app.getRoleUserLogin());
			Booking search = new Booking();
			String str = app.post("/apis/admin/searchBooking", search);
			model.addObject("data", str);
			model.setViewName("admin/manageBooking");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
	
	@RequestMapping(value = "ManageBooking/Booking", method = RequestMethod.POST)
	public ModelAndView ManageCustomerBooking(@RequestParam("userId") String userId) throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.addObject("role", app.getRoleUserLogin());
			Booking search = new Booking();
			search.setMerchantId(userId);
			String str = app.post("/apis/admin/searchBooking", search);
			model.addObject("data", str);
			String user = app.get("/apis/user/loadUserById/" + userId);
			model.addObject("user", new JsonMapper<User>(user, User.class).getResult()); 
			model.setViewName("admin/manageBooking");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
	
	@PreAuthorize(Constants.ACCESS_CHECKER)
	@RequestMapping(value = "ManageBooking/RejectBooking", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String RejectBooking(@RequestBody Booking booking,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.post("/apis/admin/rejectBooking", booking);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@PreAuthorize(Constants.ACCESS_CHECKER)
	@RequestMapping(value = "ManageBooking/ApproveBooking/{bookingId}", method = RequestMethod.GET)
	@ResponseBody
	public String ApproveBooking(@PathVariable String bookingId,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.get("/apis/admin/approveBooking/" + bookingId);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@PreAuthorize(Constants.ACCESS_CHECKER)
	@RequestMapping(value = "ManageBooking/ApproveIdCard", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String ApproveIdCard(@RequestBody BookingDetail bookingDetail,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.post("/apis/admin/approveStatusIdCard/", bookingDetail);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@PreAuthorize(Constants.ACCESS_CHECKER)
	@RequestMapping(value = "ManageBooking/RejectIdCard", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String RejectIdCard(@RequestBody BookingDetail bookingDetail,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.post("/apis/admin/rejectStatusIdCard/", bookingDetail);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@PreAuthorize(Constants.ACCESS_CHECKER)
	@RequestMapping(value = "ManageBooking/OpenSlip/{bookingId}/{merchantId}", method = RequestMethod.GET)
	@ResponseBody
	public void openExample(@PathVariable String bookingId, 
			@PathVariable String merchantId, 
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	    try {
	    	Map<String, String> map = new HashMap<String, String>();
	    	map.put("bookingId", bookingId);
	    	map.put("merchantId", merchantId);
	    	String filename = app.post("/apis/admin/openSlipByAdmin", map);
	    	String path = pathSlip + filename;
	    	File downloadFile = new File(path);
	        FileInputStream inStream = new FileInputStream(downloadFile); 
	        ServletContext context = request.getServletContext(); 
	        String mimeType = context.getMimeType(path);
	        if (mimeType == null) {        
	           mimeType = "application/octet-stream";
	        }
	        response.setContentType(mimeType);
	        response.setContentLength((int) downloadFile.length());
	        String headerKey = "Content-Disposition";
	        String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
	        response.setHeader(headerKey, headerValue);
	        OutputStream outStream = response.getOutputStream();
	         
	        byte[] buffer = new byte[4096];
	        int bytesRead = -1;
	         
	        while ((bytesRead = inStream.read(buffer)) != -1) {
	            outStream.write(buffer, 0, bytesRead);
	        }
	         
	        inStream.close();
	        outStream.close();  
	    }catch(Exception ex){
	    	throw new SoftcakeException(ex);
	    }
	}
	
	@PreAuthorize(Constants.ACCESS_CHECKER)
	@RequestMapping(value = "ManageBooking/OpenIDCard/{bookingDetailId}", method = RequestMethod.GET)
	@ResponseBody
	public void OpenIDCard(@PathVariable String bookingDetailId, 
		HttpServletRequest request,
		HttpServletResponse response) throws Exception {
	    try {
	    	String filename = app.post("/apis/openIDCard", bookingDetailId);
	    	String path = pathIdcard + filename;
	    	File downloadFile = new File(path);
	        FileInputStream inStream = new FileInputStream(downloadFile); 
	        ServletContext context = request.getServletContext(); 
	        String mimeType = context.getMimeType(path);
	        if (mimeType == null) {        
	           mimeType = "application/octet-stream";
	        }
	        response.setContentType(mimeType);
	        response.setContentLength((int) downloadFile.length());
	        String headerKey = "Content-Disposition";
	        String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
	        response.setHeader(headerKey, headerValue);
	        OutputStream outStream = response.getOutputStream();
	         
	        byte[] buffer = new byte[4096];
	        int bytesRead = -1;
	         
	        while ((bytesRead = inStream.read(buffer)) != -1) {
	            outStream.write(buffer, 0, bytesRead);
	        }
	         
	        inStream.close();
	        outStream.close();  
	    }catch(Exception ex){
	    	throw new SoftcakeException(ex);
	    }
	}
	
	@RequestMapping(value = "/ManageBooking/SearchBooking", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	 @ResponseBody
	 public String SearchBooking(@RequestBody String str,
			 HttpServletRequest request) throws SoftcakeException {
		 String result = "";
		 ObjectMapper mapper = new ObjectMapper();
		try {
			JsonNode node = mapper.readTree(str);
			String bookingId = mapper.convertValue(node.get("bookingId"), String.class);
			String mobileNo = mapper.convertValue(node.get("mobileNo"), String.class);
			Booking booking = new Booking();
			booking.setBookingId(bookingId);
			List<BookingDetail> bookingDetail = new ArrayList<>();
			BookingDetail bookingD = new BookingDetail();
			bookingD.setSimNumber(mobileNo);
			bookingDetail.add(bookingD);
			booking.setBookingDetails(bookingDetail);
			result = app.post("/apis/admin/searchBooking", booking);
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
       return result;
   }
	
	@RequestMapping(value = "/ManageBooking/ViewBooking", method = RequestMethod.POST)
	 public ModelAndView ViewBooking(@RequestParam(required = true, value = "bookingId") String bookingId, 
			 HttpServletRequest request) throws SoftcakeException {
		 ModelAndView model = new ModelAndView();
		 try{
			 String str = app.get("/apis/getBookingByBookingId/" + bookingId);
			 Booking result = new JsonMapper<Booking>(str, Booking.class).getResult();
			 str = app.get("/apis/user/loadUserById/" + result.getMerchantId());
			 User user= new JsonMapper<User>(str, User.class).getResult();
			 user.setMobile((StringUtils.isEmpty(user.getMobile()) ? "-" : app.parseSimFormat(user.getMobile())));
			 user.setLine((StringUtils.isEmpty(user.getLine())) ? "-" : user.getLine());
			 user.setWebsite((StringUtils.isEmpty(user.getWebsite())) ? "-" : user.getWebsite());
			 user.setNickName((StringUtils.isEmpty(user.getNickName())) ? "-" : user.getNickName());
			 model.addObject("user", user);
			 model.addObject("data", result);
			 model.addObject("app", app);
			 model.setViewName("member/viewBooking");
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
       return model;
   }
	
	@RequestMapping(value = "/ManageRequest", method = RequestMethod.GET)
	 public ModelAndView RequestSimCard(HttpServletRequest request) throws SoftcakeException {
		 ModelAndView model = new ModelAndView();
		 try{
			 model.setViewName("admin/request");
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
      return model;
    }
	
	@RequestMapping(value = "/ManageRequest/SearchRequestSim", method = RequestMethod.POST, produces="application/json;charset=UTF-8" ,headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String SearchRequestSim(@RequestBody SearchDataTable<RequestSim> searchDataTable,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			DataTable<RequestSim> data = app.postDataTable("/apis/admin/searchRequestSim", searchDataTable, RequestSim.class);
			result = new Gson().toJson(data);
		} catch (Exception e) {
    		logger.error(e);
    		throw new SoftcakeException(e, response);
        }
		return result;
	}
	
	@RequestMapping(value = "ManageRequest/ApproveRequestSim", method = RequestMethod.POST, produces="application/json;charset=UTF-8" ,headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String ApproveBooking(@RequestBody RequestSim requestSim,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			result = app.post("/apis/admin/approveRequestSim", requestSim);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "SetupEmail", method = RequestMethod.GET)
	public ModelAndView SetupEmail() throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			model.setViewName("admin/setupEmail");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
}
