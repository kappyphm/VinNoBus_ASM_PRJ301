/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.model.dto;

/**
 *
 * @author kappyphm
 */
public class CustomerDTO {

    private String membershipLevel;
    private int loyaltyPoints;

    public CustomerDTO(String membershipLevel, int loyaltyPoints) {
        this.membershipLevel = membershipLevel;
        this.loyaltyPoints = loyaltyPoints;
    }

    public CustomerDTO() {
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
