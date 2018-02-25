package com.softcake.sim.beans;

import java.io.Serializable;

public class ProgramMst extends BaseDomain implements Serializable {
	
	
	/**
	 * 
  PROGRAM_ID INTEGER IDENTITY PRIMARY KEY,
  PROGRAM_NAME varchar(255) NOT NULL,
  PROGRAM_REF varchar(255) NOT NULL,
  PROGRAM_TYPE varchar(4) NOT NULL,
  PROGRAM_LEVEL INT  NOT NULL,
  PROGRAM_GROUP varchar(255) NOT NULL,
  GROUP_LEVEL INT  NOT NULL,
  VIEWER char(1) NOT NULL,
  MAKER char(1) NOT NULL,
  CHECKER char(1) NOT NULL,
  ACTIVE_STATUS char(1) NOT NULL,
  CREATED_DATE datetime NOT NULL,
  CREATED_BY varchar(120) NOT NULL,
  LAST_UPDATED_DATE datetime NOT NULL,
  LAST_UPDATED_BY varchar(120) NOT NULL

	 */
	private static final long serialVersionUID = -775702700619348041L;
	private int programId;
	private String programName;
	private String programRef;
	private String programType;
	private int programLevel;
	private String programGroup;
	private int groupLevel;
	private String viewer;
	private String maker;
	private String checker;
	private String none;
	private String defaultViewer;
	private String defaultMaker;
	private String defaultChecker;
	private String mode;
	private int roleId;
	
	
	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public String getNone() {
		return none;
	}

	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getDefaultViewer() {
		return defaultViewer;
	}
	public void setDefaultViewer(String defaultViewer) {
		this.defaultViewer = defaultViewer;
	}
	public String getDefaultMaker() {
		return defaultMaker;
	}
	public void setDefaultMaker(String defaultMaker) {
		this.defaultMaker = defaultMaker;
	}
	public String getDefaultChecker() {
		return defaultChecker;
	}
	public void setDefaultChecker(String defaultChecker) {
		this.defaultChecker = defaultChecker;
	}
	public void setNone(String none) {
		this.none = none;
	}
	private String activeStatus;
	
	public ProgramMst(){}
	
	public ProgramMst(int programId, String programName, String programRef, String programType, int programLevel, String programGroup, int groupLevel, String activeStatus){
		this.setProgramId(programId);
		this.setProgramName(programName);
		this.setProgramRef(programRef);
		this.setProgramType(programType);
		this.setProgramLevel(programLevel);
		this.setProgramGroup(programGroup);
		this.setActiveStatus(activeStatus);
		this.setGroupLevel(groupLevel);
	}
	
	public int getProgramId() {
		return programId;
	}
	public void setProgramId(int programId) {
		this.programId = programId;
	}
	public String getProgramName() {
		return programName;
	}
	public void setProgramName(String programName) {
		this.programName = programName;
	}
	public String getProgramRef() {
		return programRef;
	}
	public void setProgramRef(String programRef) {
		this.programRef = programRef;
	}
	public String getProgramType() {
		return programType;
	}
	public void setProgramType(String programType) {
		this.programType = programType;
	}
	public int getProgramLevel() {
		return programLevel;
	}
	public void setProgramLevel(int programLevel) {
		this.programLevel = programLevel;
	}
	public String getProgramGroup() {
		return programGroup;
	}
	public void setProgramGroup(String programGroup) {
		this.programGroup = programGroup;
	}
	public int getGroupLevel() {
		return groupLevel;
	}
	public void setGroupLevel(int groupLevel) {
		this.groupLevel = groupLevel;
	}
	public String getViewer() {
		return viewer;
	}
	public void setViewer(String viewer) {
		this.viewer = viewer;
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
	public String getActiveStatus() {
		return activeStatus;
	}
	public void setActiveStatus(String activeStatus) {
		this.activeStatus = activeStatus;
	}
	@Override
	public String toString() {
		return "ProgramMst [programId=" + programId + ", programName=" + programName + ", programRef=" + programRef
				+ ", programType=" + programType + ", programLevel=" + programLevel + ", programGroup=" + programGroup
				+ ", groupLevel=" + groupLevel + ", viewer=" + viewer + ", maker=" + maker + ", checker=" + checker
				+ ", none=" + none + ", defaultViewer=" + defaultViewer + ", defaultMaker=" + defaultMaker
				+ ", defaultChecker=" + defaultChecker + ", activeStatus=" + activeStatus + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((activeStatus == null) ? 0 : activeStatus.hashCode());
		result = prime * result + ((checker == null) ? 0 : checker.hashCode());
		result = prime * result + ((defaultChecker == null) ? 0 : defaultChecker.hashCode());
		result = prime * result + ((defaultMaker == null) ? 0 : defaultMaker.hashCode());
		result = prime * result + ((defaultViewer == null) ? 0 : defaultViewer.hashCode());
		result = prime * result + groupLevel;
		result = prime * result + ((maker == null) ? 0 : maker.hashCode());
		result = prime * result + ((none == null) ? 0 : none.hashCode());
		result = prime * result + ((programGroup == null) ? 0 : programGroup.hashCode());
		result = prime * result + programLevel;
		result = prime * result + ((programName == null) ? 0 : programName.hashCode());
		result = prime * result + ((programRef == null) ? 0 : programRef.hashCode());
		result = prime * result + ((programType == null) ? 0 : programType.hashCode());
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
		ProgramMst other = (ProgramMst) obj;
		if (activeStatus == null) {
			if (other.activeStatus != null)
				return false;
		} else if (!activeStatus.equals(other.activeStatus))
			return false;
		if (checker == null) {
			if (other.checker != null)
				return false;
		} else if (!checker.equals(other.checker))
			return false;
		if (defaultChecker == null) {
			if (other.defaultChecker != null)
				return false;
		} else if (!defaultChecker.equals(other.defaultChecker))
			return false;
		if (defaultMaker == null) {
			if (other.defaultMaker != null)
				return false;
		} else if (!defaultMaker.equals(other.defaultMaker))
			return false;
		if (defaultViewer == null) {
			if (other.defaultViewer != null)
				return false;
		} else if (!defaultViewer.equals(other.defaultViewer))
			return false;
		if (groupLevel != other.groupLevel)
			return false;
		if (maker == null) {
			if (other.maker != null)
				return false;
		} else if (!maker.equals(other.maker))
			return false;
		if (none == null) {
			if (other.none != null)
				return false;
		} else if (!none.equals(other.none))
			return false;
		if (programGroup == null) {
			if (other.programGroup != null)
				return false;
		} else if (!programGroup.equals(other.programGroup))
			return false;
		if (programLevel != other.programLevel)
			return false;
		if (programName == null) {
			if (other.programName != null)
				return false;
		} else if (!programName.equals(other.programName))
			return false;
		if (programRef == null) {
			if (other.programRef != null)
				return false;
		} else if (!programRef.equals(other.programRef))
			return false;
		if (programType == null) {
			if (other.programType != null)
				return false;
		} else if (!programType.equals(other.programType))
			return false;
		if (viewer == null) {
			if (other.viewer != null)
				return false;
		} else if (!viewer.equals(other.viewer))
			return false;
		return true;
	}

	
	
	
	

}
