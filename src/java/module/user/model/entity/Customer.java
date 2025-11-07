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
@Table(name = "customer")
public class Customer {

    @PK
    @Column(name = "user_id")
    private String userId;
    @Column(name = "membership_level")
    private String membershipLevel;
    @Column(name = "loyalty_points")
    private int loyaltyPoints;

    public Customer() {
    }

    public Customer(String userId, String membershipLevel, int loyaltyPoints) {
        this.userId = userId;
        this.membershipLevel = membershipLevel;
        this.loyaltyPoints = loyaltyPoints;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getMembershipLevel() {
        return membershipLevel;
    }

    public void setMembershipLevel(String membershipLevel) {
        this.membershipLevel = membershipLevel;
    }

    public int getLoyaltyPoints() {
        return loyaltyPoints;
    }

    public void setLoyaltyPoints(int loyaltyPoints) {
        this.loyaltyPoints = loyaltyPoints;
    }

}
