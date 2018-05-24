package com.softcake.sim.beans;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class RequestSim extends BaseDomain implements Serializable {

	private static final long serialVersionUID = -5086627613902240209L;
	private String simNumber;
	private String requestStatus;
	private String merchantId;
	private Date recievedDate;
	private int sumNumber;
	private String activeStatus;
	private BigDecimal price;
	private String creditTerm;
	private List<String> exceptSimNumber;
	private List<String> exceptStatus;
	
	public String getSimNumber() {
		return simNumber;
	}
	public void setSimNumber(String simNumber) {
		this.simNumber = simNumber;
	}
	public String getRequestStatus() {
		return requestStatus;
	}
	public void setRequestStatus(String requestStatus) {
		this.requestStatus = requestStatus;
	}
	public String getMerchantId() {
		return merchantId;
	}
	public void setMerchantId(String merchantId) {
		this.merchantId = merchantId;
	}
	public Date getRecievedDate() {
		return recievedDate;
	}
	public void setRecievedDate(Date recievedDate) {
		this.recievedDate = recievedDate;
	}
	public int getSumNumber() {
		return sumNumber;
	}
	public void setSumNumber(int sumNumber) {
		this.sumNumber = sumNumber;
	}
	public String getActiveStatus() {
		return activeStatus;
	}
	public void setActiveStatus(String activeStatus) {
		this.activeStatus = activeStatus;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public String getCreditTerm() {
		return creditTerm;
	}
	public void setCreditTerm(String creditTerm) {
		this.creditTerm = creditTerm;
	}
	public List<String> getExceptSimNumber() {
		return exceptSimNumber;
	}
	public void setExceptSimNumber(List<String> exceptSimNumber) {
		this.exceptSimNumber = exceptSimNumber;
	}
	public List<String> getExceptStatus() {
		return exceptStatus;
	}
	public void setExceptStatus(List<String> exceptStatus) {
		this.exceptStatus = exceptStatus;
	}
}
