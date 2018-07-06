package com.softcake.sim.beans;

import java.util.Date;
import java.util.List;

public class RequestMst extends BaseDomain {

	private String requestId;
	private String requestType;
	private String requestTypeStr;
	private String merchantId;
	private String requestValue;
	private String requestStatus;
	private Date authorizedDate;
	private String authorizedBy;
	private Date requestDate;
	private String rejectReason;
	private List<RequestSim> requestSim;
	
	public String getRequestId() {
		return requestId;
	}
	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}
	public String getRequestType() {
		return requestType;
	}
	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}
	public String getMerchantId() {
		return merchantId;
	}
	public void setMerchantId(String merchantId) {
		this.merchantId = merchantId;
	}
	public String getRequestValue() {
		return requestValue;
	}
	public void setRequestValue(String requestValue) {
		this.requestValue = requestValue;
	}
	public String getRequestStatus() {
		return requestStatus;
	}
	public void setRequestStatus(String requestStatus) {
		this.requestStatus = requestStatus;
	}
	public Date getAuthorizedDate() {
		return authorizedDate;
	}
	public void setAuthorizedDate(Date authorizedDate) {
		this.authorizedDate = authorizedDate;
	}
	public String getAuthorizedBy() {
		return authorizedBy;
	}
	public void setAuthorizedBy(String authorizedBy) {
		this.authorizedBy = authorizedBy;
	}
	public Date getRequestDate() {
		return requestDate;
	}
	public void setRequestDate(Date requestDate) {
		this.requestDate = requestDate;
	}
	public List<RequestSim> getRequestSim() {
		return requestSim;
	}
	public void setRequestSim(List<RequestSim> requestSim) {
		this.requestSim = requestSim;
	}
	public String getRequestTypeStr() {
		return requestTypeStr;
	}
	public void setRequestTypeStr(String requestTypeStr) {
		this.requestTypeStr = requestTypeStr;
	}
	public String getRejectReason() {
		return rejectReason;
	}
	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}
	
}
