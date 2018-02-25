package com.softcake.sim.beans;

public class RoleMst extends BaseDomain {
	
	
	/**
	 * 
  ROLE_ID INTEGER IDENTITY PRIMARY KEY,
  ROLE_NAME varchar(255) NOT NULL,
  ROLE_TYPE varchar(4) NOT NULL,
  ACTIVE_STATUS char(1) NOT NULL,
  CREATED_DATE datetime NOT NULL,
  CREATED_BY varchar(120) NOT NULL,
  LAST_UPDATED_DATE datetime NOT NULL,
  LAST_UPDATED_BY varchar(120) NOT NULL
	 */
	private static final long serialVersionUID = -775702700619348041L;
	private int roleId;
	private String roleName;
	private String roleType;
	private String activeStatus;
	private boolean disableDeleteFlg;
	
	public RoleMst(){}
	
	public RoleMst(int roleId, String roleName){
		this.setRoleId(roleId);
		this.setRoleName(roleName);
	}
	
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getRoleType() {
		return roleType;
	}
	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
	public String getActiveStatus() {
		return activeStatus;
	}
	public void setActiveStatus(String roleStatus) {
		this.activeStatus = roleStatus;
	}
	
	public boolean isDisableDeleteFlg() {
		return disableDeleteFlg;
	}
	public void setDisableDeleteFlg(boolean deleteFlg) {
		this.disableDeleteFlg = deleteFlg;
	}

	public String toJson() {
		return "\"RoleMst\" : { \"roleId\":\"" + roleId + "\", \"roleName\":\"" + roleName + "\", \"roleType\":\"" + roleType + "\", \"activeStatus\":\"" + activeStatus + "\", \"disableDeleteFlg\":\"" + disableDeleteFlg + "\"} ";
	}
	@Override
	public String toString() {
		return "RoleMst [roleId=" + roleId + ", roleName=" + roleName + ", roleType=" + roleType + ", activeStatus="
				+ activeStatus + ", disableDeleteFlg=" + disableDeleteFlg + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((activeStatus == null) ? 0 : activeStatus.hashCode());
		result = prime * result + (disableDeleteFlg ? 1231 : 1237);
		result = prime * result + ((roleName == null) ? 0 : roleName.hashCode());
		result = prime * result + ((roleType == null) ? 0 : roleType.hashCode());
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
		RoleMst other = (RoleMst) obj;
		if (activeStatus == null) {
			if (other.activeStatus != null)
				return false;
		} else if (!activeStatus.equals(other.activeStatus))
			return false;
		if (disableDeleteFlg != other.disableDeleteFlg)
			return false;
		if (roleName == null) {
			if (other.roleName != null)
				return false;
		} else if (!roleName.equals(other.roleName))
			return false;
		if (roleType == null) {
			if (other.roleType != null)
				return false;
		} else if (!roleType.equals(other.roleType))
			return false;
		return true;
	}
	
	
	
	

}
