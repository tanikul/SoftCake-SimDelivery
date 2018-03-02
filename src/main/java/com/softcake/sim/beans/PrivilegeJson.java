package com.softcake.sim.beans;

import java.io.Serializable;

public class PrivilegeJson implements Serializable {
    
    private static final long serialVersionUID = -6502261003015095025L;
    private int roleId;
    private int programId;
    private String maker;
    private String checker;
    private String viewer;
    private ProgramJson programJson;
    
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
    public ProgramJson getProgramJson() {
        return programJson;
    }
    public void setProgramJson(ProgramJson programJson) {
        this.programJson = programJson;
    }
}
