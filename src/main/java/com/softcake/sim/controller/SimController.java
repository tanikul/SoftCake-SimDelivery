package com.softcake.sim.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.softcake.sim.beans.Booking;
import com.softcake.sim.beans.JsonMapper;
import com.softcake.sim.beans.LoginValidator;
import com.softcake.sim.beans.RequestSim;
import com.softcake.sim.beans.Sim;
import com.softcake.sim.beans.User;
import com.softcake.sim.common.SoftcakeException;
import com.softcake.sim.datatable.DataTable;
import com.softcake.sim.datatable.SearchDataTable;
import com.softcake.sim.utils.AppUtils;
import com.softcake.sim.utils.Constants;

import io.jsonwebtoken.Claims;


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
	public ModelAndView selectNumber(final HttpServletRequest request) throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			if(request.getSession().getAttribute("Sims") == null){
				return new ModelAndView("redirect:/");
			}
			model.addObject("sims", request.getSession().getAttribute("Sims"));
			model.addObject("login", new LoginValidator());
			model.addObject("app", app);
			model.setViewName("sim/selectNumber");
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return model;
	}
	
	@SuppressWarnings("unchecked")
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/SubmitConfirm", method = RequestMethod.GET)
	public ModelAndView SubmitConfirm(final HttpServletRequest request) throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try{
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			if(authentication != null){
				boolean hasUserRole = authentication.getAuthorities().stream()
				          .anyMatch(r -> r.getAuthority().equals("ROLE_ANONYMOUS"));
				if(!hasUserRole){
					ObjectMapper mapper = new ObjectMapper();
					Map<String, Sim> map = (Map<String, Sim>) request.getSession().getAttribute("Sims");
					List<String> arr = new ArrayList<>();
					for (Map.Entry<String, Sim> entry : map.entrySet()) {
						arr.add(app.removeSimFormat(entry.getKey()));
					}
					String str = app.post("/apis/selectSimByNumber", arr);
					List<Sim> list = mapper.readValue(str, new TypeReference<List<Sim>>(){});
					User user = new User();
					BeanUtils.copyProperties(app.getUserLogin(), user);
					user.setMobile((StringUtils.isEmpty(user.getMobile()) ? "-" : app.parseSimFormat(user.getMobile())));
					user.setLine((StringUtils.isEmpty(user.getLine())) ? "-" : user.getLine());
					user.setWebsite((StringUtils.isEmpty(user.getWebsite())) ? "-" : user.getWebsite());
					user.setNickName((StringUtils.isEmpty(user.getNickName())) ? "-" : user.getNickName());
					model.addObject("sims", list);
					model.addObject("simsJson", new Gson().toJson(list));
					model.addObject("user", user);
					model.addObject("app", app);
					model.setViewName("sim/submitConfirm");
				}else{
					return new ModelAndView("redirect:/");
				}
			}else{
				return new ModelAndView("redirect:/");
			}
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
	
	@RequestMapping(value = "/Sim/SaveSesionSim", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String saveSesionSim(@RequestBody List<String> obj,
			final HttpServletRequest request,
			final HttpServletResponse response) throws SoftcakeException {
		try {
			Map<String, Sim> map = new HashMap<String, Sim>();
			for(String item : obj){
				Sim sim = new Sim();
				sim.setSumNumber(app.calculateSim(item));
				map.put(item, sim);
			}
			request.getSession().setAttribute("Sims", map);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return Constants.SUCCESS;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/Sim/RemoveSesionSim", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String saveSesionSim(@RequestBody Sim sim,
			final HttpServletRequest request,
			final HttpServletResponse response) throws SoftcakeException {
		String result = "";
		try {
			HashMap<String, Sim> sims = (HashMap<String, Sim>) request.getSession().getAttribute("Sims");
			sims.remove(sim.getSimNumber());
			request.getSession().setAttribute("Sims", sims);
			result = String.valueOf(sims.size());
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/Sim/SaveBooking", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String SaveBooking(@RequestBody List<Sim> obj,
			final HttpServletRequest request,
			final HttpServletResponse response) throws SoftcakeException {
		String result = "";
		try {
			result = app.post("/apis/saveBooking", obj);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/BookingSuccess", method = RequestMethod.POST)
	public ModelAndView BookingSuccess(@RequestParam("bookingId") String bookingId, final HttpServletRequest request) throws SoftcakeException {
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
			 model.addObject("bookingId", bookingId); 
			 model.setViewName("sim/bookingSuccess");
			 request.getSession().setAttribute("Sims", null);
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
		return model;
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/BookingSuccess/CancelBookingSess", method = RequestMethod.GET)
	public String CancelBookingSess(final HttpServletRequest request) throws SoftcakeException {
		try{
			request.getSession().setAttribute("Sims", null);
		} catch(Exception ex){
			throw new SoftcakeException(ex);
		}
		return Constants.SUCCESS;
	}
	
	@RequestMapping(value = "/RequestSimCard", method = RequestMethod.GET)
	 public ModelAndView RequestSimCard(HttpServletRequest request) throws SoftcakeException {
		 ModelAndView model = new ModelAndView();
		 try{
			 model.setViewName("sim/request");
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
       return model;
   }
	
	@RequestMapping(value = "RequestSimCard/SearchRequestSim", method = RequestMethod.POST, produces="application/json;charset=UTF-8" ,headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String searchCorporationPending(@RequestBody SearchDataTable<RequestSim> searchDataTable,
			final HttpServletResponse response) throws SoftcakeException {
		String result = null;
		try {
			if(app.getUserLogin() == null) {
				DataTable<RequestSim> obj = new DataTable<>();
				List<RequestSim> list = new ArrayList<>();
				obj.setData(list);
				return new Gson().toJson(obj);
			}
			DataTable<RequestSim> data = app.postDataTable("/apis/searchRequestSim", searchDataTable, RequestSim.class);
			result = new Gson().toJson(data);
		} catch (Exception e) {
    		logger.error(e);
    		throw new SoftcakeException(e, response);
        }
		return result;
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/RequestSimCard/SaveRequestSim", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String SaveRequestSim(@RequestBody RequestSim obj,
			final HttpServletRequest request,
			final HttpServletResponse response) throws SoftcakeException {
		String result = "";
		try {
			result = app.post("/apis/saveRequestSim", obj);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/RequestSimCard/CancelRequestSim", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String CancelRequestSim(@RequestBody RequestSim obj,
			final HttpServletRequest request,
			final HttpServletResponse response) throws SoftcakeException {
		String result = "";
		try {
			result = app.post("/apis/cancelRequestSim", obj);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/RequestSimCard/CheckSimNumberBeforeRequest/{simNumber}", method = RequestMethod.GET)
	 @ResponseBody
	 public String checkSimNumberBeforeRequest(@PathVariable String simNumber,
			 HttpServletRequest request, HttpServletResponse response) throws SoftcakeException{
		String result = "1";
		try {
			result = app.get("/apis/checkSimNumberBeforeRequest/" + simNumber);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex); 
		}
		return result;
    }
	
	@RequestMapping(value = "/Predict/GetDataPredict", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String GetDataPredict(@RequestBody Sim sim,
			final HttpServletRequest request,
			final HttpServletResponse response) throws SoftcakeException {
		String result = "";
		try {
			result = app.getWithoutAuthen("/sim/getDataPredict/" + app.calculateSim(sim.getSimNumber()));
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
}
