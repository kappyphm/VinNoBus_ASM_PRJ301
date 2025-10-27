package module.auth.model.entity;

import java.sql.Timestamp;
import java.util.Optional;
import module.user.model.entity.Profile;

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

    private String userId;

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

    // region Getters and Setters
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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
