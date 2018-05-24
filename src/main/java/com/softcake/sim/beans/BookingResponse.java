package com.softcake.sim.beans;

import java.math.BigDecimal;
import java.util.Date;

public class BookingResponse {

	private String bookingId;
	private String bookingStatus;
	private BigDecimal sumPrice;
	private String bookingDetailId;
	private String simNumber;
	private String activateFlag;
	private Date effectiveDate;
	private BigDecimal price;
	private String customerId;
	private String rejectReson;
	private String slip;
	private String merchantId;
	
	public String getBookingId() {
		return bookingId;
	}
	public void setBookingId(String bookingId) {
		this.bookingId = bookingId;
	}
	public String getBookingStatus() {
		return bookingStatus;
	}
	public void setBookingStatus(String bookingStatus) {
		this.bookingStatus = bookingStatus;
	}
	public BigDecimal getSumPrice() {
		return sumPrice;
	}
	public void setSumPrice(BigDecimal sumPrice) {
		this.sumPrice = sumPrice;
	}
	public String getBookingDetailId() {
		return bookingDetailId;
	}
	public void setBookingDetailId(String bookingDetailId) {
		this.bookingDetailId = bookingDetailId;
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
	public String getRejectReson() {
		return rejectReson;
	}
	public void setRejectReson(String rejectReson) {
		this.rejectReson = rejectReson;
	}
	public String getSlip() {
		return slip;
	}
	public void setSlip(String slip) {
		this.slip = slip;
	}
	public String getMerchantId() {
		return merchantId;
	}
	public void setMerchantId(String merchantId) {
		this.merchantId = merchantId;
	}
	
}
