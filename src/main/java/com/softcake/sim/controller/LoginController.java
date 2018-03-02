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
import com.softcake.sim.beans.LoginValidator;
import com.softcake.sim.beans.User;
import com.softcake.sim.common.CustomAuthenticationSuccessHandler;
import com.softcake.sim.common.LoginAuthenticationProvider;
import com.softcake.sim.common.SoftcakeException;
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
	
	@Autowired
	@Qualifier("authenticationManager")
	LoginAuthenticationProvider loginProvider;
	
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
			Authentication authen = loginProvider.authenticate(new UsernamePasswordAuthenticationToken(username, ""));
			authenSuccess.onAuthenticationSuccess(request, response, authen);
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
	public String Signup(@RequestBody User user,
			final HttpServletResponse response) throws SoftcakeException {
		String str = "";
		try {
			str = app.postWithoutAuthen("/user/signup", user);
		} catch(Exception ex){
			logger.error(ex);
			throw new SoftcakeException(ex, response);  
		}
		return str;
	}
	
	@RequestMapping(value = "/User/CheckDuplicateUser", method = RequestMethod.POST, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String CheckDuplicateUser(@RequestBody Map<String, String> str, 
			final HttpServletResponse response) throws SoftcakeException  {
		String result = null;
		try {
			result = app.postWithoutAuthen("/user/checkDuplicateUser",  str.get("userId"));
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
}
