package model.entity;

import java.sql.Timestamp;
import java.util.Optional;

/**
 * Represents a system user entity. This is the root entity that connects to
 * other sub-entities like {@link Profile}, {@link Staff}, and {@link Customer}.
 *
 * <p>
 * <b>OOP Relationship:</b></p>
 * <ul>
 * <li><b>Association</b> with {@link Profile} — User has a Profile (1:1).</li>
 * <li><b>Composition</b> conceptually — if a User is deleted, its Profile,
 * Staff, or Customer should also be deleted.</li>
 * <li><b>Dependency</b> — UserService depends on this entity to provide user
 * operations.</li>
 * </ul>
 *
 * <p>
 * This class is mapped directly to the <code>user_account</code> table in the
 * database.</p>
 *
 * @author
 * @version 1.0
 */
public class User {

    private int userId;

    private String firebaseUid;

    private String role;

    private boolean isActive;

    private Timestamp createdAt;

    private Timestamp updatedAt;

    /**
     * Optional reference to the user's profile. This is a <b>weak
     * association</b>: it’s only loaded when necessary.
     */
    private Optional<Profile> profile = Optional.empty();

    /**
     * Default constructor.
     */
    public User() {
    }

    /**
     * Full constructor.
     */
    public User(int userId, String firebaseUid, String role, boolean isActive,
            Timestamp createdAt, Timestamp updatedAt) {
        this.userId = userId;
        this.firebaseUid = firebaseUid;
        this.role = role;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // region Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFirebaseUid() {
        return firebaseUid;
    }

    public void setFirebaseUid(String firebaseUid) {
        this.firebaseUid = firebaseUid;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
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

    public Optional<Profile> getProfile() {
        return profile;
    }

    public void setProfile(Optional<Profile> profile) {
        this.profile = profile;
    }
    // endregion
}
