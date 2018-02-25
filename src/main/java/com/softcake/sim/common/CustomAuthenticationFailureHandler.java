package com.softcake.sim.common;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.authentication.session.SessionAuthenticationException;

public class CustomAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler { 

	@Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {

		/*if(exception.getClass().isAssignableFrom(BadCredentialsException.class)) {
		        setDefaultFailureUrl("/url1");
		}else if (exception.getClass().isAssignableFrom(DisabledException.class)) {         
		      setDefaultFailureUrl("/url2");
		}else if (exception.getClass().isAssignableFrom(SessionAuthenticationException.class)) {       
		      setDefaultFailureUrl("/url3");    
		}*/
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
		PrintWriter out;
		try {
			out = response.getWriter();
			out.println(exception.getMessage());
			out.close();
		} catch (IOException e1) {
			logger.error("outputFormJson-IOException => " + e1);
		}
		
    }
}
