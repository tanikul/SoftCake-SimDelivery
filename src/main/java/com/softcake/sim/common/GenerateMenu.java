package com.softcake.sim.common;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.softcake.sim.beans.PrivilegeJson;
import com.softcake.sim.beans.ProgramJson;
import com.softcake.sim.beans.User;

public class GenerateMenu {

	private String url;
	
	private String menu;
	
	private List<PrivilegeJson> menuDefault;
	
	public void init(){
		try {
			Authentication auth = SecurityContextHolder.getContext()
					.getAuthentication();
			if(auth != null){
				User user = (User) auth.getDetails();
				this.genMenu(user.getPrivilegeJsons());
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	public void genMenu(List<PrivilegeJson> privilegeJsons){
		String base = this.getUrl();
		int groupLevel = 0;
		TreeMap tm = new TreeMap();
		TreeMap tmp = new TreeMap();
		String strMenu = "";
		for(PrivilegeJson privilege : privilegeJsons){
			if(groupLevel != privilege.getProgramJson().getGroupLevel()){
				if(groupLevel > 0) {
					if(tmp.entrySet().size() == 1){
						Set set = tmp.entrySet();
						Iterator i = set.iterator();
						while(i.hasNext()) {
					    	Map.Entry me = (Map.Entry)i.next();
					    	ProgramJson pg = (ProgramJson) me.getValue();
					    	strMenu += "<li><a href=\"" + base + pg.getProgramRef() + "\"> " + pg.getProgramName() + "</a></li>";
							
						}
						tmp = new TreeMap();
					}else{
						Set set = tmp.entrySet();
						Iterator i = set.iterator();
					    int j = 0;
						while(i.hasNext()) {
					    	Map.Entry me = (Map.Entry)i.next();
					    	ProgramJson pg = (ProgramJson) me.getValue();
					    	if(j == 0){
					    		strMenu += "<li><a href=\"javascript:void(0);\"> " + pg.getProgramGroup() + "</a>";
					    		strMenu += "<div class=\"sub-menu\">";
					    		strMenu += "<ul class=\"list-bl-grey\">";
					    		strMenu += "<li><a href=\"" + base + pg.getProgramRef() + "\"> " + pg.getProgramName() + "</a></li>";
					    	}else{
					    		strMenu += "<li><a href=\"" + base + pg.getProgramRef() + "\"> " + pg.getProgramName() + "</a></li>";
					    	}
					    	j++;
						}
						tmp = new TreeMap();
						strMenu += "</ul></div></li>";
					}
				}
			}
			tmp.put(privilege.getProgramJson().getProgramLevel(), privilege.getProgramJson());
			groupLevel = privilege.getProgramJson().getGroupLevel();
		}
		if(tmp.entrySet().size() == 1){
	    	Map.Entry me = (Map.Entry)tmp.entrySet().iterator().next();
	    	ProgramJson pg = (ProgramJson) me.getValue();
	    	strMenu += "<li><a href=\"" + base + pg.getProgramRef() + "\"> " + pg.getProgramName() + "</a></li>";
		}else if(tmp.entrySet().size() > 1){
			Set set = tmp.entrySet();
			Iterator i = set.iterator();
		    int j = 0;
			while(i.hasNext()) {
		    	Map.Entry me = (Map.Entry)i.next();
		    	ProgramJson pg = (ProgramJson) me.getValue();
		    	if(j == 0){
		    		strMenu += "<li><a href=\"javascript:void(0);\"> " + pg.getProgramGroup() + "</a>";
		    		strMenu += "<div class=\"sub-menu\">";
		    		strMenu += "<ul class=\"list-bl-grey\">";
		    		strMenu += "<li><a href=\"" + base + pg.getProgramRef() + "\"> " + pg.getProgramName() + "</a></li>";
		    	}else{
		    		strMenu += "<li><a href=\"" + base + pg.getProgramRef() + "\"> " + pg.getProgramName() + "</a></li>";
		    	}
		    	j++;
			}
			tmp = new TreeMap();
			strMenu += "</ul></div></li>";
		}
		
		this.setMenu(strMenu);
	}
	
	public String getMenu() {
		return menu;
	}

	public void setMenu(String menu) {
		this.menu = menu;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<PrivilegeJson> getMenuDefault() {
		return menuDefault;
	}

	public void setMenuDefault(List<PrivilegeJson> menuDefault) {
		this.menuDefault = menuDefault;
	}

}
