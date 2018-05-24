package com.softcake.sim.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
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
import com.softcake.sim.beans.User;
import com.softcake.sim.common.SoftcakeException;
import com.softcake.sim.utils.AppUtils;

@Controller
@PreAuthorize("isAuthenticated()")
public class ProfileController {

	private static final Logger logger = Logger.getLogger(ProfileController.class);
	
	@Autowired
	private AppUtils app;
	
	@Value("${web.slip.path}") 
	private String pathSlip;	
	
	@Value("${web.idcard.path}") 
	private String pathIdcard;
	
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
	 
	 @RequestMapping(value = "/MyBooking", method = RequestMethod.GET)
	 public ModelAndView MyBooking(HttpServletRequest request) throws SoftcakeException {
		 ModelAndView model = new ModelAndView();
		 try{
			 Booking booking = new Booking();
			 booking.setMerchantId(app.getUserLogin().getUserId());
			 String str = app.post("/apis/searchBooking", booking);
			 model.addObject("data", str);
			 model.setViewName("member/myBooking");
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
        return model;
    }
	 
	 @RequestMapping(value = "/MyBooking/ViewBooking", method = RequestMethod.POST)
	 public ModelAndView ViewBooking(@RequestParam(required = true, value = "bookingId") String bookingId, 
			 HttpServletRequest request) throws SoftcakeException {
		 ModelAndView model = new ModelAndView();
		 try{
			 String str = app.get("/apis/getBookingByBookingId/" + bookingId);
			 Booking result = new JsonMapper<Booking>(str, Booking.class).getResult();
			 User user = new User();
			 BeanUtils.copyProperties(app.getUserLogin(), user);
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
	 
	 @RequestMapping(value = "/MyBooking/CancelBooking/{bookingId}", method = RequestMethod.GET)
	 @ResponseBody
	 public String CancelBooking(@PathVariable String bookingId,
			 HttpServletRequest request) throws SoftcakeException {
		 String str = "";
		 try{
			 app.get("/apis/cancelBooking/" + bookingId);
			 str = app.get("/apis/getBookingByUserId/" + app.getUserLogin().getUserId());
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
        return str;
    }
	 
		@RequestMapping(value = "/MyBooking/UploadSlip", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
		@ResponseBody
		public String UploadSlip(@RequestParam("file") MultipartFile file, 
				@RequestParam("bookingId") String bookingId,
				@RequestParam("bookingDetailId") String bookingDetailId,
				HttpServletRequest request) throws SoftcakeException {
			String result = "";
		    try {
				byte[] bytes = file.getBytes();
				String path = "";
				String name = "";
				String ext = FilenameUtils.getExtension(file.getOriginalFilename());
				if(!StringUtils.isEmpty(bookingDetailId)) {
					path = pathIdcard;
				    name = bookingDetailId + "_" + new Date().getTime() + "." + ext;
				}else if(!StringUtils.isEmpty(bookingId)) {
					path = pathSlip;
					name = bookingId + "_" + new Date().getTime() + "." + ext;
				}
				File dir = new File(path);
				if (!dir.exists()) {
					dir.mkdirs();
				}
				File serverFile = new File(dir.getAbsolutePath()
						+ File.separator + name);
				BufferedOutputStream stream = new BufferedOutputStream(
						new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();
				if(!StringUtils.isEmpty(bookingDetailId)) {
					BookingDetail bookingDetail = new BookingDetail();
					bookingDetail.setBookingDetailId(bookingDetailId);
					bookingDetail.setCustomerId(name);
					result = app.post("/apis/uploadIdcard", bookingDetail);
				}else if(!StringUtils.isEmpty(bookingId)) {
					Booking booking = new Booking();
					booking.setBookingId(bookingId);
					booking.setSlip(name);
					result = app.post("/apis/uploadSlip", booking);
				}
			} catch(Exception ex){
				throw new SoftcakeException(ex);
			}
			return result;
		}
		
		@RequestMapping(value = "MyBooking/OpenSlip/{bookingId}", method = RequestMethod.GET)
		@ResponseBody
		public void OpenSlip(@PathVariable String bookingId, 
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		    try {
		    	String filename = app.post("/apis/openSlip", bookingId);
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
		
		@RequestMapping(value = "MyBooking/OpenIDCard/{bookingDetailId}", method = RequestMethod.GET)
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
		
	@RequestMapping(value = "/MyBooking/SearchBooking", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
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
			booking.setMerchantId(app.getUserLogin().getUserId());
			result = app.post("/apis/searchBooking", booking);
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
        return result;
    }
	
	 @RequestMapping(value = "/Profile/UpdateUser", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	 @ResponseBody
	 public String UpdateUser(@RequestBody User user,
			 HttpServletRequest request) throws SoftcakeException {
		 String str = "";
		 try{
			 str = app.post("/apis/user/updateUser", user);
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
        return str;
    }
	 
	 @RequestMapping(value = "/ChangePassword", method = RequestMethod.GET)
	 public ModelAndView ChangePassword(HttpServletRequest request) throws SoftcakeException {
		 ModelAndView model = new ModelAndView();
		 try{
			 model.setViewName("member/changePassword");
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
        return model;
    }
	 
	 @RequestMapping(value = "/ChangePassword/UpdatePassword", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	 @ResponseBody
	 public String UpdateUser(@RequestBody String str,
			 HttpServletRequest request) throws SoftcakeException {
		 String result = "";
		 try{
			 result = app.post("/apis/user/updatePassword", str);
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
        return result;
    }
}
