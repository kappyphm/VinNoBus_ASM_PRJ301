/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.model.entity;

import module.core.annotation.Column;
import module.core.annotation.PK;
import module.core.annotation.Table;

/**
 *
 * @author kappyphm
 */
@Table(name = "staff")
public class Staff {

//    user_id VARCHAR(128) NOT NULL UNIQUE,
//    staff_code VARCHAR(50) NOT NULL UNIQUE,
//    position NVARCHAR(100) NULL,
//    department NVARCHAR(100) NULL,
    @PK
    @Column(name = "user_id")
    private String userId;

    @Column(name = "staff_code")
    private String staffCode;

    @Column(name = "position")
    private String position;

    @Column(name = "department")
    private String department;

    public Staff() {
    }

    public Staff(String userId, String staffCode, String position, String department) {
        this.userId = userId;
        this.staffCode = staffCode;
        this.position = position;
        this.department = department;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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
