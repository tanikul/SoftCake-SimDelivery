package com.softcake.sim.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.stereotype.Component;

import com.softcake.sim.beans.JsonMapper;
import com.softcake.sim.beans.User;
import com.softcake.sim.utils.AppUtils;

public class LoginAuthenticationFilter extends UsernamePasswordAuthenticationFilter {

	@Autowired
	private AppUtils app;
	
	@Autowired
	@Qualifier("authenticationManager")
	private AuthenticationManager authenticationManager;
	
	@Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
		try {
			if(request.getParameter("email") != null) {
				User userParam = new User(); 
				userParam.setEmail(request.getParameter("email"));
				String token = app.postWithoutAuthen("/checkLoginWithEmail", userParam);
				JsonMapper<User> user = new JsonMapper<>(token, User.class);
				List<GrantedAuthority> grantedAuths = new ArrayList<>();
				grantedAuths.add(new SimpleGrantedAuthority(user.getResult().getRole()));
	    	    AbstractAuthenticationToken authentication =  new CustomUsernamePasswordAuthenticationToken(user.getResult().getUserId(), user.getResult().getTokenId(), grantedAuths, user.getResult());
	    	    return authentication;
			}else {
				Map<String, Object> captcha = VerifyRecaptcha.verify(request.getParameter("recaptcha"));
	            if(captcha.get("CODE").equals(200)){
	            	String username = request.getParameter("username");
	    	        String password = request.getParameter("password");
	    	        User userParam = new User(); 
	    	        userParam.setUserId(username);
	    	        userParam.setPassword(password);
	    	        String token = app.postWithoutAuthen("/login", userParam);
	    	        List<GrantedAuthority> grantedAuths = new ArrayList<>();
	    	        JsonMapper<User> user = new JsonMapper<>(token, User.class);
	    	        grantedAuths.add(new SimpleGrantedAuthority(user.getResult().getRole()));
	    	        AbstractAuthenticationToken authentication =  new CustomUsernamePasswordAuthenticationToken(username, user.getResult().getTokenId(), grantedAuths, user.getResult());
	    	        return authentication;
	            } else {
	            	throw new BadCredentialsException(captcha.get("MSG").toString());
	            }
			}
		}catch(Exception ex){
    		throw new BadCredentialsException(ex.getMessage());
    	}
    } 
	
	@Override
	public void setAuthenticationManager(AuthenticationManager authenticationManager) {
	    super.setAuthenticationManager(authenticationManager);
	}


	public AppUtils getApp() {
		return app;
	}

	public void setApp(AppUtils app) {
		this.app = app;
	}
}
