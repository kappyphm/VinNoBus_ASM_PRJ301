package UserModule.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.UUID;
import UserModule.model.entity.AuthProvider;

/**
 * DAO interface for managing CRUD operations of AuthProvider. AuthProvider is
 * associated with User for multi-auth support (LOCAL, GOOGLE, etc.).
 */
public interface IAuthProviderDAO {

    void save(AuthProvider authProvider) throws SQLException;

    void update(AuthProvider authProvider) throws SQLException;

    void delete(int id) throws SQLException;

    /**
     * Deletes all AuthProviders associated with a User. Used in cascade when
     * User is deleted.
     *
     * @param userId the UUID of the User
     * @throws SQLException if a database access error occurs
     */
    void deleteByUserId(UUID userId) throws SQLException;

    AuthProvider findById(int id) throws SQLException;

    /**
     * Retrieves all AuthProviders of a User.
     *
     * @param userId the UUID of the User
     * @return list of AuthProviders
     * @throws SQLException if a database access error occurs
     */
    List<AuthProvider> findByUserId(UUID userId) throws SQLException;

    /**
     * Finds an AuthProvider by provider type and provider UID. Used for OAuth
     * login (e.g., Google/Firebase UID).
     *
     * @param provider provider name (LOCAL, GOOGLE, etc.)
     * @param providerUid UID from provider
     * @return AuthProvider object, or null if not found
     * @throws SQLException if a database access error occurs
     */
    AuthProvider findByProviderUid(String provider, String providerUid) throws SQLException;
}
