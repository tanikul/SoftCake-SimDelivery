package com.softcake.sim.utils;

import java.security.Key;
import java.util.Base64;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.impl.crypto.MacProvider;

public class Constants {

	public static final String SUCCESS = "1";
	public static final Key SECRET = MacProvider.generateKey(SignatureAlgorithm.HS256);
	private static final byte[] SECRETBYTES = SECRET.getEncoded();
	public static final String BASE64SECRETBYTES = Base64.getEncoder().encodeToString(getSecretBytes());
	public static final String ACCESS_EXCEPT_VIEWER = "hasRole({@props.checker}) OR hasRole({@props.maker})";
	public static final String ACCESS_EXCEPT_MAKER = "hasRole({@props.checker}) OR hasRole({@props.viewer})";
	public static final String ACCESS_EXCEPT_CHECKER = "hasRole({@props.viewer}) OR hasRole({@props.maker})";
	public static final String ACCESS_MAKER = "hasRole({@props.maker})";
	public static final String ACCESS_CHECKER = "hasRole({@props.checker})";
	public static final String ACCESS_VIEWER = "hasRole({@props.viewer})";
	public static final String ROLE_ADMIN = "Admin";
	public static final String ROLE_USER = "USER";
	public static final String ROLE_SUPERADMIN = "Super Admin";
	public static final String ROLE_DATAENTRY = "Data Entry";
	
	private Constants() {
	}
	
	public static byte[] getSecretBytes() {
	    return SECRETBYTES;
	}
}
