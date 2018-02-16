package com.softcake.sim.common;
 
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.softcake.sim.beans.User;
import com.softcake.sim.utils.AppUtils;
 
@Service("userDetailService")
public class UserDetailService implements UserDetailsService {
 
	@Autowired
	@Qualifier("appUtils")
	AppUtils app;
 
	@Override
	public UserDetails loadUserByUsername(final String username) 
               throws UsernameNotFoundException {
 
		User user = new User();
		List<GrantedAuthority> authorities = buildUserAuthority(user.getRole());
		return buildUserForAuthentication(user, authorities);
	}
 
	private org.springframework.security.core.userdetails.User buildUserForAuthentication(com.softcake.sim.beans.User user, 
		List<GrantedAuthority> authorities) {
		return new org.springframework.security.core.userdetails.User(user.getUserId(), user.getPassword(), authorities);
	}
 
	private List<GrantedAuthority> buildUserAuthority(String userRole) {
		Set<GrantedAuthority> setAuths = new HashSet<GrantedAuthority>();
		setAuths.add(new SimpleGrantedAuthority(userRole));
		List<GrantedAuthority> Result = new ArrayList<GrantedAuthority>(setAuths);
		return Result;
	}

	
	public AppUtils getApp() {
		return app;
	}

	public void setApp(AppUtils app) {
		this.app = app;
	}
	
}