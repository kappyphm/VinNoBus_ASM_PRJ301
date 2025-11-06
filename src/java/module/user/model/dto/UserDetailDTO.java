/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.model.dto;

import java.util.Date;

/**
 *
 * @author kappyphm
 */
public class UserDetailDTO {

    private String userId;
    private boolean active;

    private String name;
    private String email;
    private String phone;
    private String avatarUrl;
    private Date dob;
    private String address;

    private StaffDTO staff;
    private CustomerDTO customer;

    public UserDetailDTO() {
    }

    public UserDetailDTO(String userId, boolean active, String name, String email, String phone, String avatarUrl, Date dob, String address) {
        this.userId = userId;
        this.active = active;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.avatarUrl = avatarUrl;
        this.dob = dob;
        this.address = address;
    }

    public StaffDTO getStaff() {
        return staff;
    }

    public void setStaff(StaffDTO staff) {
        this.staff = staff;
    }

    public CustomerDTO getCustomer() {
        return customer;
    }

    public void setCustomer(CustomerDTO customer) {
        this.customer = customer;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean isActive) {
        this.active = isActive;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

}
