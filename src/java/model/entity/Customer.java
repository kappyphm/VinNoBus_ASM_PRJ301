package model.entity;

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

    private int customerId;
    private int userId;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    /**
     * Default constructor.
     */
    public Customer() {
    }

    // region Getters and Setters
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
}
