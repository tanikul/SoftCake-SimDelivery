package com.softcake.sim.beans;

import java.io.Serializable;

public class ProgramJson implements Serializable {
	
	private static final long serialVersionUID = 7854723965733134302L;
	private int programId;
	private String programName;
	private String programRef;
	private int programLevel;
	private String programGroup;
	private int groupLevel;
	private String programType;
	private String elementId;
	private String position;
	
	public ProgramJson(){}
	
	public ProgramJson(int programId, String programName, String programRef, int programLevel, String programGroup, int groupLevel, String programType, String elementId, String position){
		this.setProgramId(programId);
		this.setProgramName(programName);
		this.setProgramRef(programRef);
		this.setProgramLevel(programLevel);
		this.setProgramGroup(programGroup);
		this.setGroupLevel(groupLevel);
		this.setProgramType(programType);
		this.setElementId(elementId);
		this.setPosition(position);
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

	public String getProgramType() {
		return programType;
	}

	public void setProgramType(String programType) {
		this.programType = programType;
	}

	public String getElementId() {
		return elementId;
	}

	public void setElementId(String elementId) {
		this.elementId = elementId;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
	
}
