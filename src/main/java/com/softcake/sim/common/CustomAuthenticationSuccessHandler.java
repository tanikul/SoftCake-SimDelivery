package com.softcake.sim.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.softcake.sim.beans.User;
import com.softcake.sim.utils.Constants;


@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	 
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
		HttpServletResponse response, Authentication authentication) throws IOException,
		ServletException {
		User user = (User) authentication.getDetails();
		request.getSession().setAttribute("userInfo", user);
		/*UserLogin user = (UserLogin) SecurityContextHolder.getContext().getAuthentication().getDetails();
		request.getSession().setMaxInactiveInterval(60 * Integer.parseInt(sessionTimeout));
		request.getSession().setAttribute("generateMenu", menu.getMenu());
		request.getSession().setAttribute("userInfo", user);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		if(user!=null && user.getLastLogin()!=null) {
			String lastLogin = dateFormat.format(user.getLastLogin());
			request.getSession().setAttribute("lastLogin", lastLogin);
		}*/
		
		//String targetUrl = determineTargetUrl(authentication); 
		//redirectStrategy.sendRedirect(request, response, targetUrl);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.setStatus(HttpStatus.OK.value());
		PrintWriter out;
		try {
			out = response.getWriter();
			out.println(Constants.SUCCESS);
			out.close();
		} catch (IOException e1) {
		}
	}
	
	protected String determineTargetUrl(Authentication authentication) {
		return "";
	}
	
	public RedirectStrategy getRedirectStrategy() {
		return redirectStrategy;
	}
	
	public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
		this.redirectStrategy = redirectStrategy;
	}
}

