/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.model.dto;

/**
 *
 * @author kappyphm
 */
public class StaffDTO {

    private String staffCode;
    private String department;
    private String position;

    public StaffDTO() {
    }

    public StaffDTO(String staffCode, String department, String position) {
        this.staffCode = staffCode;
        this.department = department;
        this.position = position;
    }

    public String getStaffCode() {
        return staffCode;
    }

    public void setStaffCode(String staffCode) {
        this.staffCode = staffCode;
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

}
