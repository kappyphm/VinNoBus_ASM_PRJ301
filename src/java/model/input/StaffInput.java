/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.input;

/**
 *
 * @author kappyphm
 */
// StaffInput.java
public class StaffInput {

    private int staffId;
    private String staffCode;
    private String department;
    private String position;
    private boolean isActive;

    public String getStaffCode() {
        return staffCode;
    }

    // getters + setters
    public void setStaffCode(String staffCode) {
        this.staffCode = staffCode;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

}
