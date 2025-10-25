package model.entity;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Represents a user's personal profile details. This entity holds general user
 * information shared by both Staff and Customer roles.
 *
 * <p>
 * <b>OOP Relationship:</b></p>
 * <ul>
 * <li><b>Association</b> with {@link User}: one user has one profile.</li>
 * <li><b>Composition</b>: if the user is deleted, the profile should also be
 * deleted.</li>
 * </ul>
 *
 * <p>
 * Mapped to the <code>user_profile</code> table in the database.</p>
 */
public class Profile {

    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private String avatarUrl;
    private Date dateOfBirth;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    /**
     * Default constructor.
     */
    public Profile() {
    }

    // region Getters and Setters


    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
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

}
