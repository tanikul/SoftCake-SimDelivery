package com.softcake.sim.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.security.KeyStore;
import java.security.SecureRandom;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManagerFactory;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.codehaus.jackson.jaxrs.JacksonJaxbJsonProvider;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.softcake.sim.beans.User;
import com.softcake.sim.common.SoftcakeException;
import com.softcake.sim.datatable.DataTable;
import com.softcake.sim.datatable.SearchDataTable;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.json.JSONConfiguration;

@Component
public class AppUtils {
	
	private static final Logger logger = Logger.getLogger(AppUtils.class);
	
	@Value("${web.api.url}") 
	private String apiUrl;
    
	@Value("${web.default.url}") 
	private String webUrl;
	
	public String post(String path){
		String output = "";
		try {
			ClientConfig config = new DefaultClientConfig();
		    config.getClasses().add(JacksonJaxbJsonProvider.class);
		    config.getFeatures().put(JSONConfiguration.FEATURE_POJO_MAPPING, Boolean.TRUE);
			Client client = Client.create(config);
		
			WebResource webResource = client
			   .resource(apiUrl + encodeURL(path));
			HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			
			ClientResponse response = webResource.accept("application/json")
					   .header("Authorization", getUserLogin().getTokenId())
					   .type("application/json").post(ClientResponse.class);
		
			if (response.getStatus() != 200) {
			   throw new RuntimeException("Failed : HTTP error code : "
				+ response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch(Exception ex){
			ex.printStackTrace();
		}
		return output;
	}
	
	public String post(String path, Map<?, ?> obj) throws Exception{
		String output = "";
		try {
			ClientConfig config = new DefaultClientConfig();
		    config.getClasses().add(JacksonJaxbJsonProvider.class);
		    config.getFeatures().put(JSONConfiguration.FEATURE_POJO_MAPPING, Boolean.TRUE);
			Client client = Client.create(config);
			String str = JSONObject.toJSONString(obj);
			WebResource webResource = client
			   .resource(apiUrl + encodeURL(path));
			ClientResponse response = null;
			logger.info("webResource : " + webResource.getURI());
			if((Authentication) SecurityContextHolder.getContext().getAuthentication() == null){
				response = webResource.accept("application/json")
						.type("application/json").post(ClientResponse.class, str);
			}else{
				HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
				response = webResource.accept("application/json")
						.header("Authorization", getUserLogin().getTokenId())
						.type("application/json").post(ClientResponse.class, str);
			}
			if (response.getStatus() != 200) {
				ObjectMapper mapper = new ObjectMapper();
				throw new SoftcakeException(mapper.readValue(response.getEntity(String.class), SoftcakeException.class));				
			}
			output = response.getEntity(String.class);
		} catch(Exception ex){
			logger.error(ex);
			throw ex;
		}
		return output;
	}
	
	public String post(String path, Object obj) throws Exception{
		String output = "";
		try {
			ClientConfig config = new DefaultClientConfig();
		    config.getClasses().add(JacksonJaxbJsonProvider.class);
		    config.getFeatures().put(JSONConfiguration.FEATURE_POJO_MAPPING, Boolean.TRUE);
			Client client = Client.create(config);
			ObjectMapper mapper = new ObjectMapper();
			String str = null;
			if(!(obj instanceof String)){
				str = mapper.writeValueAsString(obj);	
			}else{
				str = (String) obj;
			}
			WebResource webResource = client
			   .resource(apiUrl + encodeURL(path));
			HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			
			ClientResponse response = webResource.accept("application/json")
					.header("Authorization", getUserLogin().getTokenId())
					.type("application/json").post(ClientResponse.class, str);
			
			if (response.getStatus() != 200) {
				mapper = new ObjectMapper();
				throw new SoftcakeException(mapper.readValue(response.getEntity(String.class), SoftcakeException.class));				
			}
			output = response.getEntity(String.class);
		} catch(Exception ex){
			logger.error(ex);
			throw ex;
		}
		return output;
	}

	public String postWithoutAuthen(String path, Object obj) throws Exception{
		String output = "";
		try {
			ClientConfig config = new DefaultClientConfig();
		    config.getClasses().add(JacksonJaxbJsonProvider.class);
		    config.getFeatures().put(JSONConfiguration.FEATURE_POJO_MAPPING, Boolean.TRUE);
			Client client = Client.create(config);
			ObjectMapper mapper = new ObjectMapper();
			String str = null;
			if(!(obj instanceof String)){
				str = mapper.writeValueAsString(obj);	
			}else{
				str = (String) obj;
			}
			WebResource webResource = client
			   .resource(apiUrl + encodeURL(path));
			
			ClientResponse response = webResource.accept("application/json")
					.type("application/json").post(ClientResponse.class, str);
			
			if (response.getStatus() != 200) {
				mapper = new ObjectMapper();
				throw new SoftcakeException(mapper.readValue(response.getEntity(String.class), SoftcakeException.class));				
			}
			output = response.getEntity(String.class);
		} catch(Exception ex){
			logger.error(ex);
			throw ex;
		}
		return output;
	}
	
	@SuppressWarnings("unchecked")
	public <T> DataTable<T> postDataTable(String path, SearchDataTable<T> params, Class<T> obj) throws Exception{
		DataTable<T> output = null;
		try {
			ClientConfig config = new DefaultClientConfig();
		    config.getClasses().add(JacksonJaxbJsonProvider.class);
		    config.getFeatures().put(JSONConfiguration.FEATURE_POJO_MAPPING, Boolean.TRUE);
			Client client = Client.create(config);
			ObjectMapper mapper = new ObjectMapper();
			String str = mapper.writeValueAsString(params);
			WebResource webResource = client
			   .resource(apiUrl + encodeURL(path));
			
			HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			
			ClientResponse response = webResource.accept("application/json")
					.header("Authorization", getUserLogin().getTokenId())
					.type("application/json").post(ClientResponse.class, str);
			
			if (response.getStatus() != 200) {
				mapper = new ObjectMapper();
				throw new SoftcakeException(mapper.readValue(response.getEntity(String.class), SoftcakeException.class));				
			}
			output = response.getEntity(DataTable.class);
		} catch(Exception ex){
			logger.error(ex);
			throw ex;
		}
		return output;
	}
	
	public String getWithoutAuthen(String path) throws Exception {
		String output = "";
		try {
			
			ClientConfig config = new DefaultClientConfig();
		    config.getClasses().add(JacksonJaxbJsonProvider.class);
		    config.getFeatures().put(JSONConfiguration.FEATURE_POJO_MAPPING, Boolean.TRUE);
			Client client = Client.create(config);
			WebResource webResource = client
			   .resource(apiUrl + encodeURL(path));
			
			ClientResponse response = webResource.accept("application/json")
					.get(ClientResponse.class);
			
			if (response.getStatus() != 200) {
				ObjectMapper mapper = new ObjectMapper();
				throw new SoftcakeException(mapper.readValue(response.getEntity(String.class), SoftcakeException.class));				
			}
			output = response.getEntity(String.class);
		} catch(Exception ex){
			throw ex;
		}
		return output;
	}
	
	public String get(String path) throws Exception {
		String output = "";
		try {
			
			ClientConfig config = new DefaultClientConfig();
		    config.getClasses().add(JacksonJaxbJsonProvider.class);
		    config.getFeatures().put(JSONConfiguration.FEATURE_POJO_MAPPING, Boolean.TRUE);
			Client client = Client.create(config);
			WebResource webResource = client
			   .resource(apiUrl + encodeURL(path));
			HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			
			ClientResponse response = webResource.accept("application/json")
					.header("Authorization", getUserLogin().getTokenId())
					.get(ClientResponse.class);
			
			if (response.getStatus() != 200) {
				ObjectMapper mapper = new ObjectMapper();
				throw new SoftcakeException(mapper.readValue(response.getEntity(String.class), SoftcakeException.class));				
			}
			output = response.getEntity(String.class);
		} catch(Exception ex){
			throw ex;
		}
		return output;
	}
	
	
	public User getUserLogin(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(authentication != null){
			boolean hasUserRole = authentication.getAuthorities().stream()
			          .anyMatch(r -> r.getAuthority().equals("ROLE_ANONYMOUS"));
			if(!hasUserRole){
				return (User) SecurityContextHolder.getContext().getAuthentication().getDetails();
			}else {
				return null;
			}
		}else {
			return null;
		}
	}
	
	public String getRoleUserLogin(){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Set<String> roles = AuthorityUtils.authorityListToSet(auth.getAuthorities());
		String result = "";
		for(String role : roles){
			result = role;
		}
		return result;
	}
	
	public String convertObjectToJson(Object obj) throws JsonProcessingException{
		ObjectMapper mapper = new ObjectMapper();
		String result = "";
		try {
			result = mapper.writeValueAsString(obj);
		} catch (JsonProcessingException e) {
			throw e;
		}
		return result;
	}
	
	public static SSLContext connectSSLRestService(String keyStore, String keyStorePassword, String trustStore, String trustStorePassword, String SSLcontext){
		SSLContext context = null;
		try {
			KeyStore ks = KeyStore.getInstance("JKS");
	        
	        File pKeyFile = new File(keyStore);
	        InputStream keyInput = new FileInputStream(pKeyFile);
	        ks.load(keyInput, keyStorePassword.toCharArray());
	        logger.info("Loaded keystore: " + keyInput);
	        
	        KeyManagerFactory keyManagerFactory = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm());
	        keyManagerFactory.init(ks, keyStorePassword.toCharArray());
	
	        KeyStore ts = KeyStore.getInstance("JKS");
	        File tKeyFile = new File(trustStore);
	        InputStream tKeyInput = new FileInputStream(tKeyFile);
	        ts.load(tKeyInput, trustStorePassword.toCharArray());
	        logger.info("Loaded trustStore: " + tKeyInput);
	       
	        TrustManagerFactory trustManagerFactory = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
	        trustManagerFactory.init(ts);
	
	       /* messageSender = new HttpsUrlConnectionMessageSender();
	        messageSender.setKeyManagers(keyManagerFactory.getKeyManagers());
	        messageSender.setTrustManagers(trustManagerFactory.getTrustManagers());*/
	
	        context = SSLContext.getInstance(SSLcontext);
	        context.init(keyManagerFactory.getKeyManagers(), null, new SecureRandom());
	       
		} catch(Exception ex){
			logger.error(ex);
		}
		return context;
	}
	
	public void jsonResponse(HttpServletResponse response, boolean success, String errorCode){
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.setStatus(HttpStatus.OK.value());
		Map<String, Object> obj = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		mapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);
		mapper.setDateFormat(dateFormat);
		PrintWriter out;
		try {
			out = response.getWriter();
			if (success) {
				obj.put("success", success);
				obj.put("message", errorCode);
			} else {
				obj.put("success", success);
				obj.put("message", errorCode);
			}
			out.println(mapper.writeValueAsString(obj));
			out.close();
		} catch (IOException e1) {
			logger.error("outputFormJson-IOException => " + e1);
		}
	}
	
	private String encodeURL(String path) throws UnsupportedEncodingException{
		String result = "";
		String[] arrPath = path.split("/");
		for(String str : arrPath){
			if(!"".equals(str)){
				if(str.contains("?")){
					String param = str.substring(str.indexOf("?") + 1, str.length());
					String[] params = param.split("&");
					result +=  "/" + URLEncoder.encode(str.substring(0, str.indexOf("?")), "UTF-8") + "?";
					for(String p : params){
						String key = p.substring(0, p.indexOf("=") + 1);
						String value = p.substring(p.indexOf("=") + 1, p.length());
						result += key + URLEncoder.encode(value, "UTF-8") + "&";
					}
					result = result.substring(0, result.length() - 1);
				}else{
					result += "/" + URLEncoder.encode(str, "UTF-8");
				}
			}
		}
		return result;
	}
	
	public int calculateSim(String simNumber){
		int result = 0;
		String[] ary = simNumber.replaceAll("-", "").split("");
		for(int i = 0; i < ary.length; i++){
			if(!StringUtils.isEmpty(ary[i])) {
				result += Integer.parseInt(ary[i]);
			}
		}
		return result;
	}
	
	public String parseSimFormat(String simNumber){
		if(StringUtils.isEmpty(simNumber)) {
			return "";
		}
		simNumber = simNumber.replaceAll("-", "");
		if("-".equals(simNumber.substring(3, 4)) && "-".equals(simNumber.substring(6, 7)) && "-".equals(simNumber.substring(10, 11))) {
			return simNumber;
		}
		return simNumber.substring(0, 3) + "-" + simNumber.substring(3, 6) + "-" + simNumber.substring(6, 10);
	}
	
	public String removeSimFormat(String simNumber){
		return simNumber.replaceAll("-", "");
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public <T> Class<T> convertListClass(Object obj){
		Class<List<Object>> clazz = (Class) List.class;
		return (Class<T>) clazz;
	}
	
	public String BigDecimalToCurrencyFormat(BigDecimal val) {
		 return new DecimalFormat("#,###.00").format(val);
	}

	public String getApiUrl() {
		return apiUrl;
	}

	public void setApiUrl(String apiUrl) {
		this.apiUrl = apiUrl;
	}

	public String getWebUrl() {
		return webUrl;
	}

	public void setWebUrl(String webUrl) {
		this.webUrl = webUrl;
	}
	
}
