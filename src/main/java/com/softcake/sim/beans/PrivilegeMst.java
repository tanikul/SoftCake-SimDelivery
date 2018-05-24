package com.softcake.sim.beans;

import java.io.Serializable;

public class PrivilegeMst extends BaseDomain implements Serializable {

	private static final long serialVersionUID = -3290512593233755814L;
	private int roleId;
	private int programId;
	private String maker;
	private String checker;
	private String viewer;
	
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public int getProgramId() {
		return programId;
	}
	public void setProgramId(int programId) {
		this.programId = programId;
	}
	public String getMaker() {
		return maker;
	}
	public void setMaker(String maker) {
		this.maker = maker;
	}
	public String getChecker() {
		return checker;
	}
	public void setChecker(String checker) {
		this.checker = checker;
	}
	public String getViewer() {
		return viewer;
	}
	public void setViewer(String viewer) {
		this.viewer = viewer;
	}
	public String toJson() {
		return "{ \"roleId\":\"" + roleId + "\", \"programId\":\"" + programId + "\", \"maker\":\"" + maker + "\", \"checker\":\"" + checker + "\", \"viewer\":\"" + viewer + "\"}";
	}

	@Override
	public String toString() {
		return "PrivilegeMst [roleId=" + roleId + ", programId=" + programId + ", maker=" + maker + ", checker="
				+ checker + ", viewer=" + viewer + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((checker == null) ? 0 : checker.hashCode());
		result = prime * result + ((maker == null) ? 0 : maker.hashCode());
		result = prime * result + programId;
		result = prime * result + roleId;
		result = prime * result + ((viewer == null) ? 0 : viewer.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PrivilegeMst other = (PrivilegeMst) obj;
		if (checker == null) {
			if (other.checker != null)
				return false;
		} else if (!checker.equals(other.checker))
			return false;
		if (maker == null) {
			if (other.maker != null)
				return false;
		} else if (!maker.equals(other.maker))
			return false;
		if (programId != other.programId)
			return false;
		if (roleId != other.roleId)
			return false;
		if (viewer == null) {
			if (other.viewer != null)
				return false;
		} else if (!viewer.equals(other.viewer))
			return false;
		return true;
	}
	
}
