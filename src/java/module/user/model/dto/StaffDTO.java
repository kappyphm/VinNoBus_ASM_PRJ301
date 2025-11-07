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

    private String position;

    private String department;

    public StaffDTO(String staffCode, String position, String department) {
        this.staffCode = staffCode;
        this.position = position;
        this.department = department;
    }

    public StaffDTO() {
    }

    public String getStaffCode() {
        return staffCode;
    }

    public void setStaffCode(String staffCode) {
        this.staffCode = staffCode;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

}
