package module.user.model.entity;

import java.sql.Timestamp;

/**
 * Represents a customer account in the system.
 *
 * <p>
 * <b>OOP Relationship:</b></p>
 * <ul>
 * <li><b>Association</b> with {@link User}: each customer is linked to one User
 * record.</li>
 * <li><b>Composition</b>: customer cannot exist without its user.</li>
 * </ul>
 *
 * <p>
 * Mapped to the <code>customer_account</code> table.</p>
 */
public class Customer {

    private String userId;
    private int loyaltyPoints;
    private String membershipLevel;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    /**
     * Default constructor.
     */
    public Customer() {
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    // endregion

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
