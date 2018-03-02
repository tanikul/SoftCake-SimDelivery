package com.softcake.sim.beans;

import java.io.Serializable;

public class RoleJson implements Serializable {

    private static final long serialVersionUID = -775702700619348041L;
    
    private int roleId;
    
    private String roleName;
    
    public RoleJson(){}
    
    public RoleJson(int roleId, String roleName){
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
}
