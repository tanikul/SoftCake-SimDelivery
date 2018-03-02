package com.softcake.sim.beans;

import java.io.Serializable;

public class Predict extends BaseDomain implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5856826803100472572L;
	private int predictId;
	private String predictContent;
	
	public int getPredictId() {
		return predictId;
	}
	public void setPredictId(int predictId) {
		this.predictId = predictId;
	}
	public String getPredictContent() {
		return predictContent;
	}
	public void setPredictContent(String predictContent) {
		this.predictContent = predictContent;
	}
	
}
