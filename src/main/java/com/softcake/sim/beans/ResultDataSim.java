package com.softcake.sim.beans;

import java.io.Serializable;
import java.util.List;

public class ResultDataSim implements Serializable {

	private static final long serialVersionUID = 7218368000404978727L;
	
	private List<Sim> sims;
	private int cnt;
	
	public List<Sim> getSims() {
		return sims;
	}
	public void setSims(List<Sim> sims) {
		this.sims = sims;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
}
