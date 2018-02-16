package com.softcake.sim.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import com.softcake.sim.beans.JsonMapper;
import com.softcake.sim.beans.User;
import com.softcake.sim.utils.AppUtils;

@Component
public class LoginAuthenticationProvider implements AuthenticationProvider {
	
	@Autowired
	private AppUtils app;
	
	public Authentication assignRole(Authentication authenticate, List<GrantedAuthority> grantedAuths){
		User user = (User) authenticate.getDetails();
        return new CustomUsernamePasswordAuthenticationToken(authenticate.getName(), user.getTokenId(), grantedAuths, (User) authenticate.getDetails());
    }
	
    @Override
    public Authentication authenticate(Authentication authentication) 
            throws AuthenticationException {
    	try {
    		String username = authentication.getName();
            String password = authentication.getCredentials().toString();
            User userParam = new User(); 
            userParam.setUserId(username);
            userParam.setPassword(password);
            String token = app.postWithoutAuthen("/login", userParam);
            List<GrantedAuthority> grantedAuths = new ArrayList<>();
            JsonMapper<User> user = new JsonMapper<>(token, User.class);
            grantedAuths.add(new SimpleGrantedAuthority(user.getResult().getRole()));
            return new CustomUsernamePasswordAuthenticationToken(username, user.getResult().getTokenId(), grantedAuths, user.getResult());
    	}catch(Exception ex){
    		throw new BadCredentialsException(ex.getMessage());
    	}
    }
    
    /*@Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }*/
    
    @Override
    public boolean supports(Class<? extends Object> authentication) {
        return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
    }
    
   public AppUtils getApp() {
		return app;
	}

	public void setApp(AppUtils app) {
		this.app = app;
	}
	
}