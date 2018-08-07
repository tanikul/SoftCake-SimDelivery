package com.softcake.sim.controller;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.softcake.sim.beans.JsonMapper;
import com.softcake.sim.beans.LoginValidator;
import com.softcake.sim.beans.User;
import com.softcake.sim.common.CustomAuthenticationSuccessHandler;
import com.softcake.sim.common.LoginAuthenticationProvider;
import com.softcake.sim.common.SoftcakeException;
import com.softcake.sim.common.VerifyRecaptcha;
import com.softcake.sim.utils.AppUtils;
import com.softcake.sim.utils.Constants;

@Controller
public class LoginController {
	
	private static final Logger logger = Logger.getLogger(LoginController.class);
	
	@Autowired
	private AppUtils app;
	
	@Autowired
	@Qualifier("customAuthenticationSuccessHandler")
	CustomAuthenticationSuccessHandler authenSuccess;
	
	/*@Autowired
	@Qualifier("authenticationManager")
	LoginAuthenticationProvider loginProvider;*/
	
	@RequestMapping(value = "/TestPost", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String TestPost(HttpServletRequest request,
			 HttpServletResponse response/*,
			 @RequestParam("username") String username,
			 @RequestParam("password") String password*/) throws SoftcakeException {
		String u = null;
		try {	
			/*u = app.postWithoutAuthen("/login", user);
			List<GrantedAuthority> grantedAuths = new ArrayList<>();
           JsonMapper<User> result = new JsonMapper<>(u, User.class);
           grantedAuths.add(new SimpleGrantedAuthority(result.getResult().getRole()));*/
			/*Authentication authen = loginProvider.authenticate(new UsernamePasswordAuthenticationToken(username, ""));
			authenSuccess.onAuthenticationSuccess(request, response, authen);*/
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex); 
		}
      return Constants.SUCCESS;
  }
	@RequestMapping(value = "/TestGet", method = RequestMethod.GET, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String TestGet(HttpServletRequest request,
			 HttpServletResponse response/*,
			 @RequestParam("username") String username,
			 @RequestParam("password") String password*/) throws SoftcakeException {
		String u = null;
		try {	
			/*u = app.postWithoutAuthen("/login", user);
			List<GrantedAuthority> grantedAuths = new ArrayList<>();
           JsonMapper<User> result = new JsonMapper<>(u, User.class);
           grantedAuths.add(new SimpleGrantedAuthority(result.getResult().getRole()));*/
			/*Authentication authen = loginProvider.authenticate(new UsernamePasswordAuthenticationToken(username, ""));
			authenSuccess.onAuthenticationSuccess(request, response, authen);*/
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex); 
		}
      return Constants.SUCCESS;
  }
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request, 
			HttpServletResponse responses, 
			HttpSession session) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if(authentication != null){
			boolean hasUserRole = authentication.getAuthorities().stream()
			          .anyMatch(r -> r.getAuthority().equals("ROLE_ANONYMOUS"));
			if(hasUserRole){
				/*session= request.getSession(false);
			    SecurityContextHolder.clearContext();
			         session= request.getSession(false);
			        if(session != null) {
			            session.invalidate();
			        }
			        for(Cookie cookie : request.getCookies()) {
			            cookie.setMaxAge(0);
			        }*/
			}
		}
		ModelAndView model = new ModelAndView();
		model.addObject("login", new LoginValidator());
		model.setViewName("sim/simContent");
		return model;
	}
	 
	@RequestMapping(value = "/CheckSessionLogin", method = RequestMethod.GET)
	@ResponseBody
	public String searchSim(final HttpServletRequest request,
			final HttpServletResponse response) throws SoftcakeException {
		String str = "1";
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

			if(authentication != null){
				boolean hasUserRole = authentication.getAuthorities().stream()
				          .anyMatch(r -> r.getAuthority().equals("ROLE_ANONYMOUS"));
				if(hasUserRole){
					str = "0";
				}
			}
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return str;
	}
	
	@RequestMapping(value = "/Logins", method = RequestMethod.POST)
	 public String login(HttpServletRequest request,
			 HttpServletResponse response,
			 @RequestParam("username") String username/*,
			 @RequestParam("password") String password*/) throws SoftcakeException {
		String u = null;
		try {	
			/*u = app.postWithoutAuthen("/login", user);
			List<GrantedAuthority> grantedAuths = new ArrayList<>();
            JsonMapper<User> result = new JsonMapper<>(u, User.class);
            grantedAuths.add(new SimpleGrantedAuthority(result.getResult().getRole()));*/
			/*Authentication authen = loginProvider.authenticate(new UsernamePasswordAuthenticationToken(username, ""));
			authenSuccess.onAuthenticationSuccess(request, response, authen);*/
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex); 
		}
       return Constants.SUCCESS;
   }
	
	/*@RequestMapping(value = "/Login", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	 public String login(HttpServletRequest request,
			 HttpServletResponse response,
			 @RequestBody User user) throws SoftcakeException {
		String u = null;
		try {	
			u = app.postWithoutAuthen("/login", user);
			List<GrantedAuthority> grantedAuths = new ArrayList<>();
            JsonMapper<User> result = new JsonMapper<>(u, User.class);
            grantedAuths.add(new SimpleGrantedAuthority(result.getResult().getRole()));
			Authentication authen = loginProvider.authenticate(new UsernamePasswordAuthenticationToken(user.getUserId(), user.getPassword()));
			authenSuccess.onAuthenticationSuccess(request, response, authen);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex); 
		}
       return Constants.SUCCESS;
   }*/
	
	 @RequestMapping(value = "/", method = RequestMethod.GET)
	 public ModelAndView start(HttpServletRequest request) throws SoftcakeException {
		 ModelAndView model = new ModelAndView();
		 try{
			 model.addObject("simsJson", new Gson().toJson(request.getSession().getAttribute("Sims")));
			 model.addObject("login", new LoginValidator());
			 model.setViewName("sim/simContent");
		 }catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex);
		 }
        return model;
    }
	 
	@RequestMapping(value = "/User/Signup", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String Signup(@RequestBody String str,
			final HttpServletResponse response) throws SoftcakeException {
		String result = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			JsonNode node = mapper.readTree(str);
			String recaptcha = mapper.convertValue(node.get("recaptcha"), String.class);
			Map<String, Object> captcha = VerifyRecaptcha.verify(recaptcha);
            if(captcha.get("CODE").equals(200)){
				User user = mapper.convertValue(node.get("user"), User.class);
				result = app.postWithoutAuthen("/user/signup", user);
            }else {
            	throw new Exception(captcha.get("MSG").toString());  
            }
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return result;
	}
	
	@RequestMapping(value = "/User/CheckDuplicateUser", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String CheckDuplicateUser(@RequestBody String str, 
			final HttpServletResponse response) throws SoftcakeException  {
		String result = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			JsonNode node = mapper.readTree(str);
			String userId = mapper.convertValue(node.get("userId"), String.class);
			result = app.postWithoutAuthen("/user/checkDuplicateUser",  userId);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "/User/CheckEmailInSystem", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String CheckEmailInSystem(@RequestBody String str, 
			final HttpServletResponse response) throws SoftcakeException  {
		String result = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			JsonNode node = mapper.readTree(str);
			String email = mapper.convertValue(node.get("email"), String.class);
			result = app.postWithoutAuthen("/user/checkEmailInSystem",  email);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "/User/CheckDuplicateEmail", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String CheckDuplicateEmail(@RequestBody Map<String, String> str, 
			final HttpServletResponse response) throws SoftcakeException  {
		String result = null;
		try {
			result = app.postWithoutAuthen("/user/checkDuplicateEmail",  str.get("email"));
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	 @RequestMapping(value = "/activateEmail",method = RequestMethod.GET)
	 public RedirectView activateEmail(@RequestParam("userId") String userId,
			 @RequestParam("activateEmail") String activateEmail,
			 final HttpServletResponse response) throws SoftcakeException {
		try {
			app.getWithoutAuthen("/activateEmail?userId=" + userId + "&activateEmail=" + activateEmail);
		}catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex, response);
		}
		return new RedirectView(app.getWebUrl());
    }
	
	@RequestMapping(value = "/Logout", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String logout(final HttpSession session,
			final HttpServletResponse response) throws SoftcakeException {
		try {	
			session.invalidate();
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return Constants.SUCCESS;
	}
	
	@RequestMapping(value = "/User/ForgotPassword", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String ForgotPassword(@RequestBody String str,
			 final HttpServletResponse response) throws SoftcakeException {
		String result = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			JsonNode node = mapper.readTree(str);
			String recaptcha = mapper.convertValue(node.get("recaptcha"), String.class);
			String email = mapper.convertValue(node.get("email"), String.class);
			Map<String, Object> captcha = VerifyRecaptcha.verify(recaptcha);
            if(captcha.get("CODE").equals(200)){
            	result = app.postWithoutAuthen("/forgotPassword", email);
            }else {
            	throw new Exception(captcha.get("MSG").toString());  
            }
		}catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex, response);
		}
		return result;
    }
	
	@RequestMapping(value = "/ForgotPassword", method = RequestMethod.GET)
	public ModelAndView ForgotPassword(@RequestParam("email") String email,
			 @RequestParam("id") String id,
			 final HttpServletResponse response) throws SoftcakeException {
		ModelAndView model = new ModelAndView();
		try {
			User user = new User();
			user.setEmail(email);
			user.setForgotPassword(id);
			String data = app.postWithoutAuthen("/selectUserByEmailAndForgotPassword", user);
			if(data == null) {
				return new ModelAndView("redirect:/" + app.getWebUrl());
			}
			User result = new JsonMapper<>(data, User.class).getResult(); 
			model.addObject("user", result);
			model.setViewName("/member/forgotPassword");
		}catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex, response);
		}
		return model;
   }
	
	@RequestMapping(value = "/ForgotPassword/SaveResetPassword", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String ForgotPassword(@RequestBody User user,
			 final HttpServletResponse response) throws SoftcakeException {
		String result = "";
		try {
			result = app.postWithoutAuthen("/saveResetPassword", user);
		}catch(Exception ex){
			 logger.error(ex);
			 throw new SoftcakeException(ex, response);
		}
		return result;
    }
	
}
