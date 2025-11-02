package module.user.model.dto;

/**
 *
 * @author kappyphm
 */
public class CustomerDTO {

    private int loyaltyPoints;
    private String membershipLevel;

    public CustomerDTO() {
    }

    public CustomerDTO(int loyaltyPoints, String membershipLevel) {
        this.loyaltyPoints = loyaltyPoints;
        this.membershipLevel = membershipLevel;
    }

    public int getLoyaltyPoints() {
        return loyaltyPoints;
    }

    public void setLoyaltyPoints(int loyaltyPoints) {
        this.loyaltyPoints = loyaltyPoints;
    }

    public String getMembershipLevel() {
        return membershipLevel;
    }

    public void setMembershipLevel(String membershipLevel) {
        this.membershipLevel = membershipLevel;
    }

  
}
