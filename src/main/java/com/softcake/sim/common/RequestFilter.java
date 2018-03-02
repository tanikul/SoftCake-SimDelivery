package com.softcake.sim.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.softcake.sim.beans.JsonMapper;
import com.softcake.sim.beans.ListPrivileges;
import com.softcake.sim.beans.PrivilegeJson;
import com.softcake.sim.beans.User;
import com.softcake.sim.utils.AppUtils;


@WebFilter(urlPatterns={"/"})
public class RequestFilter implements Filter {
	
	private String viewer;
	private String maker;
	private String checker;
	
	
	private static final Set<String> ALLOWED_PATHS = Collections.unmodifiableSet(new HashSet<>(
	        Arrays.asList("", "Profile", "Logout", "fonts", "font-awesome", "vendors", "images",
	        		"js", "css")));
	
	@Override
    public void destroy() {
        // Do nothing
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
        FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        
        /*if (session == null) {
        	try {
        		AppUtils app = (AppUtils) ApplicationContextHolder.getContext().getBean("app");
            	UserLogin user =  app.getUserLogin();
				app.post("/logout", user);
				SecurityContextHolder.clearContext();
	        	request.getRequestDispatcher("/login").forward(request, response);	
			} catch (Exception e) {
				SecurityContextHolder.clearContext();
	        	request.getRequestDispatcher("/login").forward(request, response);	
			}
        	SecurityContextHolder.clearContext();
        	request.getRequestDispatcher("/login").forward(request, response);	
        }*/
        if(request.getSession().getAttribute("generateMenu") == null){
        	 AppUtils app = (AppUtils) ApplicationContextHolder.getContext().getBean("app");
			 String str = "";
			 try {
				str = app.getWithoutAuthen("/user/getRightUserDefault");
				JsonMapper<ListPrivileges> result = new JsonMapper<>(str, ListPrivileges.class);
				 //List<PrivilegeJson> list = (List<PrivilegeJson>) new JsonMapper<List<PrivilegeJson>>(str, app.convertListClass(PrivilegeJson.class)).getResult();
				 GenerateMenu menu = (GenerateMenu) ApplicationContextHolder.getContext().getBean("generateMenu");
				 menu.genMenu(result.getResult().getList());
				 request.getSession().setAttribute("generateMenu", menu.getMenu());
			 } catch (Exception e) {
				e.printStackTrace();
			 }
			 
		 }
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean chk = true;
        if(authentication != null){
        	if(authentication.getDetails() != null){
        		if(authentication.getDetails() instanceof User){
        			boolean accessDenied = false;
        			User user = (User) authentication.getDetails();
	            	List<GrantedAuthority> grantedAuths = new ArrayList<>();
	            	String path = ((HttpServletRequest) request).getServletPath();
	            	for(PrivilegeJson privilege : user.getPrivilegeJsons()){
	            		if(path.startsWith(privilege.getProgramJson().getProgramRef()) && !StringUtils.isEmpty(privilege.getProgramJson().getProgramRef())){
	            			accessDenied = true;
	            			LoginAuthenticationProvider login = new LoginAuthenticationProvider();
	            			if("Y".equals(privilege.getMaker())){
	            				grantedAuths.add(new SimpleGrantedAuthority(this.getMaker()));
	            				SecurityContextHolder.getContext().setAuthentication(login.assignRole(authentication, grantedAuths));
	            			}else if("Y".equals(privilege.getChecker())){
	            				grantedAuths.add(new SimpleGrantedAuthority(this.getChecker()));
	            				SecurityContextHolder.getContext().setAuthentication(login.assignRole(authentication, grantedAuths));
	            			}else if("Y".equals(privilege.getViewer())){
	            				grantedAuths.add(new SimpleGrantedAuthority(this.getViewer()));
	            				SecurityContextHolder.getContext().setAuthentication(login.assignRole(authentication, grantedAuths));
	            			}
	            		}
	            	}
	            	
	            	if(!accessDenied){
	            		String[] arrPath = path.substring(1, path.length()).split("/");
	            		if (!ALLOWED_PATHS.contains(arrPath[0]) && !path.startsWith("/MasterSetup")){
	            			response.setStatus(HttpServletResponse.SC_FORBIDDEN);
	            			request.getRequestDispatcher("/errors").forward(request, response);
		            		chk = false;
		            	}
	            	}
        		}
        	}
        }
        
        if(chk) chain.doFilter(req, res);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    	PropertyHolderSystem bean = (PropertyHolderSystem) WebApplicationContextUtils.
				  getRequiredWebApplicationContext(filterConfig.getServletContext()).
				  getBean(PropertyHolderSystem.class);
    	this.setChecker(bean.getChecker());
		this.setMaker(bean.getMaker());
		this.setViewer(bean.getViewer());
    }

	public String getViewer() {
		return viewer;
	}

	public void setViewer(String viewer) {
		this.viewer = viewer;
	}

	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	public String getChecker() {
		return checker;
	}

	public void setChecker(String checker) {
		this.checker = checker;
	}
}
