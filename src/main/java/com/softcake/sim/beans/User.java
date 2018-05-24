package com.softcake.sim.beans;

import java.io.Serializable;
import java.util.Date;
import java.util.List;


public class User extends BaseDomain implements Serializable {

	private static final long serialVersionUID = 2863585162742337849L;

	private String userId;
	private String password;
	private int prefix;
	private String prefixName;
	private String firstName;
	private String lastName;
	private String tokenId;
	private String activeStatus;
	private Date lastLoggedOn;
	private String role;
	private String userType;
	private String nickName;
	private String line;
	private String website;
	private String address;
	private int province;
	private String provinceStr;
	private String postcode;
	private String mobile;
	private String email;
	private String activateEmail;
	private RoleJson roleJson;
    private List<PrivilegeJson> privilegeJsons;
    private String forgotPassword;
    private int cntBooking;
    private int cntRequest;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getPrefix() {
		return prefix;
	}
	public void setPrefix(int prefix) {
		this.prefix = prefix;
	}
	public String getPrefixName() {
		return prefixName;
	}
	public void setPrefixName(String prefixName) {
		this.prefixName = prefixName;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getTokenId() {
		return tokenId;
	}
	public void setTokenId(String tokenId) {
		this.tokenId = tokenId;
	}
	public String getActiveStatus() {
		return activeStatus;
	}
	public void setActiveStatus(String activeStatus) {
		this.activeStatus = activeStatus;
	}
	public Date getLastLoggedOn() {
		return lastLoggedOn;
	}
	public void setLastLoggedOn(Date lastLoggedOn) {
		this.lastLoggedOn = lastLoggedOn;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getProvince() {
		return province;
	}
	public void setProvince(int province) {
		this.province = province;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getActivateEmail() {
		return activateEmail;
	}
	public void setActivateEmail(String activateEmail) {
		this.activateEmail = activateEmail;
	}
	public RoleJson getRoleJson() {
		return roleJson;
	}
	public void setRoleJson(RoleJson roleJson) {
		this.roleJson = roleJson;
	}
	public List<PrivilegeJson> getPrivilegeJsons() {
		return privilegeJsons;
	}
	public void setPrivilegeJsons(List<PrivilegeJson> privilegeJsons) {
		this.privilegeJsons = privilegeJsons;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getLine() {
		return line;
	}
	public void setLine(String line) {
		this.line = line;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getProvinceStr() {
		return provinceStr;
	}
	public void setProvinceStr(String provinceStr) {
		this.provinceStr = provinceStr;
	}
	public String getForgotPassword() {
		return forgotPassword;
	}
	public void setForgotPassword(String forgotPassword) {
		this.forgotPassword = forgotPassword;
	}
	public int getCntBooking() {
		return cntBooking;
	}
	public void setCntBooking(int cntBooking) {
		this.cntBooking = cntBooking;
	}
	public int getCntRequest() {
		return cntRequest;
	}
	public void setCntRequest(int cntRequest) {
		this.cntRequest = cntRequest;
	}
	
}
