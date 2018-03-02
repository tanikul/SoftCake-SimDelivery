package com.softcake.sim.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softcake.sim.common.SoftcakeException;
import com.softcake.sim.utils.AppUtils;

@Controller
@RequestMapping("/MasterSetup")
public class MasterSetupController {

	private static final Logger logger = Logger.getLogger(MasterSetupController.class);
	
	@Autowired
	private AppUtils app;
	
	@RequestMapping(value = "LoadProvince", method = RequestMethod.GET, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String loadCorporation(final HttpServletResponse response) throws SoftcakeException  {
		String result = null;
		try {
			result = app.getWithoutAuthen("/masterSetup/loadProvince");
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "LoadMasterSetup/{group}", method = RequestMethod.GET, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String loadCorporation(@PathVariable String group,
			final HttpServletResponse response) throws SoftcakeException  {
		String result = null;
		try {
			result = app.getWithoutAuthen("/masterSetup/loadMasterSetup/" + group);
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
	
	@RequestMapping(value = "LoadRole", method = RequestMethod.GET, produces="application/json;charset=UTF-8",headers = {"Accept=text/xml, application/json"})
	@ResponseBody
	public String loadRole(final HttpServletResponse response) throws SoftcakeException  {
		String result = null;
		try {
			result = app.getWithoutAuthen("/masterSetup/loadRole");
		} catch (Exception e) {
			logger.error(e);
			throw new SoftcakeException(e, response);
		}
		return result;
	}
}
