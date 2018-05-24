package com.softcake.sim.common;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class VerifyRecaptcha {

	@Value("${captcha.secretKey}") 
	private static String secret;

	@Value("${captcha.googleUrl}") 
	private static String url;
	
	private final static String USER_AGENT = "Mozilla/5.0";
	
	public static Map<String, Object> verify(String gRecaptchaResponse) throws IOException {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			if (gRecaptchaResponse == null || "".equals(gRecaptchaResponse)) {
				result.put("CODE", 500);
				result.put("MSG", "กรุณายืนยันตัวตน");
			}
			URL obj = new URL(url);
			HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
	
			con.setRequestMethod("POST");
			con.setRequestProperty("User-Agent", USER_AGENT);
			con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
	
			String postParams = "secret=" + secret + "&response="
					+ gRecaptchaResponse;
	
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(postParams);
			wr.flush();
			wr.close();
	
			int responseCode = con.getResponseCode();
			BufferedReader in = new BufferedReader(new InputStreamReader(
					con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();
	
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			result.put("CODE", responseCode);
			result.put("MSG", response.toString());
		}catch(Exception e){
			throw e;
		}
		return result;
	}

	public static String getSecret() {
		return secret;
	}

	public static void setSecret(String secret) {
		VerifyRecaptcha.secret = secret;
	}

	public static String getUrl() {
		return url;
	}

	public static void setUrl(String url) {
		VerifyRecaptcha.url = url;
	}
	
}
