package com.softcake.sim.beans;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class BookingDetail extends BaseDomain implements Serializable {

	private static final long serialVersionUID = 6471290860551371104L;

	private String bookingDetailId;
	private String bookingId;
	private String simNumber;
	private String activateFlag;
	private Date effectiveDate;
	private BigDecimal price;
	private String priceStr;
	private String customerId;
	private String authorizedBy;
	private Date authorizedDate;
	private int creditTerm;
	private String rejectReason;
	
	public String getBookingDetailId() {
		return bookingDetailId;
	}
	public void setBookingDetailId(String bookingDetailId) {
		this.bookingDetailId = bookingDetailId;
	}
	public String getBookingId() {
		return bookingId;
	}
	public void setBookingId(String bookingId) {
		this.bookingId = bookingId;
	}
	public String getSimNumber() {
		return simNumber;
	}
	public void setSimNumber(String simNumber) {
		this.simNumber = simNumber;
	}
	public String getActivateFlag() {
		return activateFlag;
	}
	public void setActivateFlag(String activateFlag) {
		this.activateFlag = activateFlag;
	}
	public Date getEffectiveDate() {
		return effectiveDate;
	}
	public void setEffectiveDate(Date effectiveDate) {
		this.effectiveDate = effectiveDate;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getAuthorizedBy() {
		return authorizedBy;
	}
	public void setAuthorizedBy(String authorizedBy) {
		this.authorizedBy = authorizedBy;
	}
	public Date getAuthorizedDate() {
		return authorizedDate;
	}
	public void setAuthorizedDate(Date authorizedDate) {
		this.authorizedDate = authorizedDate;
	}
	public int getCreditTerm() {
		return creditTerm;
	}
	public void setCreditTerm(int creditTerm) {
		this.creditTerm = creditTerm;
	}
	public String getRejectReason() {
		return rejectReason;
	}
	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}
	public String getPriceStr() {
		return priceStr;
	}
	public void setPriceStr(String priceStr) {
		this.priceStr = priceStr;
	}
	
}
