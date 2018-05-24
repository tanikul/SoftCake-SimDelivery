package com.softcake.sim.beans;

import java.io.Serializable;

public class Province implements Serializable {

	private static final long serialVersionUID = -2274096241534179946L;
	private int provinceId;
	private String provinceName;
	
	public int getProvinceId() {
		return provinceId;
	}
	public void setProvinceId(int provinceId) {
		this.provinceId = provinceId;
	}
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}
	
}
